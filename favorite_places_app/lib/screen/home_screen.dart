import 'package:flutter/material.dart';
import 'package:favorite_places_app/widgets/places_list.dart';
import 'package:favorite_places_app/screen/add_place_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _addItem() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => const AddPlaceScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppBar appbar = AppBar(
      centerTitle: true,
      elevation: 3,
      shadowColor: Theme.of(context).colorScheme.shadow,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      title: const Text('Your Places'),
      actions: [
        IconButton(
          onPressed: _addItem,
          icon: Icon(Icons.add_circle_rounded,
              size: 30, color: Theme.of(context).colorScheme.primaryFixed),
        ),
      ],
    );

    return Scaffold(
      appBar: appbar,
      body: PlacesList(),
    );
  }
}
