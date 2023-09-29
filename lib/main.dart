import 'package:astral_mapa/constants.dart';
import 'package:astral_mapa/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Astral Mapa',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: colorBlue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
