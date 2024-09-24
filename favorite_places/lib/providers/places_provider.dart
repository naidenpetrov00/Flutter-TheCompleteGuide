import 'package:favorite_places/data/dummy_places.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final placesProvider = Provider((ref) => dummyPlaces);
