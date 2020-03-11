import 'package:flutter/material.dart';
import 'Musicos.dart';
import 'package:audioplayers/audio_cache.dart';
class Paramoto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(backgroundColor: Colors.black,
          appBar:  AppBar ( actions: <Widget>[
            Text('Réglage du Volume'),
            IconButton(
              iconSize: 55.0 ,
              icon: const Icon(Icons.arrow_back_ios),
              tooltip: 'Show Snackbar',
              onPressed: () {
                Navigator.pop(context);
                print ( "On est dans paramoto");
                // scaffoldKey.currentState.showSnackBar(snackBar);
              },
            ) ]),
          body: Paramoset()
      ),
    );
  }
}

class Paramoset extends StatefulWidget {
  @override
  _ParamosetState createState() => _ParamosetState();
}

class _ParamosetState extends State<Paramoset> {
  //*****
  double leVolume = 1.0;
  var freqMin  = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
  final musicos = Musicos();
  void playSound({int thisNote, int laQuelle}) {
    final player = AudioCache();
    double lenewVolume =freqMin [laQuelle].toDouble()/7000.0;
    print (lenewVolume.toString() +'playsound');
    player.play('z$thisNote.wav', volume: lenewVolume);
  }
  Row buildSlider ({ Color color, int thisNote  ,int thisFreq}) {
    return Row(
      children: <Widget>[
        Expanded( flex:2,
          child: Text(
              musicos.frequence(thisNote).toString()+' Hz',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
          )
        ),
        Expanded(
          flex:8,
          child: (Slider(
            //label: musicos.frequence(thisNote).toString(),
  label: freqMin [thisFreq].toString(),
  activeColor: color,
  divisions: 20,
  min:0,
  max: 20,
  value:   freqMin[thisFreq].toDouble(),

onChanged: (double newValue) {
setState(() {
freqMin [thisFreq] = newValue.round();
print (freqMin [thisFreq].toString() +'Slider');

playSound(thisNote: thisNote ,laQuelle:thisFreq );

});
},
)),
),
],
);
}
//
Expanded buildKey({ Color color, int soundNumber , int frekence }) {
  return (
      Expanded(
          child: FlatButton(
            color: color,
            onPressed: () {
              playSound(thisNote: soundNumber );

            },
            child: Text(
              "Frequence Button =$frekence",
            ),
          )
      )
  );
}
@override
Widget build(BuildContext context) {
  return Container(child: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildSlider(color: Colors.greenAccent, thisNote: 37, thisFreq: 3),
          buildSlider(color: Colors.blue, thisNote: 52, thisFreq: 4),
          buildSlider(color: Colors.blue, thisNote: 67,  thisFreq: 5),
          buildSlider(color: Colors.blue, thisNote: 82,  thisFreq: 6),
          buildSlider(color: Colors.blue, thisNote: 97, thisFreq: 7),
          buildSlider(color: Colors.blue, thisNote: 108,  thisFreq: 8),


        ],
      )
  ),);
}
}

