import 'package:flutter/material.dart';
import 'splash_screen.dart';

void main() {
  runApp(ChipsDipsApp());
}

class ChipsDipsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chips Dips',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto',
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.amber,
          foregroundColor: Colors.black,
        ),
      ),
      home: SplashScreen(),
    );
  }
}
