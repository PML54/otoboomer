import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:charts_flutter/flutter.dart' as charts;
class HomePage extends StatefulWidget {
  final Widget child;


  HomePage({Key key, this.child}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<charts.Series<FrekDb, String>> _seriesData;
  var freqMin = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  var freqMinStr = ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];


  _generateData() {
   var data1 =
   // 1980  = Paul on lobient par la variabme
   // 200 HZ
   // 30 Volume
    [
      new FrekDb("1980", '200', 30),
      new FrekDb("1980", '500', 40),
      new FrekDb("1980", '1000', 10),
      new FrekDb("1980", '2000', 30),
      new FrekDb("1980", '3000', 40),
      new FrekDb("1980", '5000', 10),
  ];
    var data2 = [
      new FrekDb("1980", '200', 10),
      new FrekDb("1980", '500', 60),
      new FrekDb("1980", '1000', 80),
      new FrekDb("1980", '2000', 80),
      new FrekDb("1980", '3000', 50),
      new FrekDb("1980", '5000', 80),
    ];




    _seriesData.add(
      charts.Series(
        domainFn: (FrekDb frekDb, _) => frekDb.otoHz,
        measureFn: (FrekDb frekDb, _) => frekDb.whoto,
        id: 'PML',
        data: data1,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (FrekDb frekDb, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff990099)),
      ),
    );

    _seriesData.add(
      charts.Series(
        domainFn: (FrekDb frekDb, _) => frekDb.otoHz,
        measureFn: (FrekDb frekDb, _) => frekDb.whoto,
        id: 'FRA',
        data: data2,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (FrekDb frekDb, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff109618)),
      ),
    );



  }
  Future<bool> _loadList({var maPref}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      freqMinStr = prefs.getStringList(maPref);
      return true;
    });
  }
  @override


  void initState() {
    // TODO: implement initState
    super.initState();
    var codeLoad = _loadList(maPref: "FRANCINE");

    for (int i = 0; i < 16; i++) {
      freqMin[i] = int.parse(freqMinStr[i]);
    }
    _seriesData = List<charts.Series<FrekDb, String>>();

    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 1,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff1976d2),

            title: Text('Bilan AUDIOPOL'),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Niveau de Volume / Fréquence',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
                        Expanded(
                          child: charts.BarChart(
                            _seriesData,
                            animate: true,
                            barGroupingType: charts.BarGroupingType.grouped,
                            //behaviors: [new charts.SeriesLegend()],
                            animationDuration: Duration(seconds: 5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}

class FrekDb {
String  otoHz;
String otoLevel;
  int  whoto;

  FrekDb (this.otoHz, this.otoLevel, this.whoto);
}

