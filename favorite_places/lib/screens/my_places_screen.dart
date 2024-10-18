import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/providers/places_provider.dart';
import 'package:favorite_places/screens/add_place_screen.dart';
import 'package:favorite_places/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyPlacesScreen extends ConsumerStatefulWidget {
  const MyPlacesScreen({super.key});

  @override
  ConsumerState<MyPlacesScreen> createState() => _MyPlacesScreen();
}

class _MyPlacesScreen extends ConsumerState<MyPlacesScreen> {
  late Future<void> _placesFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _placesFuture = ref.read(placesProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
    final places = ref.watch(placesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () => {
              Navigator.of(context).push<Place>(
                MaterialPageRoute(
                  builder: (addPlaceScreenContext) => const AddPlaceScreen(),
                ),
              )
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: FutureBuilder(
          future: _placesFuture,
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(child: CircularProgressIndicator())
                  : PlacesList(places: places),
        ),
      ),
    );
  }
}
