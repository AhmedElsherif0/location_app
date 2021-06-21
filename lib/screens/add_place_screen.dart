import 'dart:io';
import 'package:flutter/material.dart';
import 'package:location_app/model/place_location.dart';
import 'package:location_app/providers/place_provider.dart';
import 'package:location_app/widgets/image_input.dart';
import 'package:location_app/widgets/location_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = 'add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleEditController = TextEditingController();
  File? _pickedImage ;
  PlaceLocation? _pickedLocation;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double lat, double long) {
    _pickedLocation = PlaceLocation(latitude: lat, longitude: long);
  }

  void _savePlace() {
    if (_titleEditController.text.isEmpty || _pickedImage == null ||
        _pickedLocation == null) {
      return;
    }
    Provider.of<PlaceProvider>(context, listen: false)
        .addPlace(_titleEditController.text, _pickedImage??File('/'), _pickedLocation!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Add a NEW PlACE'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: 'title'),
                      controller: _titleEditController,
                    ),
                    SizedBox(width: 10),
                    ImageInput(onSelectImage: _selectImage),
                    SizedBox(width: 10),
                    LocationInput(onSelectPlace: _selectPlace)
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _savePlace,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.add), Text('Add Place')],
            ),
          )
        ],
      ),
    );
  }
}
