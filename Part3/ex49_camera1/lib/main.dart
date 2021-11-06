import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'dart:io';

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

  final ImagePicker _picker = ImagePicker();

  // image_picker 모듈에서 File 객체 반환. ios에서 에러
  // late File mPhoto;
  File? mPhoto;
  XFile? image;

  @override
  Widget build(BuildContext context) {
    late Widget photo;
    if(mPhoto != null) {
      photo = Image.file(
        mPhoto!,
        fit: BoxFit.contain,  // 작은 쪽에 맞춤
      );
    } else {
      photo = Text('Empty');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text('Album',
                                    style: TextStyle(fontSize: 24)),
                  onPressed: () => takePhoto(ImageSource.gallery), 
                ),
                SizedBox(width: 5,),
                ElevatedButton(
                  child: const Text('Camera',
                                    style: TextStyle(fontSize: 24)),
                  onPressed: () => takePhoto(ImageSource.camera), 
                ),
                SizedBox(width: 5,),
                ElevatedButton(
                  child: const Text('Save',
                                    style: TextStyle(fontSize: 24)),
                  onPressed: () => savePhoto(), 
                ),
                SizedBox(width: 5,),
              ],
            ),
            Expanded(child: photo,)
          ],
        ),
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    image = await _picker.pickImage(source: source);
    setState(() {
      mPhoto = File(image!.path);
    });
  }
  void savePhoto() async {
    if (image != null) {
      GallerySaver.saveImage(image!.path)
        .then((bool? success) {
          print("image saved on gallery....");
        });
    }
  }
}
