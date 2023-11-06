import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_tcc_2/profile_page.dart';
import 'package:projeto_tcc_2/buscaPacientes.dart';
import 'package:projeto_tcc_2/avaliacoes/mrc.dart';
import 'package:projeto_tcc_2/avaliacaoRapida.dart';
import 'package:group_button/group_button.dart';
import 'package:projeto_tcc_2/grupo_muscular.dart';

class AvaliacaoMRCHorizontal extends StatefulWidget {
  const AvaliacaoMRCHorizontal({super.key});

  @override
  _AvaliacaoMRCHorizontalState createState() => _AvaliacaoMRCHorizontalState();
}

class _AvaliacaoMRCHorizontalState extends State<AvaliacaoMRCHorizontal> {
  final _mrcKey = GlobalKey<FormState>();
  final observacaoController = TextEditingController();
  //Criando uma lista da classe GrupoMusculares
  List<GrupoMuscular> grupoMuscular = [
    GrupoMuscular("Abdução de Ombros", 0, 0),
    GrupoMuscular("Flexão de Cotovelos", 0, 0),
    GrupoMuscular("Extensão de Punho", 0, 0),
    GrupoMuscular("Flexão de Quadril", 0, 0),
    GrupoMuscular("Flexão de Joelhos", 0, 0),
    GrupoMuscular("Flexão dos Pés", 0, 0),
  ];

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
                                'Em breve será implementado um breve tutorial para ajudar a ter uma melhor noção de como realizar o MRC caso não conheça.')),
                      );
                    },
                    child: const Icon(Icons.question_mark))),
          ],
          title: const Text('MRC Scale'),
          backgroundColor: Colors.black12,
        ),
        body: SizedBox(
          height: double.infinity,
          child: Form(
            key: _mrcKey,
            child: ListView(
              padding: const EdgeInsets.all(32.0),
              children: <Widget>[
                inputRowHorizontal(grupoMuscular[0]),
                inputRowHorizontal(grupoMuscular[1]),
                inputRowHorizontal(grupoMuscular[2]),
                inputRowHorizontal(grupoMuscular[3]),
                inputRowHorizontal(grupoMuscular[4]),
                inputRowHorizontal(grupoMuscular[5]),
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
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white),
                  onPressed: () {
                    valorFinal = 0;
                    for (var i = 0; i < grupoMuscular.length; i++) {
                      if (grupoMuscular[i].verificarValores() == "ok") {
                        valorFinal += grupoMuscular[i].totalValores();
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                  content: Text(
                                      grupoMuscular[i].verificarValores()));
                            });
                        return;
                      }
                    }
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
                    "Resultado Preliminar: ${valorFinal.toString()} de 60",
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
      ),
    );
  }

  Widget inputRowHorizontal(GrupoMuscular grupo) {
    GroupButtonController controllerDireito =
        GroupButtonController(selectedIndex: grupo.valorDireito - 1);
    GroupButtonController controllerEsquerdo =
        GroupButtonController(selectedIndex: grupo.valorEsquerdo - 1);
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: Text(
                grupo.nome,
                style: const TextStyle(
                    fontSize: 20,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w800),
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Column(
                          children: [
                            const Text(
                              "Direita",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            GroupButton(
                              controller: controllerDireito,
                              options: GroupButtonOptions(
                                  spacing: 0,
                                  buttonWidth: 40,
                                  unselectedBorderColor: Colors.blue[900]),
                              isRadio: true,
                              onSelected: (value, index, isSelected) => {
                                setState(() {
                                  grupo.valorDireito = value;
                                  // controllerDireito.selectIndex(5);
                                  print(
                                      "Value: ${value}\nIndex: ${index}\nisSelected: ${isSelected}");
                                })
                              },
                              buttons: const [1, 2, 3, 4, 5],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          const Text(
                            "Esquerda",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          GroupButton(
                            controller: controllerEsquerdo,
                            options: GroupButtonOptions(
                                spacing: 0,
                                buttonWidth: 40,
                                unselectedBorderColor: Colors.blue[900]),
                            isRadio: true,
                            onSelected: (value, index, isSelected) => {
                              setState(() {
                                grupo.valorEsquerdo = value;
                                // controllerDireito.selectIndex(5);
                                print(
                                    "Value: ${value}\nIndex: ${index}\nisSelected: ${isSelected}");
                              })
                            },
                            buttons: const [1, 2, 3, 4, 5],
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
