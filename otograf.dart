import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'musicos.dart';

// Mercredu 25 Mars J attaque  les Graohiqyes
// dataOto est OK

class Otografic extends StatelessWidget {

  @override

  Widget build(BuildContext context) {
    List <UserAuto> dataOto =  ModalRoute.of(context).settings.arguments;
    List <UserAuto> dataOtoA =  dataOto.sublist (0,9);
    List <UserAuto> dataOtoB =  dataOto.sublist (10,19);

    List<charts.Series<UserAuto, String>> series = [
      charts.Series(
        id: "Francine",
        data: dataOtoA,

        domainFn: (UserAuto series, _) => series.hertz.toString(),
        measureFn: (UserAuto series, _) => series.otoLevel,
        fillColorFn: (_, __) =>
        charts.MaterialPalette.green.shadeDefault,
        //colorFn: (UserAuto series, _) => series.barColor
      ),
      charts.Series(
        id: "Paul",
        data: dataOtoB,
        domainFn: (UserAuto series, _) => series.hertz.toString(),
        measureFn: (UserAuto series, _) => series.otoLevel,
        fillColorFn: (_, __) =>
        charts.MaterialPalette.red.shadeDefault,

      )
    ];
    return Scaffold(
      appBar: AppBar ( actions: <Widget>[ IconButton(
        icon: const Icon(Icons.arrow_back),
        color: Colors.redAccent,
        iconSize: 20.0,
        tooltip: 'Home',
        onPressed: () {
Navigator.pop(context);

        },
      ), ] ) ,
      body: Container(
        height: 400,
        padding: EdgeInsets.all(20),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text(
                  "OtoPol",
                  style: Theme.of(context).textTheme.body2,
                ),
                Expanded(
                  child: charts.BarChart(series, animate: true,
                 //   barGroupingType: charts.BarGroupingType.grouped,
                    animationDuration: Duration(seconds: 5),
                  ),


                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}