import 'package:flutter/material.dart';
import 'package:favorite_places_app/model/place.dart';
/* import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favorite_places_app/providers/places_provider.dart'; */

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({super.key, required this.item});
  final Place item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 3,
        shadowColor: Theme.of(context).colorScheme.shadow,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        title: Text(item.title),
      ),
    );
  }
}
