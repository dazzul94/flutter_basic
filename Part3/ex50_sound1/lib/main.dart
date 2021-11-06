import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

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

  AudioPlayer _audioPlayer = AudioPlayer();

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
            IconButton(
              icon: Icon(Icons.play_circle_filled_outlined),
              iconSize: 60.0,
              color: Colors.pink,
              tooltip: "play 1",
              onPressed: () async {
                await _audioPlayer.setAsset('assets/sounds/01_1_1.mp3')
                .then((value) async {
                  await _audioPlayer.stop().then((value) {
                    _audioPlayer.play();
                  });
                });
              }, 
            ),
            SizedBox(width: 20,),
            IconButton(
              icon: Icon(Icons.play_circle_filled_outlined),
              iconSize: 60.0,
              color: Colors.pink,
              tooltip: "play 2",
              onPressed: () async {
                await _audioPlayer.setAsset('assets/sounds/01_1_2.mp3')
                .then((value) async {
                  await _audioPlayer.stop().then((value) {
                    _audioPlayer.play();
                  });
                });
              }, 
            ),
          ],
        ),
      ),
    );
  }
}
