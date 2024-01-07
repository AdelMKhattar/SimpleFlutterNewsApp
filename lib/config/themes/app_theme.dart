import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
      textTheme: const TextTheme(
          bodySmall: TextStyle(
            fontSize: 15,
            color: Colors.black54,
            fontFamily: 'Muli',
          ),
          bodyMedium: TextStyle(
            fontSize: 20,
            color: Colors.black54,
            fontFamily: 'Muli',
          ),
          bodyLarge: TextStyle(
              fontSize: 25,
              color: Colors.black,
              fontFamily: 'Muli',
              fontWeight: FontWeight.bold)),
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Muli',
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
        color: Colors.white,
        elevation: 0,
      ));
}
