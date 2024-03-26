import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final mainTheme = ThemeData().copyWith(
    textTheme: GoogleFonts.exoTextTheme(),
    colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xDCFFB7), brightness: Brightness.light));
final darkTheme = ThemeData.dark().copyWith(
    textTheme: GoogleFonts.exoTextTheme(),
    colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xD4ADFC), brightness: Brightness.dark));
