import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import '../Widgets/Reusable-Widget.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class EvaluateScreen extends StatefulWidget {
  const EvaluateScreen({Key? key,  this.employeeInfo,  this.eval, this.proj, this.time,  this.months }) : super(key: key);

  final employeeInfo;
  final eval;
  final proj;
  final time;
  final months;


  @override
  _EvaluateScreenState createState() => _EvaluateScreenState();
}

class _EvaluateScreenState extends State<EvaluateScreen> {
  @override
  Map<String, double> data = new Map();
  Map<String, double> data1 = new Map();
  Map<String, double> data2 = new Map();
  late final modelPath;
  var predValue = "";

  @override
  void initState() {
    data.addAll({
      'Last Evaluation': widget.eval * 100,
    });
    FirebaseModelDownloader.instance
        .getModel(
        "lastModel",
        FirebaseModelDownloadType.localModel,
        FirebaseModelDownloadConditions(
          iosAllowsCellularAccess: true,
          iosAllowsBackgroundDownloading: false,
          androidChargingRequired: false,
          androidWifiRequired: false,
          androidDeviceIdleRequired: false,
        )
    )
        .then((customModel) {
      // Download complete. Depending on your app, you could enable the ML
      // feature, or switch from the local model to the remote model, etc.

      // The CustomModel object contains the local path of the model file,
      // which you can use to instantiate a TensorFlow Lite interpreter.
      final localModelPath = customModel.file;
      final interpreter =  Interpreter.fromFile(localModelPath);
      final val1 = widget.time.toDouble();
      final val2 = widget.eval;
      final val3 = widget.months.toDouble();
      final val4 = widget.proj.toDouble();
      var input = [
        [val2, val4, val3,val1]
      ];
      var output = List.filled(1, 0).reshape([1, 1]);
      interpreter.run(input, output);
      print(output[0][0]);
      this.setState(() {
        predValue = output[0][0].toString();
      });      // ...
    });

    super.initState();
  }


    final colorList = <Color>[
      Colors.greenAccent,
    ];

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("${widget.employeeInfo['name']} (${widget
              .employeeInfo['department']})"),
          backgroundColor: Colors.green,
          actions: const <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20.0),
            ),
          ],
          actionsIconTheme: const IconThemeData(
              size: 30.0,
              color: Colors.white,
              opacity: 10.0
          ),
        ),
        body: Container(
          padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: MediaQuery
              .of(context)
              .size
              .height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("Assets/background.png"),
                fit: BoxFit.cover,
              )),
          child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 35,
                ),
                PieChart(
                  dataMap: data,
                  chartType: ChartType.ring,
                  chartRadius: 120,
                  baseChartColor: Colors.grey[300]!,
                  colorList: colorList,
                  legendOptions: const LegendOptions(
                    showLegends: true,
                  ),
                ),
                const SizedBox(
                  height: 55,
                ),
                firebaseUIInAppButton(context, 'Evaluate', () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) =>
                          EvaluateScreen(employeeInfo: widget.employeeInfo,
                          )));
                })
              ]),
        ),
      );
    }
  }








