import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangeProfileInfo extends StatefulWidget {
  const ChangeProfileInfo({super.key});

  @override
  State<ChangeProfileInfo> createState() => _ChangeProfileInfoState();
}

class _ChangeProfileInfoState extends State<ChangeProfileInfo> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _crefitoController = TextEditingController();
  final TextEditingController _celularController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [],
      ),
      body: Container(
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
            const SizedBox(
              height: 60,
            ),
            const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://images.pexels.com/photos/1772123/pexels-photo-1772123.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
              radius: 100,
            ),
            const SizedBox(
              height: 60,
            ),
            const Divider(),
            _inputTextEdit("Seu nome", "nome", _nomeController),
            const SizedBox(
              height: 30,
            ),
            _inputTextEdit("Crefito", "crefito", _crefitoController),
            const SizedBox(
              height: 30,
            ),
            _inputTextEdit("Celular", "celular", _celularController),
            const SizedBox(
              height: 30,
            ),
          ]),
        ),
      ),
    );
  }

  Widget _inputTextEdit(
      String label, String value, TextEditingController controller) {
    final user = FirebaseAuth.instance.currentUser!;
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("fisioterapeuta")
            .doc(user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active &&
              snapshot.hasData) {
            return Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIconColor: MaterialStateColor.resolveWith(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.focused)) {
                            return Colors.green;
                          }
                          if (states.contains(MaterialState.error)) {
                            return Colors.red;
                          }
                          return Colors.grey;
                        }),
                        labelText: label,
                        //floatingLabelStyle: TextStyle(backgroundColor: Colors.white),
                        floatingLabelStyle: const TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      initialValue: snapshot.data![value].toString(),
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.edit))
                ],
              ),
            );
          }
          return Container();
        });
  }
}
