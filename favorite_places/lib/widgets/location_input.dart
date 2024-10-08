import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInput();
}

class _LocationInput extends State<LocationInput> {
  Location? _pickedLocation;
  var _isGettingLocation = false;

  _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isGettingLocation = true;
    });
    locationData = await location.getLocation();
    final latitude = locationData.latitude;
    final longitude = locationData.longitude;
    // final apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'];
    print('apiKey');
    // print(apiKey);
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=YOUR_API_KEY');
    http.get(url);
    setState(() {
      _isGettingLocation = false;
    });

    print(locationData.latitude);
    print(locationData.longitude);
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              ),
            ),
            alignment: Alignment.center,
            height: 160,
            width: double.infinity,
            child: _isGettingLocation
                ? const CircularProgressIndicator()
                : Text(
                    'No Location',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: _getCurrentLocation,
                label: const Text('Get Current Location'),
                icon: const Icon(Icons.location_on),
              ),
              TextButton.icon(
                onPressed: () {},
                label: const Text('Select from Map'),
                icon: const Icon(Icons.map),
              ),
            ],
          )
        ],
      );
}
