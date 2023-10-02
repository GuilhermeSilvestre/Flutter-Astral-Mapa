// ignore_for_file: library_private_types_in_public_api, avoid_print, unused_local_variable, use_build_context_synchronously

import 'dart:convert';

import 'package:astral_mapa/constants.dart';
import 'package:astral_mapa/pages/mapaastral.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MapaAstralForm extends StatelessWidget {
  const MapaAstralForm({Key? key}) : super(key: key);

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
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: MyForm(),
      ),
    );
  }
}

String idCidade = '';
String latCidade = '';
String longCidade = '';

int fireScore = 0;
int earthScore = 0;
int airScore = 0;
int waterScore = 0;
int totalScore = 0;

String urlmapa = '';

String shortText = '';

final _formKey = GlobalKey<FormState>();
TextEditingController nameController = TextEditingController();
TextEditingController birthDateController = TextEditingController();
TextEditingController birthTimeController = TextEditingController();

String selectedCity = 'Adamantina';
String nomeDaCidade = 'Adamantina';
String idMapaAstral = '';

String? validateName(String value) {
  String pattern = r'^[a-zA-Z ]+$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return 'Por favor, insira um nome válido.';
  }
  return null;
}

void irParaMapaAstra(BuildContext context) {
  //print('chegou');
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => MapaAstral(
        date: birthDateController.text.toString(),
        hour: birthTimeController.text.toString(),
        city: nomeDaCidade.toString(),
        name: nameController.text.toString(),
        fireScore: fireScore,
        earthScore: earthScore,
        airScore: airScore,
        waterScore: waterScore,
        totalScore: totalScore,
        urlmapa: urlmapa,
        shortText: shortText,
        idMapaAstral: idMapaAstral,
      ),
    ),
  );
}

Future<void> fetchMapaAstral(idMapaAstral) async {
  String resultado;

  final response = await http
      .get(Uri.parse('http://astralmapa.com.br/api/birthchart/$idMapaAstral'));

  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    //print('Conteudo da mapa astral: $data');

    if (data.containsKey('url')) {
      urlmapa = data['url'].toString();
      //print('Url: $url');
    }

    if (data.containsKey('birthchart')) {
      Map<String, dynamic> birthchart = data['birthchart'];

      if (birthchart.containsKey('elements')) {
        Map<String, dynamic> elements = birthchart['elements'];

        fireScore = elements['fireScore'];
        earthScore = elements['earthScore'];
        airScore = elements['airScore'];
        waterScore = elements['waterScore'];
        totalScore = elements['totalScore'];

        shortText = birthchart['rising']['shortText'].toString();

        // Tentando mudar de página
        //irParaMapaAstra();

        // print('fireScore: $fireScore');
        // print('earthScore: $earthScore');
        // print('airScore: $airScore');
        // print('waterScore: $waterScore');
        // print('totalScore: $totalScore');
        // print('Texto: $shortText');
      }
    } else {
      print('Nenhum resultado encontrado.');
    }
  } else {
    print('Erro ao carregar dados: ${response.statusCode}');
  }
}

Future<void> fetchPlaceID(String cityName) async {
  final response = await http
      .get(Uri.parse('https://astralmapa.com.br/api/location?query=$cityName'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);

    if (data.isNotEmpty) {
      idCidade = data[0]['placeID'];
      //print('O placeID é: $idCidade');
      //Pode ser que os campos abaixo venham null (não faz mal)
      latCidade = data[0]['latitude'];
      longCidade = data[0]['longitude'];
      //print('A lat é: $latCidade');
      //print('A long é: $longCidade');
    } else {
      print('Nenhum resultado encontrado.');
    }
  } else {
    print('Erro ao carregar dados: ${response.statusCode}');
  }
}

Future<void> fazerPost() async {
  dynamic data;

  // Define os campos
  String place = idCidade.toString();
  String date = birthDateController.text.toString();
  String hour = birthTimeController.text.toString();
  String city = nomeDaCidade.toString();
  String name = nameController.text.toString();
  String latitude = latCidade.toString(); // esses campos podem ser null/vazios
  String longitude =
      longCidade.toString(); // esses campos podem ser null/vazios

  // Define a URL
  String url = 'http://astralmapa.com.br/api/birthchart';

  // Cria o corpo da requisição
  var corpo = {
    'place': place,
    'date': date,
    'hour': hour,
    'city': city,
    'name': name,
    'latitude': latitude,
    'longitude': longitude,
  };

  // Envia a requisição POST
  var resposta = await http.post(
    Uri.parse(url),
    body: corpo,
  );

  String? novaUrl = resposta.headers['location'];
  // Verifica o status code
  if (novaUrl != null) {
    // Faz uma nova requisição para a nova URL
    var novaResposta = await http.post(
      Uri.parse(novaUrl),
      body: corpo,
    );

    // Verifica a resposta da nova requisição
    if (novaResposta.statusCode == 200) {
      //print('Requisição bem-sucedida');
      //print('Resposta: ${novaResposta.body}');

      data = json.decode(novaResposta.body);
      idMapaAstral = data['id'];
      print('Id do mapa astral: $idMapaAstral');
      //Se chegou aqui, está pronto para chamar o último endpoint
      await fetchMapaAstral(idMapaAstral);
    } else {
      print('Erro ao fazer a requisição');
      print('Status code: ${novaResposta.statusCode}');
    }
  } else if (resposta.statusCode == 200) {
    // Se não houve redirecionamento, trata normalmente
    //print('Requisição bem-sucedida');
    //print('Resposta: ${resposta.body}');
  } else {
    print('Erro ao fazer a requisição');
    print('Status code: ${resposta.statusCode}');
  }

  await Future.delayed(const Duration(seconds: 2));
}

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nome',
                hintText: 'Ex: Dorival',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor, insira um nome.';
                }
                return validateName(value);
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: birthDateController,
              decoration: const InputDecoration(
                labelText: 'Data de Nascimento',
                hintText: 'Ex: 1955-06-25',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor, insira uma data de nascimento.';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedCity,
              decoration: const InputDecoration(
                labelText: 'Cidade de Nascimento',
              ),
              items: brazilCities.map((city) {
                return DropdownMenuItem<String>(
                  value: city,
                  child: Text(city),
                );
              }).toList(),
              onChanged: (value) async {
                nomeDaCidade = value.toString();

                await fetchPlaceID(nomeDaCidade);

                setState(() {
                  selectedCity = value!;
                  //print(idCidade);
                });
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: birthTimeController,
              decoration: const InputDecoration(
                labelText: 'Hora de Nascimento',
                hintText: 'Ex: 20:30',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor, insira uma hora de nascimento.';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 10),
                            Text('Enviando dados...'),
                          ],
                        ),
                      );
                    },
                    barrierDismissible: false,
                  );

                  print('----------------------------');
                  print('Nome: ${nameController.text}');
                  print('Id da cidade: $idCidade');
                  print('Nome da cidade: $nomeDaCidade');
                  print('lat: $latCidade');
                  print('long: $longCidade');

                  fazerPost().then((value) {
                    Navigator.of(context).pop();

                    irParaMapaAstra(context);
                    return;
                  });
                }
              },
              child: const Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}
