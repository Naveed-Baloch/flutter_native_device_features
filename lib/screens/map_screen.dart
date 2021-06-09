import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/place.dart';

class MapsScreen extends StatefulWidget {
  static const String routName = '/map-screen';
  final PlaceLocation initialocation;
  final bool isSelecting;

  MapsScreen(
      {this.initialocation = const PlaceLocation(
          latitude: 29.47, longitude: 70.5, address: 'pakistan'),
      this.isSelecting = false});

  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Map'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialocation.latitude,
            widget.initialocation.longitude,
          ),
          zoom: 16,
        ),
      ),
    );
  }
}
