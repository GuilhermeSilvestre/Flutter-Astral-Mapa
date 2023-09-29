import 'package:astral_mapa/constants.dart';
import 'package:astral_mapa/pages/artigos.dart';
import 'package:astral_mapa/pages/blog.dart';
import 'package:astral_mapa/pages/mapaastralform.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Uri astralMapaSite = Uri(scheme: 'https', host: 'astralmapa.com.br');

  Future<void> _astralMapaSite() async {
    if (!await launchUrl(
      astralMapaSite,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $astralMapaSite');
    }
  }

  @override
  void initState() {
    super.initState();
    brazilCities.sort();
    brazilCities = brazilCities.toSet().toList();
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
        actions: <Widget>[
          PopupMenuButton(
            surfaceTintColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: const BorderSide(color: Colors.black),
            ),
            icon: const Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  value: 'Artigos',
                  child: Center(
                    child: SizedBox(
                      width: 130,
                      child: Text(
                        'Artigos',
                        style: TextStyle(color: colorPurple2),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                const PopupMenuItem(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  value: 'Blog',
                  child: Center(
                    child: Text(
                      'Blog',
                      style: TextStyle(color: colorPurple2),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const PopupMenuItem(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  value: 'Visitar',
                  child: Center(
                    child: Text(
                      'Visitar site!',
                      style: TextStyle(color: colorPurple2),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ];
            },
            onSelected: (value) {
              if (value == 'Artigos') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Artigos()),
                );
              } else if (value == 'Blog') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Blog()),
                );
              } else if (value == 'Visitar') {
                _astralMapaSite();
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Mapa astral ',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                    TextSpan(
                      text: 'grátis e completo\n',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Descubra o maravilhoso mundo da ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                    const TextSpan(
                      text: 'astrologia ',
                      style: TextStyle(
                        fontSize: 16,
                        color: colorIndigo,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text:
                          'e mergulhe em uma jornada de autoconhecimento com o nosso mapa astral grátis e completo. Um ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                    const TextSpan(
                      text: ' mapa astral ',
                      style: TextStyle(
                        fontSize: 16,
                        color: colorIndigo,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text:
                          'é um retrato único do céu no momento exato do seu nascimento, mostrando a posição dos planetas, signos e casas astrológicas. Esta ferramenta poderosa desvenda aspectos profundos da sua personalidade, talentos, desafios e potencial de crescimento.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/images/image_homepage1.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    height: 180,
                    width: 180,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      'Receba uma análise detalhada dos diferentes elementos do seu mapa, como signos, planetas, casas e aspectos, para ter uma compreensão profunda das influências astrológicas em sua vida.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 19,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold,
                    ),
                    children: <TextSpan>[
                      const TextSpan(text: 'Crie agora seu '),
                      const TextSpan(
                        text: 'mapa astral ',
                        style: TextStyle(
                          color: colorIndigo,
                        ),
                      ),
                      TextSpan(
                        text: 'gratuito',
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),
                      ),
                      const TextSpan(text: '!'),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              SizedBox(
                height: 60,
                width: 250,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    side: MaterialStateProperty.all(
                      const BorderSide(
                        color: Colors.purple,
                        width: 1,
                      ),
                    ),
                    surfaceTintColor:
                        MaterialStateProperty.all(Colors.transparent),
                    overlayColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 213, 189, 218)),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    elevation: MaterialStateProperty.all(18),
                    shadowColor: MaterialStateProperty.all(Colors.purple),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MapaAstralForm(),
                      ),
                    );
                  },
                  child: const Text(
                    'Gerar meu Mapa Astral',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: colorIndigo,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Spacer(),
              Text(
                'Todos os direitos reservados - astralmapa.com.br',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
