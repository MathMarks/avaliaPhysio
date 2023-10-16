import 'package:flutter/material.dart';
import 'package:projeto_tcc_2/antigo/inputRow.dart';

class Avaliacaofuncional extends StatefulWidget {
  const Avaliacaofuncional({super.key});

  @override
  _AvaliacaofuncionalState createState() => _AvaliacaofuncionalState();
}

class _AvaliacaofuncionalState extends State<Avaliacaofuncional> {
  final _mrcKey = GlobalKey<FormState>();

  final List<TextEditingController> ombrosController =
      List.generate(2, (index) => TextEditingController());
  final List<TextEditingController> cotoveloController =
      List.generate(2, (index) => TextEditingController());
  final List<TextEditingController> punhoController =
      List.generate(2, (index) => TextEditingController());
  final List<TextEditingController> quadrilController =
      List.generate(2, (index) => TextEditingController());
  final List<TextEditingController> joelhosController =
      List.generate(2, (index) => TextEditingController());
  final List<TextEditingController> pesController =
      List.generate(2, (index) => TextEditingController());

  var fraseAlerta = "";
  int valorFinal = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: const Text('MRC Scale'),
        backgroundColor: Colors.black12,
      ),
      body: Form(
        key: _mrcKey,
        child: ListView(
          padding: const EdgeInsets.all(32.0),
          children: <Widget>[
            InputRow(ombrosController, "Abdução de Ombros"),
            InputRow(cotoveloController, "Flexão de Cotovelos"),
            InputRow(punhoController, "Extensão de Punho"),
            InputRow(quadrilController, "Flexão de Quadril"),
            InputRow(joelhosController, "Flexão de Joelhos"),
            InputRow(pesController, "Flexão dos Pés"),
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Colors.white),
              onPressed: () {
                valorFinal = int.parse(ombrosController[0].text) +
                    int.parse(ombrosController[1].text) +
                    int.parse(cotoveloController[0].text) +
                    int.parse(cotoveloController[1].text) +
                    int.parse(punhoController[0].text) +
                    int.parse(punhoController[1].text) +
                    int.parse(quadrilController[0].text) +
                    int.parse(quadrilController[1].text) +
                    int.parse(joelhosController[0].text) +
                    int.parse(joelhosController[1].text) +
                    int.parse(pesController[0].text) +
                    int.parse(pesController[1].text);
                if (valorFinal <= 36) {
                  fraseAlerta = "Fraqueza muscular grave.";
                } else if (valorFinal <= 48) {
                  fraseAlerta = "Fraqueza muscular significativa.";
                } else {
                  fraseAlerta =
                      "Possivel fraqueza muscular, mas não tão severa.";
                }
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(content: Text(fraseAlerta));
                    });
                setState(() {
                  valorFinal = valorFinal;
                });
              },
              child: const Text("Calcular"),
            ),
            Text("Resultado Preliminar: $valorFinal",
                textAlign: TextAlign.center),
            Text(fraseAlerta, textAlign: TextAlign.center),
            TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const AlertDialog(
                          content: Text(
                              "Direcionando para lista de pacientes sob cuidados."),
                        );
                      });
                },
                child: const Text("Salvar Avaliação"))
          ],
        ),
      ),
    );
  }
}
