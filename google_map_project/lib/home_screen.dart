
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Location _locationController = Location();
  static const LatLng _myPos = LatLng(24.893216, 91.855856);
  static const LatLng _myAppleLoc =
      LatLng(23.792265009916146, 90.80561575869223);
  LatLng? _currentP = null;

  @override
  void initState() {
    super.initState();
    getLocationUpdates();
  }

  static final CameraPosition _myGoolglePlex = const CameraPosition(
      zoom: 19, target: LatLng(24.893216, 91.855856), bearing: 0, tilt: 5);

  static final CameraPosition _mAppleePlex = const CameraPosition(
      zoom: 19,
      target: LatLng(23.792265009916146, 90.80561575869223),
      bearing: 0,
      tilt: 5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: GoogleMap(initialCameraPosition: _myGoolglePlex, markers: {
        Marker(
          markerId: MarkerId('Current_Location'),
          icon: BitmapDescriptor.defaultMarker,
          position: _myPos,
        ),
        Marker(
          markerId: MarkerId('Source_Location'),
          icon: BitmapDescriptor.defaultMarker,
          position: _myAppleLoc,
        ),
      }),
    );
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled = await _locationController.serviceEnabled();
    if (_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }
    _permissionGranted =
    await _locationController.hasPermission();

    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted =
          await _locationController.requestPermission();
    } else if (_permissionGranted != PermissionStatus.granted) {
      return;
    }

    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentP =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
        });
        print(_currentP);
      }
    });
  }
}
