import 'dart:async';

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
  final Completer<GoogleMapController> _mapController =
  Completer<GoogleMapController>();
  static const LatLng _myPos = LatLng(24.893216, 91.855856);
  static const LatLng _myAppleLoc =
  LatLng(24.893850690446143, 91.85658598730342);
  LatLng? _currentP;

  @override
  void initState() {
    super.initState();
    getLocationUpdates();
  }

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
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) =>
                _mapController.complete(controller),
            initialCameraPosition: _myGooglePlex,
            markers: {
              Marker(
                markerId: MarkerId('Current_Location'),
                icon: BitmapDescriptor.defaultMarker,
                position: _currentP ?? _myPos,
              ),
              Marker(
                markerId: MarkerId('Source_Loc'),
                icon: BitmapDescriptor.defaultMarker,
                position: _myPos,
              ),
              Marker(
                markerId: MarkerId('Destination_Location'),
                icon: BitmapDescriptor.defaultMarker,
                position: _myAppleLoc,
              ),
            }
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: () => animateToCurrentLocation(),
              child: Icon(Icons.my_location),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    await controller.animateCamera(CameraUpdate.newLatLng(pos));
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
    }

    if (!_serviceEnabled) {
      return;
    }

    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
    } else if (_permissionGranted != PermissionStatus.granted) {
      return;
    }

    _locationController.onLocationChanged.listen((LocationData currentLocation) {
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

  void animateToCurrentLocation() {
    if (_currentP != null) {
      _cameraToPosition(_currentP!);
    }
  }
}
