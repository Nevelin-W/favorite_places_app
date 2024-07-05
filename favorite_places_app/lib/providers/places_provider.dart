import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import '../model/place.dart';

class PlacesProvider extends StateNotifier<List<Place>> {
  PlacesProvider() : super(const []);

  void addPlace(String title, File image, PlaceLocation location) {
    final newPLace = Place(title: title, image: image, location: location);
    state = [newPLace, ...state];
  }
}

final placesProvider = StateNotifierProvider<PlacesProvider, List<Place>>(
  (ref) => PlacesProvider(),
);
