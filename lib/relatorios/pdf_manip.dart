import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:open_file/open_file.dart';
import 'package:open_file_plus/open_file_plus.dart';

class PdfManip {
  static Future<File> relatorioPdfMrc(List<List<dynamic>> info) async {
    final pdf = pw.Document();

    final titulos = ['Avaliação', 'MRC - Score', 'Fisioterapeuta'];
    final data = info;

    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.Header(
                level: 0,
                child: pw.Text(
                  'Relatório MRC',
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
    final file = File('${dir!.path}/$name');
    print(file);
    print('${dir.path}/$name');
    await file.writeAsBytes(bytes);
    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;
    print(url);
    await OpenFile.open(url);
  }

  static Future<List<List<dynamic>>> createDataList(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> data) async {
    var row = [];
    var nomeFisioSnap;
    List<List<dynamic>> resultado = [];
    await Future.forEach(data, (element) async {
      row.add(element['tipo']);
      row.add(element['resultado']);
      nomeFisioSnap = await FirebaseFirestore.instance
          .collection('fisioterapeuta')
          .doc(element['fisioID'])
          .get();
      row.add(nomeFisioSnap['nome']);
      print(row);
      resultado.add(row);
      print(resultado);
      row = [];
    });

    print(resultado);

    return Future.value(resultado);
  }
}
