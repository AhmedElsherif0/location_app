import 'dart:convert';
import 'package:location_app/ustils/constants.dart';
import 'package:http/http.dart' as http;

class LocationHelper {
  /*  Future<void> generateLocationPreview(String image) async{
     final location = await Location.instance.getLocation();
     final long = location.longitude;
     final lat = location.latitude;
   final uri = Uri.parse('https://maps.googleapis.com/maps/api/staticmap?center=&$lat,$long&zoom=16&size=600x300&maptype=roadmap&key=$GOOGLE_API_KEY');

    final response = await http.get(uri);

    print(response.statusCode);
        image = response.body;
    notifyListeners();
  }
*/
  static String prepareLocationPreview({double? lat, double? long}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$lat,$long&zoom=16&size=600x300&maptype=roadmap&key=$kGOOGLE_API_KEY';
  }

  static Future<String> getPlaceAddress(double lat, double long) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=$kGOOGLE_API_KEY');
    final response = await http.get(url);
    return jsonDecode(response.body)['results'][0]['formatted_address'];
  }
}
