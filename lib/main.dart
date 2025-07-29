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
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
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
}

// To navigate to a specific location, you can use the following method:
// void goToLocation(LatLng location) async {
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
