import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'dart:math';

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
  LatLng _myLoc = LatLng(0, 0);
  String lat = '';
  String lon = '';
  List<Marker> _markers = [];
  Random _random = new Random();

  // 위도, 경도 계속 구하기
  void getCurrentLocation() {
    // 거리가 5미터 이상 변해야 리스너에 위치가 전달된다.
    Geolocator.getPositionStream(distanceFilter: 10).listen(
      (Position position) async {
        lat = '${position.latitude}';
        lon = '${position.longitude}';
        _myLoc = LatLng(position.latitude, position.longitude);

        final GoogleMapController controller = await _controller.future;
        // 값은 변해있지만, 애니메이션은 별도의 동작을 해줘야 한다.
        controller.moveCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: _myLoc, zoom: 17)
        ));

        // 마커의 위치도 새로운 위치로 옮긴다.
        print('444');
        markerAdd();        
      });
  }

  late BitmapDescriptor customMarker;
  Future<void> setCustomMarker() async {
    customMarker = await BitmapDescriptor.fromAssetImage(
                                    ImageConfiguration(size: Size(48, 48)), 
                                    'assets/images/marker4.png'
    );
  }

  @override
  void initState() {
    super.initState();
    print('111');
    setCustomMarker().then((value) {
      print('222');
      getCurrentLocation();
      print('333');
    });
  }
  
  @override
  Widget build(BuildContext context) {
    print('555');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 400,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(0, 0),
                  zoom: 17.0,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: Set.from(_markers),
              ),
            ),
            Text("$lat $lon"),
          ],
        ),
      ),
    );
  }

  void markerAdd() {
    final marker = Marker(
      markerId: MarkerId('marker'),
      position: _myLoc,
      icon: customMarker,
      onTap: () => callSnackBar('안녕하세요~ 홍길동님!'),
    );

    setState(() {
      print('66');
      _markers.clear();
      _markers.add(marker);
    });
  }

  callSnackBar(msg) {
    int myRandomCount = _random.nextInt(5);
    print(myRandomCount);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          height: 60,
          child: Row(
            children: [
              Image.asset(
                'assets/images/marker3.png',
                width: 60,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(msg, style: TextStyle(color: Colors.black),),
                  Row(
                    children: [
                      IconTheme(
                        data: IconThemeData(
                          color: Colors.red,
                        ),
                        child: Row(
                          children: [
                            IconTheme(
                              data: IconThemeData(
                                color: Colors.red,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: List.generate(5, (index) {
                                  return Icon(index < myRandomCount
                                              ? Icons.star
                                              : Icons.star_border);
                                }),
                              ),
                            )
                          ],
                        ),
                      )
                    ]
                  )
                ],
              ),
            ],
          ),
        ),
        backgroundColor: Colors.yellow[800],
        duration: Duration(milliseconds: 60000),  // 60초
        action: SnackBarAction(
          label: 'Undo', 
          textColor: Colors.black,
          onPressed: () {},
        ),
      )
    );
  }
}
