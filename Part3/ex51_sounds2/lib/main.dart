import 'package:flutter/material.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'page_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late final PageManager _pageManager;

  @override
  void initState() {
    super.initState();
    _pageManager = PageManager();
  }

  @override
  void dispose() {
    _pageManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder<ProgressBarState>(
              valueListenable: _pageManager.progressNotifier, 
              builder: (_, value, __) {
                return ProgressBar(
                  progress: value.current,
                  buffered: value.buffered,
                  total: value.total,
                  onSeek: _pageManager.seek,
                );
              }
            ),
            ValueListenableBuilder<ButtonState>(
              valueListenable: _pageManager.buttonNotifier, 
              builder: (_, value, __) {
                switch (value) {
                  case ButtonState.loading:
                    return Container(
                      margin: EdgeInsets.all(8.0),
                      width: 32.0,
                      height: 32.0,
                      child: CircularProgressIndicator(),
                    );
                  case ButtonState.paused:
                    return IconButton(
                      icon: Icon(Icons.play_arrow),
                      iconSize: 32.0,
                      onPressed: _pageManager.bSet ? _pageManager.play : null, 
                    );
                  case ButtonState.playing:
                    return IconButton(
                      icon: Icon(Icons.pause),
                      iconSize: 32.0,
                      onPressed: _pageManager.pause, 
                    );
                }
              }
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text('노래 1', 
                                    style: TextStyle(fontSize: 24),),
                  onPressed: () {
                    _pageManager.setSound('assets/sounds/background1.mp3');
                  }, 
                ),
                SizedBox(width: 10,),
                  ElevatedButton(
                  child: const Text('노래 2', 
                                    style: TextStyle(fontSize: 24),),
                  onPressed: () {
                    _pageManager.setSound('assets/sounds/background2.mp3');
                  }, 
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
