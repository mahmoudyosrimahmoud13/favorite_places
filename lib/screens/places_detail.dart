import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({super.key, required this.place});
  final Place place;

  @override
  Widget build(BuildContext context) {
    Widget map = FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(
              place.placeLocation.latitude, place.placeLocation.latitude),
          initialZoom: 9.2,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
        ]);

    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.file(
            fit: BoxFit.cover,
            place.image,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      debugPrint(
                          'http://static-maps.yandex.ru/1.x/?lang=ar-US&ll=${place.placeLocation.longitude},${place.placeLocation.latitude}&\size=450,450&z=17&l=map&pt=${place.placeLocation.longitude},${place.placeLocation.latitude},pm2rdl1~32.870152,39.869847,pm2rdl99');
                    },
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: NetworkImage(
                          'http://static-maps.yandex.ru/1.x/?lang=ar-US&ll=${place.placeLocation.longitude},${place.placeLocation.latitude}&\size=450,450&z=17&l=map&pt=${place.placeLocation.longitude},${place.placeLocation.latitude},pm2rdl1'),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.transparent, Colors.black45],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    alignment: Alignment.center,
                    child: Text(
                      textAlign: TextAlign.center,
                      place.placeLocation.adress,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
