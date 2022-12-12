//@dart = 2.9
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class piechart extends StatefulWidget {
  const piechart({key});

  @override
  State<piechart> createState() => _piechartState();
}

class _piechartState extends State<piechart> {
  List<charts.Series<Task, String>> _seriesPieData;

  _generateData() {
    var piedata = [
      Task('Work', 35.8, Color(0xff3366cc)),
      Task('Eat', 8.3, Color(0xff990099)),
      Task('Commute', 10.8, Color(0xff109618)),
      Task('TV', 15.6, Color(0xfffdbe19)),
      Task('Sleep', 19.2, Color(0xffff9900)),
      Task('Other', 10.3, Color(0xffdc3912)),
    ];

    _seriesPieData.add(
      charts.Series(
        domainFn: (Task task, _) => task.task,
        measureFn: (Task task, _) => task.taskvalue,
        colorFn: (Task task, _) =>
            charts.ColorUtil.fromDartColor(task.colorval),
        id: 'Air Pollution',
        data: piedata,
        labelAccessorFn: (Task row, _) => '${row.taskvalue}',
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seriesPieData = List<charts.Series<Task, String>>();
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              const Text(
                'Time spent on daily tasks',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: charts.PieChart(_seriesPieData,
                    animate: true,
                    animationDuration: Duration(seconds: 5),
                    behaviors: [
                      charts.DatumLegend(
                        outsideJustification:
                            charts.OutsideJustification.endDrawArea,
                        horizontalFirst: false,
                        desiredMaxRows: 2,
                        cellPadding:
                            const EdgeInsets.only(right: 4.0, bottom: 4.0),
                        entryTextStyle: charts.TextStyleSpec(
                            color: charts.MaterialPalette.green.shadeDefault,
                            fontFamily: 'MYRIADPRO',
                            fontSize: 15),
                      )
                    ],
                    defaultRenderer: charts.ArcRendererConfig(
                        arcWidth: 100,
                        arcRendererDecorators: [
                          charts.ArcLabelDecorator(
                              labelPosition: charts.ArcLabelPosition.inside)
                        ])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Pollution {
  String place;
  int year;
  int quantity;

  Pollution(this.year, this.place, this.quantity);
}

class Task {
  String task;
  double taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}

class Sales {
  int yearval;
  int salesval;

  Sales(this.yearval, this.salesval);
}
