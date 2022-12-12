//@dart = 2.9
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:open_file/open_file.dart';

class PdfInvoiceApi {
  static Future<File> generate(Map mp) async {
    var data = await rootBundle.load("assets/fonts/Arial.ttf");
    var myFont = Font.ttf(data);

    describ({String value}) {
      return Container(
        width: 10 * PdfPageFormat.mm,
        height: 10 * PdfPageFormat.mm,
        child: Padding(
          padding: EdgeInsets.all(4),
          child: Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              Text(value,
                  style:
                      TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
                  textDirection: pw.TextDirection.ltr),
              SizedBox(width: 5 * PdfPageFormat.mm),
            ],
          ),
        ),
      );
    }

    Widget costumer() {
      return Container(
        margin: EdgeInsets.all(0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(children: <Widget>[
                Center(
                    child: Text('Project Name',
                        style: TextStyle(
                            fontWeight: pw.FontWeight.bold, fontSize: 30))),
              ]),
            ]),
      );
    }

    Widget lastyears() {
      return Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
        child: Table(
          border: TableBorder.all(style: BorderStyle.solid, width: 2),
          children: [
            TableRow(children: <Widget>[
              describ(value: 'The Year'),
              describ(value: 'Number of Moles'),
              describ(value: 'The predicted pH'),
            ]),
            TableRow(children: [
              describ(value: " "),
              describ(value: " "),
              describ(value: " "),
            ]),
            TableRow(children: [
              describ(value: " "),
              describ(value: " "),
              describ(value: " "),
            ]),
            TableRow(children: [
              describ(value: " "),
              describ(value: " "),
              describ(value: " "),
            ]),
          ],
        ),
      );
    }

    Widget predicted() {
      return Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
        child: Table(
          border: TableBorder.all(style: BorderStyle.solid, width: 2),
          children: [
            TableRow(children: <Widget>[
              describ(value: 'The Year'),
              describ(value: 'Number of Moles'),
              describ(value: 'The predicted pH'),
            ]),
            TableRow(children: [
              describ(value: " "),
              describ(value: " "),
              describ(value: " "),
            ]),
            TableRow(children: [
              describ(value: " "),
              describ(value: " "),
              describ(value: " "),
            ]),
            TableRow(children: [
              describ(value: " "),
              describ(value: " "),
              describ(value: " "),
            ]),
          ],
        ),
      );
    }

    Widget title(String x) {
      return Row(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        children: [
          Text(x,
              style: TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
              textDirection: pw.TextDirection.ltr),
          SizedBox(width: 2 * PdfPageFormat.mm),
        ],
      );
    }

    Widget content(String x) {
      return Row(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        children: [
          Text(x,
              style: TextStyle(fontSize: 14),
              textDirection: pw.TextDirection.ltr),
          SizedBox(width: 2 * PdfPageFormat.mm),
        ],
      );
    }

    final ByteData bytes = await rootBundle.load('images/l.png');
    final Uint8List byteList = bytes.buffer.asUint8List();

    Widget frameShape(int wid) {
      return Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: pw.Image(
              pw.MemoryImage(
                byteList,
              ),
              width: wid * PdfPageFormat.mm,
            ),
          ),
          SizedBox(width: 2 * PdfPageFormat.mm),
        ],
      );
    }

    final pdf = Document();
    pdf.addPage(pw.Page(
        build: (pw.Context context) => Column(children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                costumer(),
                frameShape(25),
              ]),
              title("The previous data:"),
              lastyears(),
              title("The predicted data:"),
              predicted(),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [frameShape(50), frameShape(50)]),
              SizedBox(height: 30),
              content(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. \n'),
              content(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. \n'),
              content(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. \n'),
              content(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. \n'),
              content(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. \n'),
              content(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. \n'),
              content(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. \n'),
              content(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. \n'),
              content(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. 1\n'),
            ])));

    return PdfApi.saveDocument(name: 'Ultimate_KMK_Report.pdf', pdf: pdf);
  }
}

class PdfApi {
  static Future<File> saveDocument({
    String name,
    Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
}
