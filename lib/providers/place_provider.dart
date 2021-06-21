import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:location_app/data_base/location_helper.dart';
import 'package:location_app/data_base/sqlite_helper.dart';
import 'package:location_app/model/place.dart';
import 'package:location_app/model/place_location.dart';

class PlaceProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items => _items;

  Future<void> addPlace(
      String title, File image, PlaceLocation pickedLocation) async {
    final address = await LocationHelper.getPlaceAddress(
        pickedLocation.latitude??31.134667, pickedLocation.longitude??29.9792458);
    final updatedLocation = PlaceLocation(
        latitude: pickedLocation.latitude,
        longitude: pickedLocation.longitude,
        address: address);
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: title,
        image: image,
        location: updatedLocation);
    _items.add(newPlace);
    notifyListeners();
    SqLiteHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image?.path,
      'location_lat': newPlace.location?.latitude,
      'location_long': newPlace.location?.longitude,
      'address': newPlace.location?.address
    });
  }

  Future<void> fetchPlace() async {
    final dataList = await SqLiteHelper.fetchData('user_places');
    _items = dataList
        .map((item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: PlaceLocation(
                latitude: item['location_lat'],
                longitude: item['location_long'],
                address: item['address'])))
        .toList();
    notifyListeners();
  }
}
