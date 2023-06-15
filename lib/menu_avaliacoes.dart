import 'package:flutter/material.dart';
import 'package:projeto_tcc_2/avaliacaoMRCHorizontal.dart';

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

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
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
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 120.0,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Avaliações Funcionais Disponíveis',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30.0),
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
                                          AvaliacaoMRCHorizontal()));
                            },
                            child: Text("MRC")),
                        TextButton(
                            style: _styleBotaoAvaliacao(),
                            onPressed: () {},
                            child: Text("Dinamometria")),
                        TextButton(
                            style: _styleBotaoAvaliacao(),
                            onPressed: () {},
                            child: Text("")),
                        TextButton(
                            style: _styleBotaoAvaliacao(),
                            onPressed: () {},
                            child: Text("")),
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
