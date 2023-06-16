import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_tcc_2/constants.dart';
import 'package:projeto_tcc_2/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_tcc_2/profile_page.dart';
import 'dart:developer' as developer;

class CadastroFisio extends StatefulWidget {
  @override
  _CadastroFisioState createState() => _CadastroFisioState();
}

class _CadastroFisioState extends State<CadastroFisio> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nomeController = TextEditingController();
  final cpfController = TextEditingController();
  final crefitoController = TextEditingController();
  final sexoController = TextEditingController();
  final celularController = TextEditingController();
  var _dropDownSexo = "Feminino";

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nomeController.dispose();
    cpfController.dispose();
    crefitoController.dispose();
    sexoController.dispose();
    celularController.dispose();
    super.dispose();
  }

  void dropDownSexoCB(String? sexo) {
    if (sexo is String) {
      setState(() {
        _dropDownSexo = sexo;
      });
    }
  }

  void _cadastrarFisio(fisioID) {
    if (_formKey.currentState!.validate()) {
      CollectionReference pacientes =
          FirebaseFirestore.instance.collection('fisioterapeuta');
      Future<void> addFisio() async {
        // Calling the collection to add a new user
        return await pacientes
            //adding to firebase collection
            .doc(fisioID)
            .set({
              //Data added in the form of a dictionary into the document.
              'nome': nomeController.text,
              'celular': int.parse(celularController.text),
              'cpf': int.parse(cpfController.text),
              'email': emailController.text,
              'sexo': _dropDownSexo,
              'crefito': crefitoController.text
            })
            .then((value) =>
                developer.log("Fisioterapeuta cadastrado com sucesso!"))
            .catchError((error) => developer.log(
                "Ops, ocorreu algum erro ao cadastrar o fisioterapeuta: " +
                    error.toString()));
      }

      addFisio();
      logar(emailController.text, passwordController.text);
    }
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'E-mail',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Digite seu E-mail',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Senha',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: passwordController,
            validator: _validarSenha,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Digite sua senha',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNomeTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Seu nome',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: nomeController,
            validator: _validarNome,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.face,
                color: Colors.white,
              ),
              hintText: 'Digite seu nome',
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
        Text(
          'CPF',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: cpfController,
            validator: _validarCPF,
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.perm_identity_rounded,
                color: Colors.white,
              ),
              hintText: 'Digite seu CPF',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCrefitoTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'CREFITO',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: crefitoController,
            validator: _validarCREFITO,
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.pin_rounded,
                color: Colors.white,
              ),
              hintText: 'Digite seu CREFITO',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSexoTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Gênero',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
            height: 60.0,
            child: DropdownButton(
                alignment: Alignment.center,
                items: const [
                  DropdownMenuItem(child: Text("Feminino"), value: "Feminino"),
                  DropdownMenuItem(
                      child: Text("Masculino"), value: "Masculino"),
                  DropdownMenuItem(child: Text("Outro"), value: "Outro")
                ],
                value: _dropDownSexo,
                onChanged: dropDownSexoCB,
                iconSize: 35,
                iconEnabledColor: Colors.white,
                isExpanded: true,
                underline: Container(),
                dropdownColor: Color(0xFF73AEF5),
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.w600,
                ))),
      ],
    );
  }

  Widget _buildClelularTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Celular',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: celularController,
            validator: _validarCelular,
            keyboardType: TextInputType.phone,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.phone,
                color: Colors.white,
              ),
              hintText: 'Digite seu Celular',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCadastrarBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 5.0,
          padding: const EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: () {
          if (_validarCampos() == null) {
            _criarAuth();
            developer.log('Apertou Cadastrar, cadastro autorizado.');
          } else {
            _erroDialog(context,
                "Verificar os dados fornecidos, existem inconformidades.");
            developer.log('Apertou Cadastrar, cadastro não autorizado.');
          }
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => Profile()));
        },
        child: const Text(
          'Cadastrar',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Cadastrar',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        _buildNomeTF(),
                        SizedBox(height: 30.0),
                        _buildEmailTF(),
                        SizedBox(
                          height: 30.0,
                        ),
                        _buildCpfTF(),
                        SizedBox(
                          height: 30.0,
                        ),
                        _buildClelularTF(),
                        SizedBox(
                          height: 30.0,
                        ),
                        _buildCrefitoTF(),
                        SizedBox(
                          height: 30.0,
                        ),
                        _buildSexoTF(),
                        SizedBox(
                          height: 30.0,
                        ),
                        _buildPasswordTF(),
                        SizedBox(
                          height: 30.0,
                        ),
                        _buildCadastrarBtn(),
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

  Future _criarAuth() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));
    try {
      var userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim())
          .then(
        (value) {
          _cadastrarFisio(value.user!.uid);
        },
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('Senha inserida muito fraca! Tente outra mais forte. $e');
        _erroDialog(context, "Senha muito fraca.");
      } else if (e.code == 'email-already-in-use') {
        print(
            'Já existe uma conta com esse endereço de email, gostaria de realizar o login? $e');
        _erroDialog(context, "E-mail já utilizado, por favor escolha outro.");
      } else if (e.code == 'invalid-email') {
        print("Por favor, insira um endereço de email válido");
        _erroDialog(context, "E-mail inválido.");
      }
    } catch (e) {
      print(e);
    }
  }

  Future logar(email, password) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  String? _validarCampos() {
    if (_formKey.currentState!.validate()) {
      return null;
    } else {
      return 'Por favor, preencha todos os campos corretamente.';
    }
  }

  String? _validarNome(String? nome) {
    if (nome!.length < 6) {
      return 'Digite o nome e sobrenome';
    } else {
      return null;
    }
  }

  String? _validarCPF(String? cpf) {
    if (cpf!.length < 11) {
      return 'Digite um CPF válido';
    } else {
      return null;
    }
  }

  String? _validarCREFITO(String? sus) {
    if (sus!.length < 4) {
      return 'Digite um número SUS válido';
    } else {
      return null;
    }
  }

  String? _validarCelular(String? celular) {
    if (celular!.length < 11) {
      return 'Digite um número de Celular válido';
    } else {
      return null;
    }
  }

  String? _validarSenha(String? senha) {
    RegExp regex = RegExp(r'^(?=.*?[a-z])(?=.*?[0-9]).{5,}$');
    if (senha!.isEmpty) {
      return 'Favor, inserir uma senha.';
    } else {
      if (!regex.hasMatch(senha)) {
        return 'Entre uma senha válida: Ao menos cinco letras e dois números.';
      } else {
        return null;
      }
    }
  }

  void _erroDialog(BuildContext context, String erro) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Dados inválidos"),
          content: Text(erro),
          actions: <Widget>[
            TextButton(
              child: const Text("Fechar"),
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
