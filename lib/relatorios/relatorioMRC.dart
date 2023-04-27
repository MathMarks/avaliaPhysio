import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto_tcc_2/avaliacoes/avalNaoSalvas.dart';
import 'package:projeto_tcc_2/relatorios/graphs/graphMRC.dart';

class RelatorioMRC extends StatefulWidget {
  final dynamic cpf;
  const RelatorioMRC({Key? key, required this.cpf}) : super(key: key);

  @override
  State<RelatorioMRC> createState() => _RelatorioMRCState();
}

class _RelatorioMRCState extends State<RelatorioMRC> {
/*   @override
  void initState() {
    super.initState();
  } */

  @override
  Widget build(BuildContext context) {
    dynamic avaliacoes = FirebaseFirestore.instance
        .collection('avaliacao')
        .where('cpfPaciente', isEqualTo: widget.cpf)
        .snapshots();

    return Scaffold(
        appBar: AppBar(
          title: Text("MRC's Realizados"),
        ),
        body: Column(
          children: [
            /* 
            GraphMRC(avaliacoes: avaliacoes), */
            Flexible(
              child: StreamBuilder<QuerySnapshot>(
                stream: avaliacoes,
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

                            if (data.isNotEmpty) {
                              return _listaAvaliacoes(data);
                            }
                            return Container();
                          });
                },
              ),
            ),
          ],
        ));
  }

  Widget _listaAvaliacoes(avaliacoes) {
    var input = DateFormat('yyyy-MM-dd hh:mm:ss')
        .parse(avaliacoes['data'].toDate().toString());
    var output = DateFormat('dd/MM/yy HH:mm:ss').format(input).toString();
    return Column(
      children: [
        GestureDetector(
          onTap: () {},
          child: ListTile(
              title: Text(
                output,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Resultado: ' + avaliacoes['resultado'].toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              )),
        ),
      ],
    );
  }
}
