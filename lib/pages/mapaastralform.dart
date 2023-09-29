// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'dart:convert';

import 'package:astral_mapa/constants.dart';
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

String? validateName(String value) {
  String pattern = r'^[a-zA-Z ]+$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return 'Por favor, insira um nome válido.';
  }
  return null;
}

Future<void> fetchPlaceID(String cityName) async {
  final response = await http
      .get(Uri.parse('https://astralmapa.com.br/api/location?query=$cityName'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);

    if (data.isNotEmpty) {
      idCidade = data[0]['placeID'];
      print('O placeID é: $idCidade');
    } else {
      print('Nenhum resultado encontrado.');
    }
  } else {
    print('Erro ao carregar dados: ${response.statusCode}');
  }
}

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController birthTimeController = TextEditingController();

  String selectedCity = 'Adamantina';
  String endpointDaCidade = 'Adamantina';

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
                endpointDaCidade = value.toString();

                await fetchPlaceID(endpointDaCidade);

                setState(() {
                  selectedCity = value!;
                  print(idCidade);
                });
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: birthTimeController,
              decoration: const InputDecoration(
                labelText: 'Hora de Nascimento',
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
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  print(nameController.text);
                  print(idCidade);
                  print(endpointDaCidade);

                  //Fazer POST com
                  //nameController.text  (é o nome)
                  //idCidade  (id que veio do json do primeiro endpoint)
                  //endpointDaCidade (que é o nome da cidade, podia ser tbm selectedCity)
                  // falta data
                  // falta hora
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
