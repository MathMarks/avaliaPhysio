import 'package:flutter/material.dart';
import 'package:projeto_tcc_2/constants.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_tcc_2/profile_page.dart';

class CadastroPaciente extends StatefulWidget {
  const CadastroPaciente({super.key});

  @override
  State<CadastroPaciente> createState() => _CadastroPacienteState();
}

class _CadastroPacienteState extends State<CadastroPaciente> {
  final _formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final susController = TextEditingController();
  final cpfController = TextEditingController();
  final pesoController = TextEditingController();
  final sexoController = TextEditingController();
  final celularController = TextEditingController();
  final celularEmergencialController = TextEditingController();
  final dataNascController = TextEditingController();
  final dataEntradaUti = TextEditingController();
  var _dropDownSexo = "Feminino";

  @override
  void dispose() {
    nomeController.dispose();
    cpfController.dispose();
    pesoController.dispose();
    dataNascController.text = "";
    sexoController.dispose();
    celularController.dispose();
    celularEmergencialController.dispose();

    super.dispose();
  }

  void _cadastrar() {
    if (_formKey.currentState!.validate()) {
      CollectionReference pacientes =
          FirebaseFirestore.instance.collection('pacientes');
      Future<void> addPaciente() {
        // Calling the collection to add a new user
        return pacientes
            //adding to firebase collection
            .add({
              //Data added in the form of a dictionary into the document.
              'nome': nomeController.text,
              'peso': double.parse(pesoController.text),
              'celular': int.parse(celularController.text),
              'contato_emergencial':
                  int.parse(celularEmergencialController.text),
              'cpf': int.parse(cpfController.text),
              'fisioID': FirebaseAuth.instance.currentUser!.uid,
              'nascimento': dataNascController.text,
              'entrada_uti': dataEntradaUti.text,
              'sexo': _dropDownSexo,
              'sus': susController.text
            })
            .then((value) => print("Paciente cadastrado com sucesso!"))
            .catchError((error) => print(
                "Ops, ocorreu algum erro ao cadastrar o paciente" +
                    error.toString()));
      }

      addPaciente();
      print('Apertou Cadastrar');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Profile()));
    }
  }

  void dropDownSexoCB(String? sexo) {
    if (sexo is String) {
      setState(() {
        _dropDownSexo = sexo;
      });
    }
  }

  Widget _buildNomeTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Nome do Paciente',
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
              hintText: 'Digite o CPF do paciente',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSusTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'SUS',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: susController,
            validator: _validarSUS,
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
              hintText: 'Digite o número SUS',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPesoTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Peso',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: pesoController,
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
              hintText: 'Digite o peso do Paciente',
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
            style: TextStyle(
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
              hintText: 'Digite o celular do Paciente',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContatoEmergencialTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Celular Emergencial',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: celularEmergencialController,
            validator: _validarCelular,
            keyboardType: TextInputType.phone,
            style: TextStyle(
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
              hintText: 'Digite um celular para emergência',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDataNascTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Data de Nascimento - 01/01/1980',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
              controller: dataNascController,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.calendar_month,
                  color: Colors.white,
                ),
                hintText: '22/01/1980',
                hintStyle: kHintTextStyle,
              )),
        ),
      ],
    );
  }

  Widget _buildDataEntradaUti() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Data de Entrada na UTI - 01/01/2023',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
              controller: dataEntradaUti,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.calendar_month,
                  color: Colors.white,
                ),
                hintText: '01/01/2023',
                hintStyle: kHintTextStyle,
              )),
        ),
      ],
    );
  }

  Widget _buildCadastrarBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 5.0,
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: () {
          print("teste");
          _cadastrar();
        },
        child: Text(
          'Cadastrar Paciente',
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
                          'Cadastrar Paciente',
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
                        _buildCpfTF(),
                        SizedBox(
                          height: 30.0,
                        ),
                        _buildDataNascTF(),
                        SizedBox(
                          height: 30.0,
                        ),
                        _buildDataEntradaUti(),
                        SizedBox(
                          height: 30.0,
                        ),
                        _buildClelularTF(),
                        SizedBox(
                          height: 30.0,
                        ),
                        _buildContatoEmergencialTF(),
                        SizedBox(
                          height: 30.0,
                        ),
                        _buildSusTF(),
                        SizedBox(
                          height: 30.0,
                        ),
                        _buildSexoTF(),
                        SizedBox(
                          height: 30.0,
                        ),
                        _buildPesoTF(),
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

  String? _validarSUS(String? sus) {
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
}
