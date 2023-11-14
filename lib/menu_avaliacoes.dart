import 'package:flutter/material.dart';
import 'package:projeto_tcc_2/avaliacaoMRCHorizontal.dart';
import 'package:projeto_tcc_2/dinamometria.dart';

class MenuAvaliacoes extends StatefulWidget {
  const MenuAvaliacoes({super.key});

  @override
  State<MenuAvaliacoes> createState() => _MenuAvaliacoesState();
}

class _MenuAvaliacoesState extends State<MenuAvaliacoes> {
  ButtonStyle _styleBotaoAvaliacao() {
    return TextButton.styleFrom(
        fixedSize: const Size(150, 120),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        textStyle: const TextStyle(fontSize: 18));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Avaliações'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: const [],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF73AEF5),
                  Color(0xFF61A4F1),
                  Color(0xFF478DE0),
                  Color(0xFF398AE5),
                ],
                stops: [0.1, 0.4, 0.7, 0.9],
              ),
            ),
          ),
          SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 120.0,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Avaliações Funcionais Disponíveis',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30.0),
                    Wrap(
                      spacing: 20,
                      runSpacing: 15,
                      children: [
                        TextButton(
                            style: _styleBotaoAvaliacao(),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AvaliacaoMRCHorizontal()));
                            },
                            child: const Text("MRC")),
                        TextButton(
                            style: _styleBotaoAvaliacao(),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Dinamometria()));
                            },
                            child: const Text("Dinamometria Manual")),
                        TextButton(
                            style: _styleBotaoAvaliacao(),
                            onPressed: () {},
                            child: const Text("")),
                        TextButton(
                            style: _styleBotaoAvaliacao(),
                            onPressed: () {},
                            child: const Text("")),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
