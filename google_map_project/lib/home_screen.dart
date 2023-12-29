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
  final Location _locationController = Location();
  final Completer<GoogleMapController> _mapController =
  Completer<GoogleMapController>();

  LatLng? _currentP;
  double _currentHeading = 0.0;

  late StreamSubscription<LocationData> _locationSubscription;

  @override
  void initState() {
    super.initState();
    getLocationUpdates();
    const duration = Duration(seconds: 10);
    Timer.periodic(duration, (Timer t) {
      animateToCurrentLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) =>
            _mapController.complete(controller),
        initialCameraPosition: CameraPosition(
          zoom: 15,
          target: _currentP ?? LatLng(24.893216, 91.855856),
        ),
        markers: {
          Marker(
            markerId: MarkerId('Current_Location'),
            icon: BitmapDescriptor.defaultMarker,
            position: _currentP ?? LatLng(24.893216, 91.855856),
            rotation: _currentHeading,
          ),
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.my_location_sharp,
          color: Colors.blueAccent,
        ),
        backgroundColor: Colors.white,
        onPressed: () {
          animateToCurrentLocation();
        },
      ),
    );
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    await controller.animateCamera(CameraUpdate.newLatLng(pos));
  }

  void getLocationUpdates() {
    getLocation(); // Initial location
    _locationSubscription =
        _locationController.onLocationChanged.listen((LocationData currentLocation) {
          if (currentLocation.latitude != null && currentLocation.longitude != null) {
            setState(() {
              _currentP = LatLng(currentLocation.latitude!, currentLocation.longitude!);
              _currentHeading = currentLocation.heading ?? 0.0;
            });
          }
        });
  }

  void getLocation() async {
    try {
      final LocationData locationData = await _locationController.getLocation();
      if (locationData.latitude != null && locationData.longitude != null) {
        setState(() {
          _currentP = LatLng(locationData.latitude!, locationData.longitude!);
          _currentHeading = locationData.heading ?? 0.0;
        });
      }
    } catch (e) {
      print('error gettimg location: $e');
    }
  }

  void animateToCurrentLocation() {
    if (_currentP != null) {
      _cameraToPosition(_currentP!);
    }
  }

  @override
  void dispose() {
    _locationSubscription.cancel();
    super.dispose();
  }
}
