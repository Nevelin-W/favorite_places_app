import 'package:flutter/material.dart';
import 'package:favorite_places_app/providers/places_provider.dart';
import 'package:favorite_places_app/widgets/places_list.dart';
import 'package:favorite_places_app/screen/add_place.dart';
import 'package:favorite_places_app/model/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late Future<void> _placesFuture;

  @override
  void initState() {
    super.initState();
    _placesFuture = ref.read(placesProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
    final List<Place> userPLaces = ref.watch(placesProvider);

    final AppBar appbar = AppBar(
      centerTitle: true,
      elevation: 3,
      shadowColor: Theme.of(context).colorScheme.shadow,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      title: const Text('Your Places'),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => const AddPlaceScreen(),
            ));
          },
          icon: Icon(Icons.add_circle_rounded,
              size: 30, color: Theme.of(context).colorScheme.primaryFixed),
        ),
      ],
    );

    return Scaffold(
      appBar: appbar,
      body: FutureBuilder(
        future: _placesFuture,
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(child: CircularProgressIndicator())
                : PlacesList(
                    places: userPLaces,
                  ),
      ),
    );
  }
}
