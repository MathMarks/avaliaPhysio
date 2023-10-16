import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_tcc_2/inputRowHorizontal.dart';
import 'package:projeto_tcc_2/profile_page.dart';
import 'package:projeto_tcc_2/buscaPacientes.dart';
import 'package:projeto_tcc_2/avaliacoes/mrc.dart';
import 'package:projeto_tcc_2/avaliacaoRapida.dart';

class AvaliacaoMRCHorizontal extends StatefulWidget {
  const AvaliacaoMRCHorizontal({super.key});

  @override
  _AvaliacaoMRCHorizontalState createState() => _AvaliacaoMRCHorizontalState();
}

class _AvaliacaoMRCHorizontalState extends State<AvaliacaoMRCHorizontal> {
  final _mrcKey = GlobalKey<FormState>();
  final observacaoController = TextEditingController();
  List<int> ombrosValues = [0, 0];
  List<int> cotoveloValues = [0, 0];
  List<int> punhoValues = [0, 0];
  List<int> quadrilValues = [0, 0];
  List<int> joelhosValues = [0, 0];
  List<int> pesValues = [0, 0];

  var fraseAlerta = "";
  int valorFinal = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Color(0xFF73AEF5),
          Color(0xFF61A4F1),
          Color(0xFF478DE0),
          Color(0xFF398AE5),
        ],
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 30),
                child: GestureDetector(
                    onTap: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => const AlertDialog(
                            title: Text('Ajuda Sobre MRC'),
                            content: Text(
                                'Em breve será implementado um breve tutorial/cola para ajudar a ter uma melhor noção de como realizar o MRC.')),
                      );
                    },
                    child: const Icon(Icons.question_mark))),
          ],
          title: const Text('MRC Scale'),
          backgroundColor: Colors.black12,
        ),
        body: Form(
          key: _mrcKey,
          child: ListView(
            padding: const EdgeInsets.all(32.0),
            children: <Widget>[
              InputRowHorizontal(ombrosValues, "Abdução de Ombros"),
              InputRowHorizontal(cotoveloValues, "Flexão de Cotovelos"),
              InputRowHorizontal(punhoValues, "Extensão de Punho"),
              InputRowHorizontal(quadrilValues, "Flexão de Quadril"),
              InputRowHorizontal(joelhosValues, "Flexão de Joelhos"),
              InputRowHorizontal(pesValues, "Flexão dos Pés"),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: observacaoController,
                decoration: InputDecoration(
                  labelText: "Alguma observação?",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)),
                ),
                keyboardType: TextInputType.multiline,
                minLines: 1, // <-- SEE HERE
                maxLines: 8,
              ),
              const SizedBox(
                height: 15,
              ),
              TextButton(
                style: TextButton.styleFrom(
                    foregroundColor: Colors.black, backgroundColor: Colors.white),
                onPressed: () {
                  valorFinal = ombrosValues[0] +
                      ombrosValues[1] +
                      cotoveloValues[0] +
                      cotoveloValues[1] +
                      punhoValues[0] +
                      punhoValues[1] +
                      quadrilValues[0] +
                      quadrilValues[1] +
                      joelhosValues[0] +
                      joelhosValues[1] +
                      pesValues[0] +
                      pesValues[1];

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
              Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 15),
                child: Text(
                  "Resultado Preliminar: ${valorFinal.toString()}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  fraseAlerta,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      TextButton(
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.green),
                          onPressed: () {
                            if (FirebaseAuth.instance.currentUser != null) {
                              var aval = Mrc(
                                  valorFinal,
                                  FirebaseAuth.instance.currentUser!.uid,
                                  observacaoController.text);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          BuscaPacientes(aval: aval)));
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => avaliacaoRapida(
                                          resultadoAval: valorFinal,
                                          observacao:
                                              observacaoController.text)));
                            }
                          },
                          child: const Text("Salvar Avaliação")),
                    ],
                  ),
                  Column(
                    children: [
                      TextButton(
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.red),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Profile()));
                          },
                          child: const Text("Cancelar Avaliação")),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
