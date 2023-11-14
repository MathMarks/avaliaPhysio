import 'package:flutter/material.dart';
import 'package:projeto_tcc_2/avaliacaoRapida.dart';
import 'package:projeto_tcc_2/avaliacoes/dinamo.dart';
import 'package:projeto_tcc_2/buscaPacientes.dart';
import 'package:projeto_tcc_2/constants.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_tcc_2/profile_page.dart';
// import 'dart:developer' as developer;

class Dinamometria extends StatefulWidget {
  const Dinamometria({super.key});

  @override
  State<Dinamometria> createState() => _DinamometriaState();
}

class _DinamometriaState extends State<Dinamometria> {
  final _formKey = GlobalKey<FormState>();
  final resultadoController = TextEditingController();

  @override
  void initState() {
    resultadoController.text = "";

    super.initState();
  }

  Widget _buildNomeTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Qual o resultado da dinamometria manual?',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
              controller: resultadoController,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.face,
                  color: Colors.white,
                ),
                hintText: 'Resultado em Kg',
                hintStyle: kHintTextStyle,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ]),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(
                          height: 30.0,
                        ),
                        const Text(
                          'Dinamometria Manual',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        _buildNomeTF(),
                        const SizedBox(height: 30.0),
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
                                      if (FirebaseAuth.instance.currentUser !=
                                          null) {
                                        var aval = Dinamo(
                                            int.parse(resultadoController.text),
                                            FirebaseAuth
                                                .instance.currentUser!.uid,
                                            "");
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BuscaPacientes(
                                                        aval: aval)));
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    avaliacaoRapida(
                                                        resultadoAval: int.parse(
                                                            resultadoController
                                                                .text),
                                                        observacao: "")));
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
                                              builder: (context) =>
                                                  const Profile()));
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
