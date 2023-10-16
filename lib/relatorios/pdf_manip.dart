import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:open_file/open_file.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:intl/intl.dart';

class PdfManip {
  static Future<File> relatorioPdfMrc(
      List<List<dynamic>> data, Map<String, dynamic> info) async {
    final pdf = pw.Document();

    final titulos = ['Avaliação', 'MRC - Score', 'Data', 'Fisioterapeuta'];

    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.Text('Relatório MRC',
                textScaleFactor: 2,
                style: pw.Theme.of(context)
                    .defaultTextStyle
                    .copyWith(fontWeight: pw.FontWeight.bold)),
            pw.Padding(padding: const pw.EdgeInsets.only(top: 10)),
            pw.Text('${info['nome']}',
                textScaleFactor: 1.2,
                style: pw.Theme.of(context).defaultTextStyle.copyWith(
                      fontWeight: pw.FontWeight.bold,
                    )),
            pw.Padding(padding: const pw.EdgeInsets.only(top: 20)),
            pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: <pw.Widget>[
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: <pw.Widget>[
                      pw.Text('Data de Nascimento: ${info['nascimento']}'),
                      pw.Text('Gênero: ${info['sexo']}'),
                      pw.Text('Numero SUS: ${info['sus']}'),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: <pw.Widget>[
                      pw.Text('Contato: ${info['celular']}'),
                      pw.Text(
                          'Contato Emergencial: ${info['contato_emergencial']}'),
                    ],
                  )
                ]),
            pw.Header(
                level: 0,
                child: pw.Text(
                  'CPF: ${info['cpf']}',
                )),
            pw.Table.fromTextArray(headers: titulos, data: data)
          ];
        })); // Page

    return saveDocument(name: 'relatorioAvaliaPhysio.pdf', pdf: pdf);
  }

  static Future<File> saveDocument(
      {required String name, required pw.Document pdf}) async {
    final bytes = await pdf.save();
    final dir = await getApplicationSupportDirectory();
    final file = File('${dir.path}/$name');
    // print(file);
    // print('${dir.path}/$name');
    await file.writeAsBytes(bytes);
    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;
    // print(url);
    await OpenFile.open(url);
  }

  static Future<List<List<dynamic>>> createDataList(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> data) async {
    var row = [];
    DocumentSnapshot<Map<String, dynamic>> nomeFisioSnap;
    String date;
    List<List<dynamic>> resultado = [];
    await Future.forEach(data, (element) async {
      row.add(element['tipo']);
      row.add(element['resultado']);
      date = DateFormat('dd/MM/yy HH:mm:ss')
          .format(element['data'].toDate())
          .toString();
      row.add(date);
      //print(date);
      nomeFisioSnap = await FirebaseFirestore.instance
          .collection('fisioterapeuta')
          .doc(element['fisioID'])
          .get();
      row.add(nomeFisioSnap['nome']);
      // print(row);
      resultado.add(row);
      //print(resultado);
      row = [];
    });

    //print(resultado);

    return Future.value(resultado);
  }
}
