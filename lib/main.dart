import 'package:flutter/material.dart';

import 'package:favorite_places/constants/theme.dart';
import 'package:favorite_places/screens/places_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: mainTheme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      home: const PlacesListScreen(),
    );
  }
}
