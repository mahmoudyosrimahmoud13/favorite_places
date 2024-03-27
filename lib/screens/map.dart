import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _location;

  SnackBar snackBar = SnackBar(content: Text('Please select location.'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Select your location'),
          actions: [
            IconButton(
                onPressed: () {
                  if (_location != null) {
                    Navigator.of(context).pop<LatLng>(_location);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                icon: Icon(Icons.add)),
          ],
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Stack(children: [
            FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(29.8700168, 31.1663384),
                  initialZoom: 8.2,
                  onTap: (tapPosition, point) {
                    setState(() {
                      _location = point;
                    });
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                  _location != null
                      ? MarkerLayer(markers: [
                          Marker(
                              point: _location!,
                              child: Icon(
                                Icons.location_on_rounded,
                                color: Colors.red,
                              ))
                        ])
                      : SizedBox.shrink()
                ]),
            Positioned(
              bottom: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.minimize),
                      color: Colors.purple,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                      color: Colors.purple,
                    )
                  ],
                ),
              ),
            )
          ]),
        ));
  }
}
