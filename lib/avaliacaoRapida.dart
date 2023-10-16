import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localstore/localstore.dart';
import 'package:projeto_tcc_2/constants.dart';
import 'package:flutter/services.dart';
import 'package:projeto_tcc_2/login_screen.dart';
import 'dart:developer' as developer;

class avaliacaoRapida extends StatefulWidget {
  final int resultadoAval;
  final String? observacao;
  const avaliacaoRapida(
      {Key? key, required this.resultadoAval, this.observacao})
      : super(key: key);

  @override
  State<avaliacaoRapida> createState() => _avaliacaoRapidaState();
}

class _avaliacaoRapidaState extends State<avaliacaoRapida> {
  final _formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final cpfController = TextEditingController();
  final _localDb = Localstore.instance;

  @override
  void initState() {
    nomeController.text = "";
    cpfController.text = "";

    super.initState();
  }

  Widget _buildNomeTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Nome do Paciente',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: nomeController,
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
              hintText: 'Digite o nome do Paciente',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCpfTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'CPF',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: cpfController,
            keyboardType: TextInputType.number,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.perm_identity_rounded,
                color: Colors.white,
              ),
              hintText: 'Digite o CPF do paciente',
              hintStyle: kHintTextStyle,
            ),
          ),
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
                        Text(
                          'Resultado: ${widget.resultadoAval}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        const Text(
                          'Identifique o Paciente',
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
                        _buildCpfTF(),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Column(
                          children: [
                            TextButton(
                                style: TextButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.green),
                                onPressed: () async {
                                  // gets new id
                                  final id = _localDb
                                      .collection('avaliacoes')
                                      .doc()
                                      .id;

                                  // save the item
                                  developer.log("Avaliação Rápida");
                                  var dateRaw =
                                      DateFormat('yyyy-MM-dd hh:mm:ss')
                                          .parse(DateTime.now().toString());
                                  var date = DateFormat('dd/MM/yy HH:mm:ss')
                                      .format(dateRaw)
                                      .toString();
                                  //print(date);
                                  _localDb
                                      .collection('avaliacoes')
                                      .doc(id)
                                      .set({
                                    'nome': nomeController.text,
                                    'cpf': cpfController.text,
                                    'resultado': widget.resultadoAval,
                                    'data': date,
                                    'obs': widget.observacao,
                                    'id': id,
                                  });

                                  // final dado = await _localDb
                                  //     .collection('avaliacoes')
                                  //     .get();

                                  // print(dado);

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const LoginScreen()));
                                },
                                child: const Text("Armazenar Avaliação")),
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
