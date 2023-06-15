import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto_tcc_2/avaliacoes/avalNaoSalvas.dart';
import 'package:projeto_tcc_2/relatorios/graphs/graphMRC.dart';
import 'package:projeto_tcc_2/relatorios/pdf_manip.dart';
import 'dart:io';
import 'package:to_csv/to_csv.dart' as exportCSV;
import 'package:projeto_tcc_2/relatorios/graphs/graphMRC2.dart' as w;

class RelatorioMRC extends StatefulWidget {
  final dynamic cpf;
  const RelatorioMRC({Key? key, required this.cpf}) : super(key: key);
  //CPF do paciente
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
            centerTitle: true,
            actions: <Widget>[
              PopupMenuButton(itemBuilder: (BuildContext bc) {
                return [
                  PopupMenuItem(
                      value: '/rPDF',
                      child: TextButton(
                        style: TextButton.styleFrom(
                            minimumSize: const Size.fromHeight(30),
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.white),
                        onPressed: () async {
                          final avalRelSnapshot = await FirebaseFirestore
                              .instance
                              .collection('avaliacao')
                              .where('cpfPaciente', isEqualTo: widget.cpf)
                              .get();

                          var teste = w.buildGraphData(avalRelSnapshot.docs);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      w.graphmrcT(dataAval: teste))));
                        },
                        child: const Text('Gráfico'),
                      )),
                  PopupMenuItem(
                    value: '/rCSV',
                    child: TextButton(
                      style: TextButton.styleFrom(
                          minimumSize: const Size.fromHeight(30),
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white),
                      onPressed: () async {
                        final avalRelSnapshot = await FirebaseFirestore.instance
                            .collection('avaliacao')
                            .where('cpfPaciente', isEqualTo: widget.cpf)
                            .get();

                        var dadosCSV = w.buildCsvData(avalRelSnapshot.docs);

                        List<String> header = [];

                        header.add('No.');
                        header.add('Resultado');
                        header.add('Data');
                        // header.add('Mobile');
                        // header.add('ID Number');

                        exportCSV.myCSV(header, dadosCSV);
                      },
                      child: const Text('Gerar CSV'),
                    ),
                  ),
                  PopupMenuItem(
                    value: '/rGRA',
                    child: TextButton(
                      style: TextButton.styleFrom(
                          minimumSize: const Size.fromHeight(30),
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white),
                      onPressed: () async {
                        final avalRelSnapshot = await FirebaseFirestore.instance
                            .collection('avaliacao')
                            .where('cpfPaciente', isEqualTo: widget.cpf)
                            .get();

                        final pacienteSnapshot = await FirebaseFirestore
                            .instance
                            .collection('pacientes')
                            .where('cpf', isEqualTo: widget.cpf)
                            .get();

                        // w.buildGraphData(avalRelSnapshot.docs);

                        final data =
                            await PdfManip.createDataList(avalRelSnapshot.docs);

                        final pacienteInfo = pacienteSnapshot.docs;

                        //print(pacienteInfo[0].data());

                        final file = await PdfManip.relatorioPdfMrc(
                            data, pacienteInfo[0].data());
                        await PdfManip.openFile(file);
                      },
                      child: const Text('Gerar PDF'),
                    ),
                  ),
                ];
              })
            ]),
        body: Column(
          children: [
            /* 
            GraphMRC(avaliacoes: avaliacoes), */
            Flexible(
              child: StreamBuilder<QuerySnapshot>(
                stream: avaliacoes,
                builder: (context, snapshots) {
                  return (snapshots.connectionState == ConnectionState.waiting)
                      ? const Center(
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
