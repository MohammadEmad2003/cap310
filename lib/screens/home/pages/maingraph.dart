//@dart = 2.9
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../constants.dart';

class mainGraph extends StatefulWidget {
  const mainGraph({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _mainGraphState createState() => _mainGraphState();
}

class _mainGraphState extends State<mainGraph> {
  List<LiveDataPH> chartDataPH;
  List<LiveDataTEMP> chartDataTEMP;
  ChartSeriesController _chartSeriesControllerPH;
  ChartSeriesController _chartSeriesControllerTEMP;
  final referenceDatase = FirebaseDatabase.instance.ref('test');

  double x;
  double y;

  @override
  void initState() {
    chartDataPH = getChartDataPH();
    chartDataTEMP = getChartDataTEMP();
    Timer.periodic(const Duration(seconds: 1), updateDataSource);
    Timer.periodic(const Duration(seconds: 1), updateDataSourceTEMP);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: referenceDatase.onValue,
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
              } else {
                x = 7;
                y = 5;
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  SfCartesianChart(
                      series: <LineSeries<LiveDataPH, int>>[
                        LineSeries<LiveDataPH, int>(
                          onRendererCreated:
                              (ChartSeriesController controller) {
                            _chartSeriesControllerPH = controller;
                          },
                          dataSource: chartDataPH,
                          color: kGreen,
                          xValueMapper: (LiveDataPH sales, _) => sales.time,
                          yValueMapper: (LiveDataPH sales, _) => sales.speed,
                        )
                      ],
                      primaryXAxis: NumericAxis(
                          majorGridLines: const MajorGridLines(width: 0),
                          edgeLabelPlacement: EdgeLabelPlacement.shift,
                          interval: 3,
                          title: AxisTitle(text: 'Time (seconds)')),
                      primaryYAxis: NumericAxis(
                          axisLine: const AxisLine(width: 0),
                          majorTickLines: const MajorTickLines(size: 0),
                          title: AxisTitle(text: 'The Acidity of Rains (pH)'))),
                  SfCartesianChart(
                      series: <LineSeries<LiveDataTEMP, int>>[
                        LineSeries<LiveDataTEMP, int>(
                          onRendererCreated:
                              (ChartSeriesController controller) {
                            _chartSeriesControllerTEMP = controller;
                          },
                          dataSource: chartDataTEMP,
                          color: kGreen,
                          xValueMapper: (LiveDataTEMP sales, _) => sales.time,
                          yValueMapper: (LiveDataTEMP sales, _) => sales.speed,
                        )
                      ],
                      primaryXAxis: NumericAxis(
                          majorGridLines: const MajorGridLines(width: 0),
                          edgeLabelPlacement: EdgeLabelPlacement.shift,
                          interval: 3,
                          title: AxisTitle(text: 'Time (seconds)')),
                      primaryYAxis: NumericAxis(
                          axisLine: const AxisLine(width: 0),
                          majorTickLines: const MajorTickLines(size: 0),
                          title: AxisTitle(
                              text:
                                  'The Temperature of the weather (Celisus)'))),
                ],
              );
            }));
  }

  int timesy = 19;
  void updateDataSource(Timer timer) {
    chartDataPH.add(LiveDataPH(timesy, y));
    timesy++;
    print(y);
    chartDataPH.removeAt(0);
    _chartSeriesControllerPH.updateDataSource(
        addedDataIndex: chartDataPH.length - 1, removedDataIndex: 0);
  }

  int timesx = 19;
  void updateDataSourceTEMP(Timer timer) {
    chartDataTEMP.add(LiveDataTEMP(timesx, x));
    timesx++;
    print(x);
    chartDataTEMP.removeAt(0);
    _chartSeriesControllerTEMP.updateDataSource(
        addedDataIndex: chartDataTEMP.length - 1, removedDataIndex: 0);
  }

  List<LiveDataTEMP> getChartDataTEMP() {
    return <LiveDataTEMP>[
      LiveDataTEMP(0, 42),
      LiveDataTEMP(1, 47),
      LiveDataTEMP(2, 43),
      LiveDataTEMP(3, 49),
      LiveDataTEMP(4, 54),
      LiveDataTEMP(5, 41),
      LiveDataTEMP(6, 58),
      LiveDataTEMP(7, 51),
      LiveDataTEMP(8, 98),
      LiveDataTEMP(9, 41),
      LiveDataTEMP(10, 53),
      LiveDataTEMP(11, 72),
      LiveDataTEMP(12, 86),
      LiveDataTEMP(13, 52),
      LiveDataTEMP(14, 94),
      LiveDataTEMP(15, 92),
      LiveDataTEMP(16, 86),
      LiveDataTEMP(17, 72),
      LiveDataTEMP(18, 94)
    ];
  }

  List<LiveDataPH> getChartDataPH() {
    return <LiveDataPH>[
      LiveDataPH(0, 42),
      LiveDataPH(1, 47),
      LiveDataPH(2, 43),
      LiveDataPH(3, 49),
      LiveDataPH(4, 54),
      LiveDataPH(5, 41),
      LiveDataPH(6, 58),
      LiveDataPH(7, 51),
      LiveDataPH(8, 98),
      LiveDataPH(9, 41),
      LiveDataPH(10, 53),
      LiveDataPH(11, 72),
      LiveDataPH(12, 86),
      LiveDataPH(13, 52),
      LiveDataPH(14, 94),
      LiveDataPH(15, 92),
      LiveDataPH(16, 86),
      LiveDataPH(17, 72),
      LiveDataPH(18, 94)
    ];
  }
}

class LiveDataTEMP {
  LiveDataTEMP(this.time, this.speed);
  final int time;
  final double speed;
}

class LiveDataPH {
  LiveDataPH(this.time, this.speed);
  final int time;
  final double speed;
}
