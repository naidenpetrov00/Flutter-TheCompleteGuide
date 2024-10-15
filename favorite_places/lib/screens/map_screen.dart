import 'package:favorite_places/models/place_location.dart';
import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation location;

  const MapScreen({
    super.key,
    this.location =
        const PlaceLocation(lat: 37.442, long: -122.084, address: ''),
  });

  @override
  State<StatefulWidget> createState() => _MapScreen();
}

class _MapScreen extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
