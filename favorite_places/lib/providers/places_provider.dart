import 'dart:io';

import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/models/place_location.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesNotifier extends StateNotifier<List<Place>> {
  PlacesNotifier() : super(const []);

  void addPlace(
      {required String title,
      required File image,
      required PlaceLocation location}) {
    final place = Place(title: title, image: image, location: location);
    state = [place, ...state];
  }
}

final placesProvider = StateNotifierProvider<PlacesNotifier, List<Place>>(
    (ref) => PlacesNotifier());
