import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  String _mapStyle = '';
  final Set<Marker> _markers = {};
  BitmapDescriptor? _pinMarker;

  @override
  void initState() {
    super.initState();
    _loadMapStyle();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(30.0444, 31.2357),
            zoom: 14.4746,
          ),
          style: _mapStyle,
          markers: _markers,
          onMapCreated: (GoogleMapController controller) async {
            _controller.complete(controller);
            await _loadPinMarker();
            _markers.add(
              Marker(
                markerId: MarkerId('Id1'),
                position: LatLng(30.0444, 31.2357),
                onTap: () {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Hello World!')));
                },
                icon: _pinMarker ?? BitmapDescriptor.defaultMarker,
              ),
            );
          },
        ),
      ),
    );
  }

  void _loadMapStyle() async {
    final style = await DefaultAssetBundle.of(
      context,
    ).loadString('assets/map_style.json');
    setState(() {
      _mapStyle = style;
    });
  }

  Future _loadPinMarker() async {
    final pin = await BitmapDescriptor.asset(
      ImageConfiguration(size: Size(48, 48)),
      'assets/pin_marker.png',
    );
    setState(() {
      _pinMarker = pin;
    });
  }
}

// To navigate to a specific location, you can use the following method:
// Future goToLocation(LatLng location) async {
//   final GoogleMapController controller = await _controller.future;
//   controller.animateCamera(
//     CameraUpdate.newCameraPosition(
//       CameraPosition(
//         target: location,
//         zoom: 14.4746,
//       ),
//     ),
//   );
// }

// Best practice for markers is to make a set of them
// and manage them in a stateful widget, allowing for dynamic updates.
