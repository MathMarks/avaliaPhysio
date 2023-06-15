import 'package:projeto_tcc_2/avaliacoes/mrc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_tcc_2/buscaPacientes.dart';
import 'package:projeto_tcc_2/avaliacaoMRCHorizontal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_tcc_2/firebaseManipulation/userInfo.dart';
import 'package:projeto_tcc_2/buscaPacientesFisio.dart';
import 'package:projeto_tcc_2/cadastroPacientes.dart';
import 'package:projeto_tcc_2/login_screen.dart';
import 'package:localstore/localstore.dart';
import 'package:projeto_tcc_2/menu_avaliacoes.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final user = FirebaseAuth.instance.currentUser!;
  final _localDb = Localstore.instance;

  Future getUserData() async {
    await FirebaseFirestore.instance
        .collection('fisioterapeuta')
        .get()
        .then((snapshot) => {
              print(snapshot),
            });
  }

  @override
  void initState() {
    // var userIn = FirebaseFirestore.instance
    //     .collection("fisioterapeuta")
    //     .doc(user.uid)
    //     .get();
    //print(userIn);
    //print(dado);
    //_localDb.collection('avaliacoes').delete();
    GetUserName(documentID: user.uid.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (FirebaseAuth.instance.currentUser != null) {
      return Scaffold(
        /* floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AvaliacaoMRCHorizontal()));
        },
        child: Container(
          width: 60,
          height: 60,
          child: Icon(Icons.add),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Color(0xFF73AEF5),
                  Color(0xFF61A4F1),
                  Color(0xFF478DE0),
                  Color(0xFF398AE5),
                ],
              )),
        ),
      ),
      */
        body: Stack(
          children: [
            Column(
              children: [
                Flexible(
                  flex: 5,
                  child: FutureBuilder(
                    future: null,
                    builder: (context, snapshot) {
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF73AEF5),
                              Color(0xFF61A4F1),
                              Color(0xFF478DE0),
                              Color(0xFF398AE5),
                            ],
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Column(children: [
                            SizedBox(
                              height: screenSize.height.toInt() * 0.15,
                            ),
                            CircleAvatar(
                              radius: 65.0,
                              //backgroundImage: AssetImage(),
                              backgroundColor: Colors.white,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            GetUserName(documentID: user.uid),
                            SizedBox(
                              height: 10.0,
                            ),
                            GetUserEmail(documentID: user.uid),
                            SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                      child: Column(
                                    children: [
                                      Text(
                                        'Pacientes',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        "3",
                                        style: TextStyle(
                                          fontSize: 15.0,
                                        ),
                                      )
                                    ],
                                  )),
                                  Container(
                                    child: Column(children: [
                                      Text(
                                        'CREFITO',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      GetUserCrefito(documentID: user.uid)
                                    ]),
                                  ),
                                  Container(
                                      child: Column(
                                    children: [
                                      Text(
                                        'Info',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        'A decidir',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                        ),
                                      )
                                    ],
                                  )),
                                ],
                              ),
                            )
                          ]),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    color: Colors.grey[200],
                    child: Center(
                        child: Card(
                            margin: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
                            child: Container(
                                width: 310.0,
                                height: 350,
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Menu",
                                          style: TextStyle(
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        Divider(
                                          color: Colors.grey[300],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.home,
                                              color: Colors.blueAccent[400],
                                              size: 35,
                                            ),
                                            SizedBox(
                                              width: 20.0,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const BuscaPacientesFisio()));
                                              },
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Meus Pacientes",
                                                    style: TextStyle(
                                                      fontSize: 15.0,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Pacientes já cadastrados e \nsob sua supervisão",
                                                    style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.grey[400],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.auto_awesome,
                                              color: Colors.yellowAccent[400],
                                              size: 35,
                                            ),
                                            SizedBox(
                                              width: 20.0,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const MenuAvaliacoes()));
                                              },
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Realizar Avaliação Funcional",
                                                    style: TextStyle(
                                                      fontSize: 15.0,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Iniciar uma avaliação funcional \nem um paciente",
                                                    style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.grey[400],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.favorite,
                                              color: Colors.pinkAccent[400],
                                              size: 35,
                                            ),
                                            SizedBox(
                                              width: 20.0,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CadastroPaciente()));
                                              },
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Cadastrar novo paciente",
                                                    style: TextStyle(
                                                      fontSize: 15.0,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Realizar o cadastro de um novo paciente \nà supervisão do profissional",
                                                    style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.grey[400],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        GestureDetector(
                                          onTap: () =>
                                              FirebaseAuth.instance.signOut(),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.people,
                                                color: Colors.lightGreen[400],
                                                size: 35,
                                              ),
                                              SizedBox(
                                                width: 20.0,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Sair",
                                                    style: TextStyle(
                                                      fontSize: 15.0,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Sair da sua Conta",
                                                    style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.grey[400],
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )))),
                  ),
                ),
              ],
            ),
            // Positioned(
            //     top: MediaQuery.of(context).size.height * 0.60,
            //     left: 20.0,
            //     right: 20.0,
            //     child: Card(
            //         child: Padding(
            //       padding: EdgeInsets.all(16.0),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //         children: [
            //           Container(
            //               child: Column(
            //             children: [
            //               Text(
            //                 'Pacientes',
            //                 style: TextStyle(
            //                     color: Colors.grey[400], fontSize: 14.0),
            //               ),
            //               SizedBox(
            //                 height: 5.0,
            //               ),
            //               Text(
            //                 "3",
            //                 style: TextStyle(
            //                   fontSize: 15.0,
            //                 ),
            //               )
            //             ],
            //           )),
            //           Container(
            //             child: Column(children: [
            //               Text(
            //                 'CREFITO',
            //                 style: TextStyle(
            //                     color: Colors.grey[400], fontSize: 14.0),
            //               ),
            //               SizedBox(
            //                 height: 5.0,
            //               ),
            //               GetUserCrefito(documentID: user.uid)
            //             ]),
            //           ),
            //           Container(
            //               child: Column(
            //             children: [
            //               Text(
            //                 'Info',
            //                 style: TextStyle(
            //                     color: Colors.grey[400], fontSize: 14.0),
            //               ),
            //               SizedBox(
            //                 height: 5.0,
            //               ),
            //               Text(
            //                 'A decidir',
            //                 style: TextStyle(
            //                   fontSize: 15.0,
            //                 ),
            //               )
            //             ],
            //           )),
            //         ],
            //       ),
            //     )))
          ],
        ),
        floatingActionButton: _mostraAFB(),
        // floatingActionButton: FloatingActionButton.extended(
        //   onPressed: () {},
        //   icon: const Icon(Icons.play_arrow),
        //   label: const Text('Avaliações não salvas'),
        //   backgroundColor: Colors.indigoAccent,
        // ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      );
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }

    return Scaffold();
  }

  Widget _mostraAFB() {
    //if (_localDb.toString().isNotEmpty) {
    //colocar para verificar se tem algo armazenado temporáriamente
    //return Container();
    //} else {
    return FloatingActionButton.extended(
      onPressed: () {
        showAlertDialog(context);
      },
      icon: const Icon(Icons.history),
      label: const Text('Avaliações não salvas'),
      backgroundColor: Colors.indigoAccent,
    );
    // }
  }

  showAlertDialog(BuildContext context) async {
    // set up the button
    Widget fecharButton = TextButton(
      child: Text("Fechar"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    final dado = await _localDb.collection('avaliacoes').get();
    final Map<String, dynamic>? values = dado;
    //print(values);
    //print(values?.values.elementAt(1)['nome']);
    // set up the AlertDialog
    SimpleDialog alert = SimpleDialog(
        title: Center(child: Text("Avaliações Rápidas")),
        children: [
          SizedBox(
            height: 350,
            width: 150,
            child: ListView.separated(
                //scrollDirection: Axis.horizontal,
                itemBuilder: (content, index) {
                  //print(values.values);
                  String nome = values.values.elementAt(index)['nome'];
                  String cpf = values.values.elementAt(index)['cpf'].toString();
                  int resultado = values.values.elementAt(index)['resultado'];
                  var data = values.values.elementAt(index)['data'];
                  var id = values.values.elementAt(index)['id'];

                  return Column(
                    children: [
                      GestureDetector(
                          child: ListTile(
                            title: Text('Paciente: $nome'),
                            subtitle: Text('CPF: $cpf,  $data'),
                          ),
                          onTap: () {
                            var aval = Mrc(resultado,
                                FirebaseAuth.instance.currentUser!.uid, "");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        BuscaPacientes(aval: aval)));
                          }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.check),
                                tooltip: 'Excluir',
                                color: Colors.green,
                                onPressed: () {
                                  var aval = Mrc(
                                      resultado,
                                      FirebaseAuth.instance.currentUser!.uid,
                                      "");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BuscaPacientes(aval: aval)));
                                },
                              ),
                              Text(
                                "Salvar registro",
                                style: TextStyle(
                                    color: Colors.greenAccent,
                                    decorationThickness: 2),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.delete),
                                tooltip: 'Salvar',
                                color: Colors.red,
                                onPressed: () {
                                  setState(() {
                                    _localDb
                                        .collection('avaliacoes')
                                        .doc(id)
                                        .delete();
                                    Navigator.of(context).pop();
                                    _showMyDialog();
                                  });
                                },
                              ),
                              Text(
                                "Excluir registro",
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    decorationThickness: 2),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      )
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, index) {
                  return Divider(
                    height: 20,
                    thickness: 3,
                  );
                },
                itemCount: values!.length),
          )
        ] //Aqui vamos colocar a lista de coisas do armazenamento local

        );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Importante!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('A Avaliação Rápida foi excluída com êxito.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Prosseguir'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
