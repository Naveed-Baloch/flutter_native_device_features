import 'dart:io';
import 'package:flutter/foundation.dart';
import '../models/place.dart';
import '../helper/db_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Future<void> addPlace(
    String pickedtitle,
    File pickedimage,
  ) async {
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedimage,
      title: pickedtitle,
      loation: PlaceLocation(address: '', latitude: 29.2, longitude: 77.5),
    );
    _items.insert(0, newPlace);
    notifyListeners();
    //add to database also
      await DBHelper.insertPlace('user_places', {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path
      });
  }

  Future<void> fetchAndSetData() async {
    try {
      final datalist = await DBHelper.getData('user_places');
      print(datalist.length.toString());
      _items = datalist
          .map(
            (e) => Place(
              id: e['id'],
              title: e['title'],
              loation: PlaceLocation(latitude: 30, address: '', longitude: 70),
              image: File(e['image']),
            ),
          ).toList();
      notifyListeners();
    } catch (error) {
      print('error while reading the data from database ' + error.toString());
    }
  }
}
