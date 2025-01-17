import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:favorite_places_app/model/place.dart';
import 'package:favorite_places_app/screen/map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onSelectLocation});

  final void Function(PlaceLocation) onSelectLocation;
  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickedLocation;
  bool _isGettingLocation = false;

  String get locationImage {
    if (_pickedLocation == null) {
      return '';
    }
    final lat = _pickedLocation!.latitude;
    final lng = _pickedLocation!.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=AIzaSyAQX8GiodOFzv_hQuFBITN3FJKLNyCq1yM';
  }

  Future<void> _savePlace(double latitude, double longitude) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=AIzaSyAQX8GiodOFzv_hQuFBITN3FJKLNyCq1yM',
    );

    final response = await http.get(url);
    final resData =
        (json.decode(response.body))['results'][0]['formatted_address'];

    setState(() {
      _pickedLocation = PlaceLocation(
        latitude: latitude,
        longitude: longitude,
        address: resData,
      );
      _isGettingLocation = false;
    });

    widget.onSelectLocation(_pickedLocation!);
  }

  void _selectOnMap() async {
    final pcikedPosition = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (ctx) => const MapScreen(),
      ),
    );

    if (pcikedPosition == null) {
      return;
    }

    _savePlace(pcikedPosition.latitude, pcikedPosition.longitude);
  }

  void _getCurrentLocation() async {
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
    final lat = locationData.latitude;
    final lng = locationData.longitude;

    if (lat == null || lng == null) {
      return;
    }

    _savePlace(lat, lng);
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      'No Location Chosen',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
    );

    if (_pickedLocation != null) {
      previewContent = ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          locationImage,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }
    if (_isGettingLocation) {
      previewContent = const CircularProgressIndicator();
    }

    final BoxDecoration containerDec = BoxDecoration(
      color: Theme.of(context).colorScheme.secondaryContainer,
      border: Border.all(
        width: 1,
        color: Theme.of(context).colorScheme.secondaryFixed.withOpacity(0.8),
      ),
      borderRadius: BorderRadius.circular(10),
    );

    return Column(
      children: [
        Container(
            alignment: Alignment.center,
            height: 170,
            width: double.infinity,
            decoration: containerDec,
            child: previewContent),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              label: const Text('Get Current Location'),
              icon: const Icon(Icons.location_on),
            ),
            TextButton.icon(
              onPressed: () {
                _selectOnMap();
              },
              label: const Text('Select on Map'),
              icon: const Icon(Icons.map),
            ),
          ],
        )
      ],
    );
  }
}
