import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _myPos = LatLng(24.893216, 91.855856);

  @override
  void initState() {
    super.initState();
    _marker.addAll(_list);
    _getLocation();
  }

  List<Marker> _marker = [];
  final List<Marker> _list = const [
    Marker(
      markerId: MarkerId('1'),
      icon: BitmapDescriptor.defaultMarker,
      position: _myPos,
      infoWindow: InfoWindow(
        title: 'My Location',
        snippet: 'This is my Snippet',
      ),
    ),
  ];

  static final CameraPosition _myGooglePlex = const CameraPosition(
    zoom: 15,
    target: LatLng(24.893216, 91.855856),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SafeArea(
        child: GoogleMap(
          zoomControlsEnabled: false,
          initialCameraPosition: _myGooglePlex,
          markers: Set.of(_marker),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.my_location_sharp,
        color: Colors.blueAccent,),
        backgroundColor: Colors.white,
        onPressed: () {
          _getLocation();
        },
      ),
    );
  }

  Future<void> _getLocation() async {
    LocationData locationData;
    var location = Location();

    try {
      locationData = await location.getLocation();
      GoogleMapController controller = await _controller.future;

      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              locationData.latitude!,
              locationData.longitude!,
            ),
            zoom: 19,
          ),
        ),
      );
    } catch (e) {
      print('Error getting location: $e');
    }
  }
}
