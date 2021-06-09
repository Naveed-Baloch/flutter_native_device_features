import 'package:flutter/material.dart';
import '/screens/add_place_screen.dart';
import '/providers/great_places.dart';
import '/screens/places_list_screen.dart';
import 'package:provider/provider.dart';
import './providers/great_places.dart';
import './screens/map_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.yellow
        ),
        debugShowCheckedModeBanner: false,
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
          MapsScreen.routName:(ctx)=>MapsScreen(),
        },
      ),
    );
  }
}
