import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../data_base/location_helper.dart';
import 'package:location_app/screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;

  const LocationInput({required this.onSelectPlace});

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImage;

  void _showPreview(double lat, double long) {
    final switchImage =
        LocationHelper.prepareLocationPreview(lat: lat, long: long);
    setState(() {
      _previewImage = switchImage;
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      final location = await Location.instance.getLocation();
      _showPreview(
          location.latitude ?? 29.9792458, location.longitude ?? 31.134667);
      widget.onSelectPlace(location.latitude, location.longitude);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _onSelectLocation() async {
    final LatLng selectLocation = await Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) => MapScreen(isSelecting: true)));
    if (selectLocation == null) {
      return;
    }
    _showPreview(selectLocation.latitude, selectLocation.longitude);
    widget.onSelectPlace(selectLocation.latitude, selectLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          decoration:
              BoxDecoration(border: Border.all(width: 0.5, color: Colors.grey)),
          child: Center(
            child: _previewImage != null
                ? Image.network(_previewImage!, fit: BoxFit.cover)
                : Text('No Location Preview Yet..'),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Current Location'),
              style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(color: primaryColor)),
            ),
            TextButton.icon(
              onPressed: _onSelectLocation,
              icon: const Icon(Icons.map),
              label: const Text('Select on Map'),
              style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(color: primaryColor)),
            ),
          ],
        )
      ],
    );
  }
}
