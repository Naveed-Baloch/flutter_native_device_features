import 'package:flutter/material.dart';
import 'package:location/location.dart';
import '../helper/location_helper.dart';
import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  Future<void> getCurrentLocation() async {
    final location = await Location().getLocation();
    final mapUrl = await LocationHelper.mapImageUrl(
        latitude: location.latitude!, longitude: location.longitude!);
    setState(() {
      _previewImageUrl = mapUrl;
    });
  }

  Future<void> selectMap() async {
    final selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapsScreen(
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) return;
    //.. do the rest of the work
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewImageUrl == null
              ? Text(
                  'No Location Chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: getCurrentLocation,
              icon: Icon(Icons.add_location),
              label: Text(
                'Current Location',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
            TextButton.icon(
              onPressed: selectMap,
              icon: Icon(Icons.map),
              label: Text('Select On Map'),
            ),
          ],
        )
      ],
    );
  }
}
