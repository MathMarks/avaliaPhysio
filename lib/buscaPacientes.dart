import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_tcc_2/profile_paciente.dart';
import 'dart:developer' as developer;
import 'package:projeto_tcc_2/avaliacoes/mrc.dart';
import 'package:projeto_tcc_2/cadastroPacientes.dart';

class BuscaPacientes extends StatefulWidget {
  final Mrc aval;
  const BuscaPacientes({Key? key, required this.aval}) : super(key: key);

  @override
  State<BuscaPacientes> createState() => _BuscaPacientesState();
}

class _BuscaPacientesState extends State<BuscaPacientes> {
  String nome = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Card(
                child: SizedBox(
                  width: 250,
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
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CadastroPaciente(avaliacaoExterna: widget.aval)));
                },
                icon: const Icon(Icons.add),
                style:
                    IconButton.styleFrom(padding: EdgeInsets.only(right: 10.0)),
              )
            ],
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('pacientes').snapshots(),
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
                        return _mostraListaPacientes(data);
                      }
                      if (data['nome']
                          .toString()
                          .toLowerCase()
                          .startsWith(nome.toLowerCase())) {
                        return _mostraListaPacientes(data);
                      }
                      return Container();
                    });
          },
        ));
  }

  Widget _mostraListaPacientes(data) {
    return GestureDetector(
      onTap: () {
        _confirmacaoVinculo(data);
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

  Future<void> _confirmacaoVinculo(data) async {
    developer.log(data.toString());
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmação de Vínculo'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                    'Deseja vincular a avaliação realizada a: ${data['nome']}?'),
                const SizedBox(height: 10),
                const Text(
                    'Será redirecionado para a página do paciente em seguida.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Confirmar'),
              onPressed: () {
                widget.aval.cpfPaciente = data['cpf'];
                CollectionReference avaliacao =
                    FirebaseFirestore.instance.collection('avaliacao');
                Future<void> salvaAvaliacao() {
                  return avaliacao
                      .add({
                        'fisioID': widget.aval.fisioID,
                        'obsAvaliacao': widget.aval.obsAvaliacao,
                        'data': widget.aval.data,
                        'cpfPaciente': widget.aval.cpfPaciente,
                        'resultado': widget.aval.resultado,
                        'tipo': widget.aval.tipo
                      })
                      .then((value) =>
                          developer.log('Avaliação salva com sucesso!'))
                      .catchError((error) => developer.log(
                          "Ops, ocorreu algum erro ao cadastrar a Avaliação: ${error.toString()} "));
                }

                salvaAvaliacao();
                developer.log('Confirmado!');
                /* Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfilePaciente(data: data))); */
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePaciente(data: data),
                    ),
                    (route) => true);
              },
            ),
            TextButton(
              child: const Text('Cancelar'),
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
