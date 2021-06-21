import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_app/model/place_location.dart';

class MapScreen extends StatefulWidget {
  static const routeName = 'map-screen';

  final bool isSelecting;

  final PlaceLocation placeLocation;

  MapScreen(
      {this.isSelecting = false,
      this.placeLocation =
          const PlaceLocation(latitude: 29.9792458, longitude: 31.134667)});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  Set<Marker> _marker(LatLng pickLocation) {
    return {Marker(markerId: MarkerId("marker_1"), position: pickLocation)};
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Google Map '),
          actions: [
            if (widget.isSelecting)
              IconButton(
                  icon: Icon(Icons.check),
                  onPressed: _pickedLocation == null
                      ? null
                      : () => Navigator.of(context).pop(_pickedLocation))
          ],
        ),
        body: SafeArea(
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(widget.placeLocation.latitude??29.9792458,
                    widget.placeLocation.longitude??31.134667),
                zoom: 16.0),
            zoomGesturesEnabled: true,
            onTap: widget.isSelecting ? _selectLocation : null,
            markers: _pickedLocation == null
                ? _marker(LatLng(29.9792458, 31.134667))
                : _marker(_pickedLocation??LatLng(29.9792458, 31.134667)),
          ),
        ),
      ),
    );
  }
}
