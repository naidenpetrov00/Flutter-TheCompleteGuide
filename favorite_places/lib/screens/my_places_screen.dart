import 'package:favorite_places/providers/places_provider.dart';
import 'package:favorite_places/screens/add_place_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyPlacesScreen extends ConsumerStatefulWidget {
  const MyPlacesScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyPlacesScreenState();
}

class _MyPlacesScreenState extends ConsumerState {
  @override
  Widget build(BuildContext context) {
    final places = ref.watch(placesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () async {
              final place = await Navigator.of(context).push<String>(
                MaterialPageRoute(
                  builder: (addPlaceScreenContext) => const AddPlaceScreen(),
                ),
              );

              setState(() {
                places.add(place!);
              });
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: places.length,
        itemBuilder: (ctx, index) => Container(
          padding: EdgeInsets.only(left: 16, top: 16),
          child: Text(
            places[index],
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
      ),
    );
  }
}
