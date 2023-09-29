import 'package:astral_mapa/constants.dart';
import 'package:flutter/material.dart';

class MapaAstral extends StatefulWidget {
  const MapaAstral({Key? key}) : super(key: key);

  @override
  State<MapaAstral> createState() => _MapaAstralState();
}

class _MapaAstralState extends State<MapaAstral> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo.png',
          height: 30,
        ),
        centerTitle: true,
      ),
      body: Container(
        color: colorBlue,
        height: 400,
      ),
    );
  }
}
