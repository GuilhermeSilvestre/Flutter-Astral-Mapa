// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class OpenArticleBlog extends StatelessWidget {
  OpenArticleBlog(
      {super.key,
      required this.pageTitle,
      required this.titulo,
      required this.texto,
      required this.image});

  String pageTitle;
  String titulo;
  String texto;
  String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Image.asset(
          'assets/images/logo.png',
          height: 30,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                titulo,
                style: const TextStyle(
                  fontSize: 26,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                texto,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 350,
              child: Image.asset(image),
            ),
          ],
        ),
      ),
    );
  }
}
