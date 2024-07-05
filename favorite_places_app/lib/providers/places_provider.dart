import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import '../model/place.dart';

class PlacesProvider extends StateNotifier<List<Place>> {
  PlacesProvider() : super(const []);

  void addPlace(String title, File image) {
    final newPLace = Place(title: title, image: image);
    state = [newPLace, ...state];
  }
}

final placesProvider = StateNotifierProvider<PlacesProvider, List<Place>>(
  (ref) => PlacesProvider(),
);
