import 'package:flutter/material.dart';
import 'package:favorite_places_app/data/dummy_places.dart';
import 'package:favorite_places_app/widgets/place_item.dart';

class PlacesList extends StatefulWidget {
  const PlacesList({super.key});

  @override
  State<PlacesList> createState() => _PlacesListState();
}

class _PlacesListState extends State<PlacesList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: favoritePlaces.length,
      itemBuilder: (ctx, index) => PlaceItem(item: favoritePlaces[index]),
    );
  }
}
