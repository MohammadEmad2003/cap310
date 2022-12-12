//@dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../../widgets/greenButton.dart';
import '../../../widgets/text_field.dart';
import '../../pdf.dart';
import 'CircleProgress.dart';

class predict extends StatefulWidget {
  const predict({Key key}) : super(key: key);
  @override
  _predictState createState() => _predictState();
}

class _predictState extends State<predict> with SingleTickerProviderStateMixin {
  final databaseReference = FirebaseDatabase.instance.ref('test');

  AnimationController progressController;
  Animation<double> tempAnimation;
  Animation<double> humidityAnimation;

  @override
  void initState() {
    super.initState();
  }

  _DashboardInit(double temp, double humid) {
    progressController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 5000)); //5s

    tempAnimation =
        Tween<double>(begin: -50, end: temp).animate(progressController)
          ..addListener(() {
            setState(() {});
          });

    humidityAnimation =
        Tween<double>(begin: 0, end: humid).animate(progressController)
          ..addListener(() {
            setState(() {});
          });

    progressController.forward();
  }

  double x = 0;
  double y = 0;

  TextEditingController cont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Center(
        child: StreamBuilder(
            stream: databaseReference.onValue,
            builder:
                (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
              if (snapshot.hasData) {
                Map<dynamic, dynamic> map =
                    snapshot.data.snapshot.value as dynamic;
                List<dynamic> l = [];
                l.clear();
                l = map.values.toList();
                x = l[0].toDouble();
                y = l[1].toDouble();
                print("$x , $y");
              } else {
                x = 5;
                y = 5;
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 30),
                  CustomPaint(
                    foregroundPainter: CircleProgress(x.toDouble(), true),
                    child: Container(
                      width: 200,
                      height: 200,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Temperature'),
                            Text(
                              '${x.toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '°C',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  CustomPaint(
                    foregroundPainter: CircleProgress(y.toDouble(), false),
                    child: Container(
                      width: 200,
                      height: 200,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Acidity'),
                            Text(
                              '${y.toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'pH',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        // ignore: sized_box_for_whitespace
                        child: Container(
                            width: 200,
                            child: textField(controller: cont, hint: 'Moles')),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        // ignore: sized_box_for_whitespace
                        child: Container(
                            width: 200,
                            child: textField(
                                controller: cont, hint: 'The future')),
                      ),
                      const SizedBox(height: 10),
                      greenButton(
                          text: 'Predict',
                          onPressed: () async {
                            Map<String, String> mp = {};
                            // DateTime.now(),
                            final pdfFile = await PdfInvoiceApi.generate(mp);
                            PdfApi.openFile(pdfFile);
                          }),
                    ],
                  ),
                  SizedBox(height: 100)
                ],
              );
            }),
      )),
    );
  }
}
