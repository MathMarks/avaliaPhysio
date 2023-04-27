import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_tcc_2/profile_paciente.dart';
import 'package:projeto_tcc_2/avaliacoes/avalNaoSalvas.dart';
import 'package:projeto_tcc_2/avaliacoes/mrc.dart';

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
    print(data);
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmação de Vínculo'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                    'Deseja vincular a avaliação realizada a: ${data['nome']}?'),
                SizedBox(height: 10),
                Text(
                    'Será redirecionado para a página do paciente em seguida.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Confirmar'),
              onPressed: () {
                widget.aval.cpfPaciente = data['cpf'];
                CollectionReference avaliacao =
                    FirebaseFirestore.instance.collection('avaliacao');
                Future<void> _salvaAvaliacao() {
                  return avaliacao
                      .add({
                        'fisioID': widget.aval.fisioID,
                        'obsAvaliacao': widget.aval.obsAvaliacao,
                        'data': widget.aval.data,
                        'cpfPaciente': widget.aval.cpfPaciente,
                        'resultado': widget.aval.resultado,
                        'tipo': widget.aval.tipo
                      })
                      .then((value) => print('Avaliação salva com sucesso!'))
                      .catchError((error) => print(
                          "Ops, ocorreu algum erro ao cadastrar a Avaliação: ${error.toString()} "));
                }

                _salvaAvaliacao();
                print('Confirmado!');
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
              child: Text('Vincular depois'),
              onPressed: () {
                print('Adicionou esta avaliação ao vetor de avaliações.');

                avaliacoes.add(widget.aval);
                avaliacoes.forEach((element) {
                  print(element);
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancelar'),
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
