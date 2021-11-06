import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

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

  Completer<GoogleMapController> _controller = Completer();  
  LatLng _myLoc1 = LatLng(37.556230008991925, 126.97244566110622); // 서울역
  LatLng _myLoc2 = LatLng(37.612116488132294, 126.7327319982053);  // 풍무역

  List<Marker> _markers = [];

  void setMarkerData() {
    final marker1 = Marker(
      markerId: MarkerId('A01'),
      position: _myLoc1,
      infoWindow: InfoWindow(
        title: "서울역",
        snippet: "여기는 서울역입니다.",
        onTap: () {
          print("aaa");
        }
      )
    );

    _markers.add(marker1);

    final marker2 = Marker(
      markerId: MarkerId('A02'),
      position: _myLoc2,
      infoWindow: InfoWindow(
        title: "풍무역",
        snippet: "여기는 풍무역입니다.",
        onTap: () {
          print("bbb");
        }
      )
    );

    _markers.add(marker1);
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
              height: 400,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(target: _myLoc1, zoom: 15.0),
                markers: Set.from(_markers),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
            SizedBox(width: 10,),
            ElevatedButton(
              child: const Text('풍무역 이동', style: TextStyle(fontSize: 24)),
              onPressed: () => goToLocation(_myLoc2), 
            )
          ],
        ),
      ),
    );
  }

  Future<void> goToLocation(LatLng loc) async {
    final GoogleMapController controller = await _controller.future;

    final CameraPosition pos = CameraPosition(
      target: loc,
      zoom: 15,
    );

    controller.animateCamera(CameraUpdate.newCameraPosition(pos));
  }
}
