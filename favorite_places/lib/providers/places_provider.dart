import 'dart:io';

import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/models/place_location.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sqf;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sqf.getDatabasesPath();
  return sqf.openDatabase(
    path.join(
      dbPath,
      'places.db',
    ),
    onCreate: (db, verison) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, long REAL, address TEXT)');
    },
    version: 1,
  );
}

class PlacesNotifier extends StateNotifier<List<Place>> {
  PlacesNotifier() : super(const []);

  Future<void> loadPlaces() async {
    final db = await _getDatabase();
    final data = await db.query('user_places');
    final places = data
        .map(
          (row) => Place(
            id: row['id'] as String,
            location: PlaceLocation(
              lat: row['lat'] as double,
              long: row['long'] as double,
              address: row['address'] as String,
            ),
            title: row['title'] as String,
            image: File(row['image'] as String),
          ),
        )
        .toList();

    state = places;
  }

  void addPlace(
      {required String title,
      required File image,
      required PlaceLocation location}) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$fileName');

    final place = Place(title: title, image: copiedImage, location: location);

    final db = await _getDatabase();
    db.insert(
      'user_places',
      {
        'id': place.id,
        'title': title,
        'image': place.image.path,
        'lat': place.location.lat,
        'long': place.location.long,
        'address': place.location.address
      },
    );
    state = [place, ...state];
  }
}

final placesProvider = StateNotifierProvider<PlacesNotifier, List<Place>>(
    (ref) => PlacesNotifier());
