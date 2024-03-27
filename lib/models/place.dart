import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String adress;

  const PlaceLocation(
      {required this.latitude, required this.longitude, required this.adress});
}

class Place {
  Place(
      {required this.placeLocation,
      required this.title,
      required this.image,
      id})
      : id = id ?? uuid.v4();

  final String id;
  final String title;
  final File image;
  final PlaceLocation placeLocation;
}
