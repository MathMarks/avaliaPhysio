import 'package:projeto_tcc_2/avaliacoes/mrc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_tcc_2/buscaPacientes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_tcc_2/firebaseManipulation/userInfo.dart';
import 'package:projeto_tcc_2/buscaPacientesFisio.dart';
import 'package:projeto_tcc_2/cadastroPacientes.dart';
import 'package:projeto_tcc_2/login_screen.dart';
import 'package:localstore/localstore.dart';
import 'package:projeto_tcc_2/menu_avaliacoes.dart';
import 'dart:developer' as developer;

class Profile extends StatefulWidget {
  final String? msgPopUp;

  const Profile({Key? key, this.msgPopUp}) : super(key: key);
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final user = FirebaseAuth.instance.currentUser!;
  final _localDb = Localstore.instance;

  Future getUserData() async {
    await FirebaseFirestore.instance
        .collection('fisioterapeuta')
        .get()
        .then((snapshot) => {
              //print(snapshot),
            });
  }

  @override
  void initState() {
    GetUserName(documentID: user.uid.toString());
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.msgPopUp != null) {
        await showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: const Text("Aviso"),
                  content: Text("${widget.msgPopUp}"),
                  actions: <Widget>[
                    TextButton(
                      child: const Text("OK"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (FirebaseAuth.instance.currentUser != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Perfil'),
          centerTitle: true,
          backgroundColor: Colors.blue,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginScreen()));
              },
            )
          ],
        ),
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
                        decoration: const BoxDecoration(
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
                              height: screenSize.height.toInt() * 0.10,
                            ),
                            const CircleAvatar(
                              radius: 65.0,
                              //backgroundImage: AssetImage(),
                              backgroundColor: Colors.white,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            GetUserName(documentID: user.uid),
                            const SizedBox(
                              height: 10.0,
                            ),
                            GetUserEmail(documentID: user.uid),
                            const SizedBox(
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
                                      const Text(
                                        'Meus Pacientes',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      GetPacientsNum(documentID: user.uid)
                                    ],
                                  )),
                                  Container(
                                    child: Column(children: [
                                      const Text(
                                        'CREFITO',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      GetUserCrefito(documentID: user.uid)
                                    ]),
                                  ),
                                  Container(
                                      child: Column(
                                    children: [
                                      const Text(
                                        'Total Na UTI',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      GetPacientsTotal(documentID: user.uid)
                                    ],
                                  )),
                                  const Divider(),
                                  TextButton(
                                      style: TextButton.styleFrom(
                                          backgroundColor: Colors.white),
                                      onPressed: () {
                                        //print("Teste requested");
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BuscaPacientes(
                                                      aval: Mrc(
                                                          10, "fisioID", ""),
                                                    )));
                                      },
                                      child: const Text("Test purpose!"))
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
                                        const Text(
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
                                            const SizedBox(
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
                                                  const Text(
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
                                        const SizedBox(
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
                                            const SizedBox(
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
                                                  const Text(
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
                                        const SizedBox(
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
                                            const SizedBox(
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
                                                  const Text(
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
                                        const SizedBox(
                                          height: 20.0,
                                        ),
                                        GestureDetector(
                                          onTap: () => {
                                            developer.log(
                                                "Pressionou modificar dados",
                                                name: "Modificar Dados")
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.people,
                                                color: Colors.lightGreen[400],
                                                size: 35,
                                              ),
                                              const SizedBox(
                                                width: 20.0,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    "Meus dados",
                                                    style: TextStyle(
                                                      fontSize: 15.0,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Atualizar meus dados",
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
          ],
        ),
        floatingActionButton: _mostraAFB(),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      );
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }

    return const Scaffold();
  }

  showAlertDialog(BuildContext context) async {
    // set up the button
    final dado = await _localDb.collection('avaliacoes').get();
    final Map<String, dynamic>? values = dado;

    // set up the AlertDialog
    SimpleDialog alert = SimpleDialog(
        title: const Center(child: Text("Avaliações Rápidas")),
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
                  var obsAvaliacao = values.values.elementAt(index)['obs'];

                  return Column(
                    children: [
                      GestureDetector(
                          child: ListTile(
                            title: Text('Paciente: $nome'),
                            subtitle: Text('CPF: $cpf,  $data'),
                          ),
                          onTap: () {
                            var aval = Mrc(
                                resultado,
                                FirebaseAuth.instance.currentUser!.uid,
                                obsAvaliacao);
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
                                tooltip: 'Salvar',
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
                              const Text(
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
                                tooltip: 'Excluir',
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
                              const Text(
                                "Excluir registro",
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    decorationThickness: 2),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      )
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, index) {
                  return const Divider(
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
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
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

  Widget _mostraAFB() {
    final docs = _localDb.collection('avaliacoes').get();

    //developer.log(docs.asStream().length.toString(), name: "AFB 2");
    return StreamBuilder<Map<String, dynamic>?>(
      stream: docs.asStream(),
      builder: ((context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
        //developer.log(snapshot.toString());
        if (snapshot.hasData) {
          //developer.log("Tem dados no armazenamento local", name: "LocalStore");
          return FloatingActionButton.extended(
            onPressed: () {
              showAlertDialog(context);
            },
            icon: const Icon(Icons.history),
            label: const Text('Avaliações não salvas'),
            backgroundColor: Colors.indigoAccent,
          );
        } else {
          // developer.log("Não tem dados no armazenamento local",name: "LocalStore");
          return Container();
        }
      }),
    );
  }
}
