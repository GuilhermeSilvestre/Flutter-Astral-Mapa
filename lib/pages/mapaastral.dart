// ignore_for_file: must_be_immutable

import 'package:astral_mapa/constants.dart';
import 'package:astral_mapa/pages/mapaastralform.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MapaAstral extends StatefulWidget {
  MapaAstral({
    super.key,
    required this.date,
    required this.hour,
    required this.city,
    required this.name,
    required this.fireScore,
    required this.earthScore,
    required this.airScore,
    required this.waterScore,
    required this.totalScore,
    required this.urlmapa,
    required this.shortText,
    required this.idMapaAstral,
  });

  String date;
  String hour;
  String city;
  String name;

  int fireScore;
  int earthScore;
  int airScore;
  int waterScore;
  int totalScore;
  String urlmapa;
  String shortText;
  String idMapaAstral;

  @override
  State<MapaAstral> createState() => _MapaAstralState();
}

class _MapaAstralState extends State<MapaAstral> {
  Future<void> _astralMapaSite(astralMapaSite) async {
    if (!await launchUrl(
      astralMapaSite,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $astralMapaSite');
    }
  }

  late String firePorcentTruncado;
  late String earthPorcentTruncado;
  late String airPorcentTruncado;
  late String waterPorcentTruncado;

  String calcularPorcentagens() {
    double firePorcent = (fireScore / totalScore) * 100;
    double earthPorcent = (earthScore / totalScore) * 100;
    double airPorcent = (airScore / totalScore) * 100;
    double waterPorcent = (waterScore / totalScore) * 100;

    firePorcentTruncado = firePorcent.toStringAsFixed(2);
    earthPorcentTruncado = earthPorcent.toStringAsFixed(2);
    airPorcentTruncado = airPorcent.toStringAsFixed(2);
    waterPorcentTruncado = waterPorcent.toStringAsFixed(2);
    return 'Fire: $firePorcentTruncado%, Earth: $earthPorcentTruncado%, Air: $airPorcentTruncado%, Water: $waterPorcentTruncado%';
  }

  @override
  void initState() {
    super.initState();
    calcularPorcentagens();
  }

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Resumo',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colorIndigo,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.shortText,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Mandala Astrológica',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colorIndigo,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 300,
                    height: 300,
                    child: Image.network(
                      'http://astralmapa.com.br/mapa/${widget.idMapaAstral}/mandala',
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Distribuição Energética',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colorIndigo,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Fogo: $firePorcentTruncado%',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 240, 86, 40),
                    ),
                  ),
                  Text(
                    'Terra: $earthPorcentTruncado%',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 48, 163, 48),
                    ),
                  ),
                  Text(
                    'Ar: $airPorcentTruncado%',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 110, 158, 158),
                    ),
                  ),
                  Text(
                    'Água: $waterPorcentTruncado%',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 75, 102, 223),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Informações do Mapa Astral',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colorIndigo,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Nome: ${widget.name}',
                    textAlign: TextAlign.start,
                  ),
                  Text('Nascimento: ${widget.city}'),
                  Text('Nascimento: ${widget.date}'),
                  Text('Horário: ${widget.hour}'),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  Uri astralMapaSite = Uri(
                    scheme: 'https',
                    host: 'astralmapa.com.br',
                    path: 'mapa/${widget.idMapaAstral}',
                  );

                  _astralMapaSite(astralMapaSite);
                },
                child: const Text(
                  'Clique para acessar o Mapa Astral no Site',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: colorIndigo,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
