import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart' as gc;
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  List<gc.Placemark> geoCoderList = [];
  final map = MapController();
  PlaceLocation? _pickedLocation;
  double longitude = 5;
  double latitude = 5;
  bool _isGettingLocation = false;

  void _getLocation() async {
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

    locationData = await location.getLocation();
    setState(() {
      _isGettingLocation = true;
      longitude = locationData.longitude!;
      latitude = locationData.latitude!;
      map.move(LatLng(latitude, longitude), 20);
    });
    getGeoCode(latitude, longitude);
  }

  void getGeoCode(double latitude, double longitude) async {
    List<gc.Placemark> placemarks =
        await gc.placemarkFromCoordinates(latitude, longitude);
    setState(() {
      geoCoderList = placemarks;
      _pickedLocation = PlaceLocation(
          latitude: latitude,
          longitude: longitude,
          adress: placemarks[0].street!);
    });
  }

  void selectLocation() {
    setState(() {
      longitude = map.camera.center.longitude;
      latitude = map.camera.center.latitude;
      map.move(LatLng(latitude, longitude), 18);
      getGeoCode(latitude, longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      'No location chosen.',
      style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
    );
    // if (_isGettingLocation) {
    //   previewContent = const CircularProgressIndicator();
    // }
    previewContent = FlutterMap(
      options: const MapOptions(
        initialCenter: LatLng(29.8700168, 31.1663384),
        initialZoom: 9.2,
      ),
      mapController: map,
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: LatLng(latitude, longitude),
              width: 80,
              height: 80,
              child: Icon(
                Icons.location_on_rounded,
                color: Colors.red,
              ),
            ),
          ],
        ),
        CircleLayer(
          circles: [
            CircleMarker(
                point: LatLng(latitude, longitude),
                radius: 50,
                useRadiusInMeter: true,
                color: const Color.fromARGB(50, 0, 0, 255)),
          ],
        ),
        const Center(
            child: Icon(
          size: 30,
          Icons.lens_outlined,
          color: Colors.blue,
        ))
      ],
    );

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                  width: 0.5,
                  color: Theme.of(context).colorScheme.onBackground)),
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          child: previewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
                onPressed: _getLocation,
                icon: const Icon(Icons.location_on_rounded),
                label: const Text('Get current location.')),
            TextButton.icon(
                onPressed: selectLocation,
                icon: const Icon(Icons.map_rounded),
                label: const Text('Select on map.'))
          ],
        ),
        (geoCoderList.isEmpty)
            ? SizedBox(
                height: 0,
              )
            : Text(
                geoCoderList[0].street!,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground),
              )
      ],
    );
  }
}
