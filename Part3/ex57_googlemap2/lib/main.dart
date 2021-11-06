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
  LatLng _myLoc = LatLng(37.556230008991925, 126.97244566110622); // 서울역
  List<Marker> _markers = [];
  List<Polyline> _polyLines = [];

  List<Palace> palaces = [
    Palace("경복궁", LatLng(37.581055351303256, 126.97702508989278)),
    Palace("경희궁", LatLng(37.57217297507536, 126.96791622333234)),
    Palace("덕수궁", LatLng(37.565831915199425, 126.97517519837898)),
    Palace("창덕궁", LatLng(37.58240262711135, 126.99299740250515)),
    Palace("창경궁", LatLng(37.57972573643847, 126.9937068254595)),
  ];

  List<double> hue = [
    BitmapDescriptor.hueBlue,
    BitmapDescriptor.hueCyan,
    BitmapDescriptor.hueGreen,
    BitmapDescriptor.hueMagenta,
    BitmapDescriptor.hueRed,
  ];

  void makeMarkerData() {
    int i = 0;
    for (Palace palace in palaces) {
      final marker = Marker(
        markerId: MarkerId(palace.name),
        icon: BitmapDescriptor.defaultMarkerWithHue(hue[i]),
        position: palace.position,
        infoWindow: InfoWindow(
          title: palace.name,
          onTap: () {
            print('onTap: ${palace.name}');
          }
        )
      );

      _markers.add(marker);
      i++;
    }
  }
  
  void markerPolyline() {
    List<LatLng> coordinates = [];
    for(int i=0; i < palaces.length; i++) {
      coordinates.add(LatLng(palaces[i].position.latitude, palaces[i].position.longitude));
    }

    Polyline polyline = Polyline(
      polylineId: PolylineId('poly'),
      patterns: [PatternItem.dash(10), PatternItem.gap(10)],
      color: Colors.red,
      width: 3,
      points: coordinates
    );

    _polyLines.add(polyline);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    makeMarkerData();
    markerPolyline();
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
                initialCameraPosition: CameraPosition(target: _myLoc, zoom: 14.0),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: Set.from(_markers),
                polylines: Set.from(_polyLines),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Palace {
  late final String name;
  late final LatLng position;

  Palace(this.name, this.position);
}
