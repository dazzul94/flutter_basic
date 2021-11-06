import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';

typedef _Fn = void Function();

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

  FlutterSoundPlayer? _mPlayer;
  FlutterSoundRecorder? _mRecorder;

  Codec _codec = Codec.aacMP4;
  String _mPath = 'tau_file.mp4';
  bool _mPlayerIsInited = false;
  bool _mRecorderIsInited = false;
  bool _mPlaybackReady = false;

  @override
  void initState() {
    _mPlayer = FlutterSoundPlayer();
    _mRecorder = FlutterSoundRecorder();

    _mPlayer!.openAudioSession().then((value) {
      setState(() {
        _mPlayerIsInited = true;
      });
    });

    openTheRecorder().then((value) {
      print('dddd');
      _mPlayerIsInited = true;
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    _mPlayer!.closeAudioSession();
    _mPlayer = null;

    _mRecorder!.closeAudioSession();
    _mRecorder = null;

    super.dispose();
  }

  Future<void> openTheRecorder() async {
    print('aaaa');
    await Permission.microphone.request().then((status) {
      if (status != PermissionStatus.granted) {
        print('bbbb: $status');
        throw RecordingPermissionException('Microphone permission not granted');
      }
    });

    await _mRecorder!.openAudioSession().then((value) {
      print('cccc');
      _mRecorderIsInited = true;
    });
  }

  void record() {
    _mRecorder!.startRecorder(
      toFile: _mPath,
      codec: _codec,
      audioSource: AudioSource.microphone,
    )
    .then((value) {
      setState(() {});
    });
  }

  void stopRecorder() async {
    await _mRecorder!.stopRecorder()
    .then((value) {
      setState(() {
        _mPlaybackReady = true;
      });
    });
  }

  void play() {
    _mPlayer!.startPlayer(
      fromURI: _mPath,
      codec: Codec.aacADTS,
      whenFinished: () {
        setState(() {});
      })
      .then((value) {
        setState(() {});
      });
  }

  void stopPlayer() {
    _mPlayer!.stopPlayer()
    .then((value) {
      setState(() {});
    });
  }

  _Fn? getRecorderFn() {
    if (!_mRecorderIsInited || !_mPlayer!.isStopped) {
      print('_mRecorderIsInited: $_mRecorderIsInited');
      print('!_mPlayer!.isStopped: ${_mPlayer!.isStopped}');
    }

    return _mRecorder!.isStopped ? record : stopRecorder;
  }

  _Fn? getPlaybackFn() {
    if (!_mPlayerIsInited || !_mPlaybackReady || !_mRecorder!.isStopped) {
      return null;
    }
    return _mPlayer!.isStopped ? play : stopPlayer;
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
            Container(
              margin: const EdgeInsets.all(3),
              padding: const EdgeInsets.all(3),
              height: 80,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xFFFAF0E6),
                border: Border.all(
                  color: Colors.indigo,
                  width: 3,
                ),
              ),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: getRecorderFn(), 
                    child: Text(_mRecorder!.isRecording ? 'Stop' : 'Record'),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(_mRecorder!.isRecording 
                    ? 'Recording in progress'
                    : 'Recorder is stopped'),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(3),
              padding: const EdgeInsets.all(3),
              height: 80,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xFFFAF0E6),
                border: Border.all(
                  color: Colors.indigo,
                  width: 3,
                ),
              ),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: getPlaybackFn(), 
                    child: Text(_mPlayer!.isPlaying ? 'Stop' : 'Play'),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(_mPlayer!.isPlaying 
                    ? 'Playback in progress'
                    : 'Player is stopped'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
