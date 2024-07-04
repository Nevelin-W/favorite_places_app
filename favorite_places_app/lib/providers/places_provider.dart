import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/place.dart';

class PlacesProvider extends StateNotifier<List<Place>> {
  PlacesProvider() : super(const []);

  void addPlace(String title) {
    final newPLace = Place(title: title);
    state = [newPLace, ...state];
  }
}

final placesProvider = StateNotifierProvider<PlacesProvider, List<Place>>(
  (ref) => PlacesProvider(),
);
