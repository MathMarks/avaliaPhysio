import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_tcc_2/constants.dart';
import 'package:projeto_tcc_2/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_tcc_2/cadastroFisio.dart';
import 'package:projeto_tcc_2/menu_avaliacoes.dart';

import 'dart:developer' as developer;

class LoginScreen extends StatefulWidget {
  final String? infoMessage;
  const LoginScreen({Key? key, this.infoMessage}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final bool _rememberMe = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    developer.log(widget.infoMessage.toString());
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.infoMessage != null) {
        await showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: const Text("Aviso"),
                  content: Text("${widget.infoMessage}"),
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
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'E-mail',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: const InputDecoration(
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
        const Text(
          'Senha',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: passwordController,
            obscureText: true,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: const InputDecoration(
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

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        style: TextButton.styleFrom(padding: const EdgeInsets.only(right: 0.0)),
        onPressed: () => print('Apertou esqueceu senha'),
        child: const Text(
          'Esqueceu sua senha?',
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildLoginBtn() {
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
          logar();
          //print('Apertou login');
          /* Navigator.push(
              context, MaterialPageRoute(builder: (context) => Profile())); */
        },
        child: const Text(
          'Acessar',
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

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () => {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const CadastroFisio()))
      },
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Não possui uma conta? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Criar Conta',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvaliacaoRapidaBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.green,
          elevation: 5.0,
          padding: const EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const MenuAvaliacoes()));
        },
        child: const Text(
          'Avaliação Rápida',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Entrar',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      _buildEmailTF(),
                      const SizedBox(height: 30.0),
                      _buildPasswordTF(),
                      // _buildForgotPasswordBtn(),
                      _buildLoginBtn(),
                      _buildSignupBtn(),
                      const SizedBox(height: 10),
                      const Divider(),
                      const SizedBox(height: 18),
                      _buildAvaliacaoRapidaBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future logar() async {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim())
          .then((value) => setState(() {}));
    } on FirebaseAuthException catch (e) {
      String errorMessage =
          "Ocorreu um erro inesperado. Tente novamente mais tarde.";
      if (e.code == 'user-not-found') {
        errorMessage = "Conta não encontrada. Por favor, realize seu cadastro.";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Senha errada, tente novamente.";
      } else if (e.code == 'invalid-email') {
        errorMessage =
            "O formato do seu e-mail está errado. Por favor, verifique e tente novamente.";
      }
      // Show an error popup with the appropriate error message
      _showErrorAlertDialog(errorMessage, context);
    }
    // navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  void _showErrorAlertDialog(String msg, BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("Tentar novamente"),
      onPressed: () {
        navigatorKey.currentState!.popUntil((route) => route.isFirst);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Problema ao efetuar o Login"),
      content: Text(msg),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
