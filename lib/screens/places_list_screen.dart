import 'package:flutter/material.dart';
import 'package:flutter_native_device_features/providers/great_places.dart';
import 'package:flutter_native_device_features/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future:
        Provider.of<GreatPlaces>(context, listen: false).fetchAndSetData(),
        builder: (ctx, snapshot) =>
        snapshot.connectionState ==
            ConnectionState.waiting
            ? Center(
          child: CircularProgressIndicator(),
        )
            : Consumer<GreatPlaces>(
          builder: (ctx, greatPlace, ch) =>
          greatPlace.items.length <= 0
              ? Center(
            child: Center(child: Text('No Great Places Start Adding some!'),),
          )
              : ListView.builder(
            itemCount: greatPlace.items.length,
            itemBuilder: (ctx, index) =>
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                    FileImage(greatPlace.items[index].image),
                  ),
                  title: Text(greatPlace.items[index].title),
                  onTap: () {},
                ),
          ),
        ),
      ),
    );
  }
}
