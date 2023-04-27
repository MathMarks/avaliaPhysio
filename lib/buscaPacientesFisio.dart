import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:projeto_tcc_2/profile_paciente.dart';

class BuscaPacientesFisio extends StatefulWidget {
  const BuscaPacientesFisio({super.key});

  @override
  State<BuscaPacientesFisio> createState() => _BuscaPacientesFisioState();
}

class _BuscaPacientesFisioState extends State<BuscaPacientesFisio> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    print(user.uid);
    var userIn = FirebaseFirestore.instance
        .collection("pacientes")
        .where('fisioID', isEqualTo: user.uid.toString())
        .snapshots();
    print(userIn);
    super.initState();
  }

  String nome = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Card(
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Nome do Paciente...'),
            onChanged: (val) {
              setState(() {
                nome = val;
              });
            },
          ),
        )),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('pacientes')
              .where('fisioID', isEqualTo: user.uid.toString())
              .snapshots(),
          builder: (context, snapshots) {
            return (snapshots.connectionState == ConnectionState.waiting)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: snapshots.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshots.data!.docs[index].data()
                          as Map<String, dynamic>;

                      if (nome.isEmpty) {
                        return GestureDetector(
                          onTap: () {
                            print("Clicou no: " + data.toString());
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ProfilePaciente(data: data)));
                          },
                          child: ListTile(
                              title: Text(
                                data['nome'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                'CPF: ' + data['cpf'].toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ) /* ,
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(data['image']),
                            ), */
                              ),
                        );
                      }
                      if (data['nome']
                          .toString()
                          .toLowerCase()
                          .startsWith(nome.toLowerCase())) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ProfilePaciente(data: data)));
                          },
                          child: ListTile(
                              title: Text(
                                data['nome'].toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                'CPF: ' + data['cpf'].toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ) /* ,
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(data['image']),
                            ), */
                              ),
                        );
                      }
                      return Container();
                    });
          },
        ));
  }
}
