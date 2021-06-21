import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:location_app/screens/map_screen.dart';
import 'package:provider/provider.dart';
import './screens/place_list_screen.dart';
import 'providers/place_provider.dart';
import 'screens/add_place_screen.dart';

void main() {
 runApp(DevicePreview(enabled: !kReleaseMode, builder: (context) => MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PlaceProvider>(
            create: (context) => PlaceProvider()),
      ],
      child: MaterialApp(
          locale: DevicePreview.locale(context),
          // Add the locale here
          builder: DevicePreview.appBuilder,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.indigo,
            accentColor: Colors.amber,
          ),
          debugShowCheckedModeBanner: false,
          home: PlaceListScreen(),
          routes: {
            AddPlaceScreen.routeName: (_) => AddPlaceScreen(),
            MapScreen.routeName: (_) => MapScreen(),
          }),
    );
  }
}
