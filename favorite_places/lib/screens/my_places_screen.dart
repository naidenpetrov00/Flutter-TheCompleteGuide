import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/providers/places_provider.dart';
import 'package:favorite_places/screens/add_place_screen.dart';
import 'package:favorite_places/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyPlacesScreen extends ConsumerStatefulWidget {
  const MyPlacesScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyPlacesScreenState();
}

class _MyPlacesScreenState extends ConsumerState {
  void _onAddPlaceClick(WidgetRef ref) async {
    final place = await Navigator.of(context).push<Place>(
      MaterialPageRoute(
        builder: (addPlaceScreenContext) => const AddPlaceScreen(),
      ),
    );

    setState(
      () {
        ref.read(placesProvider).add(place!);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final places = ref.watch(placesProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Places'),
          actions: [
            IconButton(
              onPressed: () => _onAddPlaceClick(ref),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: PlacesList(places: places));
  }
}
