import 'package:favorite_places/models/place_location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation location;
  final bool isSelecting;

  const MapScreen({
    super.key,
    this.location =
        const PlaceLocation(lat: 37.442, long: -122.084, address: ''),
    this.isSelecting = true,
  });

  @override
  State<MapScreen> createState() => _MapScreen();
}

class _MapScreen extends State<MapScreen> {
  LatLng? _pickedLocation;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [
            if (widget.isSelecting)
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop(_pickedLocation);
                },
                icon: const Icon(Icons.save),
              ),
          ],
          title:
              Text(widget.isSelecting ? "Pick your location" : "Your location"),
        ),
        body: GoogleMap(
          onTap: !widget.isSelecting
              ? null
              : (position) {
                  setState(
                    () {
                      _pickedLocation = position;
                    },
                  );
                },
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.location.lat, widget.location.long),
            zoom: 16,
          ),
          markers: (_pickedLocation == null && widget.isSelecting)
              ? {}
              : {
                  Marker(
                    markerId: const MarkerId('m1'),
                    position: _pickedLocation ??
                        LatLng(
                          widget.location.lat,
                          widget.location.long,
                        ),
                  ),
                },
        ),
      );
}
