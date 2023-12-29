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
  final MarkerId _markerId = const MarkerId('CurrentLocation');
  final PolylineId _polylineId = const PolylineId('UserPolyLine');
  GoogleMapController? _controller;


  final List<LatLng> _polylinePoints = [];

  late StreamSubscription<LocationData> _locationSubscription;

  @override
  void initState() {
    super.initState();
    getLocationUpdates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('My Google Map'),
      ),
      body: SafeArea(
        child: GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            _mapController.complete(controller);
            _controller = controller;
          },
          initialCameraPosition: CameraPosition(
            zoom: 15,
            target: _currentP ?? LatLng(24.893216, 91.855856),
          ),
          markers: {
            Marker(
              markerId: _markerId,
              icon: BitmapDescriptor.defaultMarker,
              position: _currentP ?? LatLng(0, 0),
              rotation: _currentHeading,
              infoWindow: InfoWindow(
                title: 'My Current Location',
                snippet:
                    'Latitude: ${_currentP?.latitude}, Longitude: ${_currentP?.longitude}',
              ),
            ),
          },
          polylines: {
            Polyline(
              polylineId: _polylineId,
              points: _polylinePoints,
              color: Colors.blue,
              width: 5,
            ),
          },
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          compassEnabled: true,
          zoomControlsEnabled: false,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          animateToCurrentLocation();
        },
        child: const Icon(
          Icons.my_location_sharp,
          color: Colors.blueAccent,
        ),
      ),
    );
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    if (_controller != null) {
      await _controller!.animateCamera(CameraUpdate.newLatLng(pos));
    }
  }

  void getLocationUpdates() {
    getLocation();
    _locationSubscription = _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentP =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _currentHeading = currentLocation.heading ?? 0.0;
        });
        _updateMarker();
        _updatePolyline();
        animateToCurrentLocation();
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
        _updateMarker();
        _updatePolyline();
      }
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  void animateToCurrentLocation() {
    if (_currentP != null) {
      _cameraToPosition(_currentP!);
    }
  }

  void _updateMarker() {
    if (_currentP != null) {
      _mapController.future.then((controller) {
        controller.showMarkerInfoWindow(_markerId);
        controller.moveCamera(
          CameraUpdate.newLatLng(_currentP!),
        );
      });
    }
  }

  void _updatePolyline() {
    if (_currentP != null) {
      setState(() {
        _polylinePoints.add(_currentP!);
      });
    }
  }

  @override
  void dispose() {
    _locationSubscription.cancel();
    super.dispose();
  }
}
