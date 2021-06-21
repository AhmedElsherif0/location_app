import 'dart:io';

import 'package:flutter/material.dart';
import 'package:location_app/providers/place_provider.dart';
import 'package:provider/provider.dart';
import './add_place_screen.dart';

class PlaceListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<PlaceProvider>(context, listen: false).fetchPlace(),
        builder: (ctx, snapShot) => snapShot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<PlaceProvider>(
                child:
                    const Center(child: Text('There is No Places Added yet..')),
                builder: (context, placeProvider, ch) {
                  final items = placeProvider.items;
                  ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (ctx, i) => ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            FileImage(items[i].image ?? File('/counter.jpg')),
                      ),
                      title: Text(items[i].title ?? 'title'),
                      subtitle:
                          Text(items[i].location?.address ?? 'went Wrong'),
                      onTap: () {}
                    ),
                  );
                  return Center(child: CircularProgressIndicator());
                },
              ),
      ),
    );
  }
}
