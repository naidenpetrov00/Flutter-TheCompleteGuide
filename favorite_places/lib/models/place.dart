import 'dart:io';

import 'package:favorite_places/models/place_location.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Place {
  final String id;
  final String title;
  final File image;
  final PlaceLocation location;

  Place({required this.location, required this.title, required this.image})
      : id = uuid.v4();
}
