import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import '../Widgets/Reusable-Widget.dart';

class EvaluateScreen extends StatefulWidget {
  const EvaluateScreen({Key? key,  this.employeeInfo,  this.eval, this.proj, this.time }) : super(key: key);

  final employeeInfo;
  final eval;
  final proj;
  final time;

  @override
  _EvaluateScreenState createState() => _EvaluateScreenState();
}

class _EvaluateScreenState extends State<EvaluateScreen> {
  @override
  Map<String, double> data = new Map();
  Map<String, double> data1 = new Map();
  Map<String, double> data2 = new Map();

  @override
  void initState() {
    data.addAll({
      'Last Evaluation': widget.eval*100,
    });
    data1.addAll({
      'Projects': widget.proj.toDouble(),
    });
    data2.addAll({
      'Time at company': widget.time.toDouble(),
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
        title: Text("${widget.employeeInfo['name']} (${widget.employeeInfo['department']})"),
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
        padding: const EdgeInsets.fromLTRB(15,5,0,0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
              PieChart(
                dataMap: data1,
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
              PieChart(
                dataMap: data2,
                chartType: ChartType.ring,
                chartRadius: 120,
                baseChartColor: Colors.grey[300]!,
                colorList: colorList,
                legendOptions: const LegendOptions(
                  showLegends: true,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              firebaseUIInAppButton(context, 'Evaluate' , () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  EvaluateScreen(employeeInfo : widget.employeeInfo,
                )));
              })
            ]),
      ),
    );
  }
}







