import 'package:astral_mapa/constants.dart';
import 'package:astral_mapa/fakedata/data.dart';
import 'package:astral_mapa/pages/open_article_blog.dart';
import 'package:flutter/material.dart';

class Artigos extends StatefulWidget {
  const Artigos({Key? key}) : super(key: key);

  @override
  State<Artigos> createState() => _ArtigosState();
}

class _ArtigosState extends State<Artigos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'assets/images/logo.png',
          height: 30,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: artigos.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                surfaceTintColor: Colors.transparent,
                color: Colors.white,
                shadowColor: colorIndigo,
                elevation: 8,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(20),
                  leading: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: SizedBox(
                              width: double.maxFinite,
                              child: Image.asset(
                                artigos[index].image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Image.asset(
                      artigos[index].image,
                      height: 100,
                      width: 100,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  title: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OpenArticleBlog(
                            pageTitle: 'Página do Artigo',
                            titulo: artigos[index].titulo,
                            texto: artigos[index].texto,
                            image: artigos[index].image,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      artigos[index].titulo,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
