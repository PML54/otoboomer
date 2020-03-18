import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audio_cache.dart';
import 'musicos.dart';
import 'otograph.dart';

//import 'package:wave_generator/wave_generator.dart';
void main() {

runApp(XylophoneApp());
 // var freqZen = ["100",2,"101",2,"102",3];
 // runApp(SimpleTimeSeriesChart(freqZen));

}

class XylophoneApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(),
          body: Paramoset()),
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
  var freqMin = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  var freqMinStr = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    ''
  ];
  final musicos = Musicos();

  int otoPlayer = 1;
  var whoIs = "PAUL";
  Color colorBoomer = Colors.red;
  Color colorYoung = Colors.red;
   final Color colorActive = Colors.green;
   final Color colorInactive = Colors.grey;
  //***********  Function ****************
  double computeVolume({int thisStep, int maxStep}) {
    double startVolume = 1 / 2500;
    double lenewVolume = startVolume;
    for (int i = 1; i < thisStep; i++)
      lenewVolume = lenewVolume * 1.20;
    print(lenewVolume.toString() + ' --->decibel');
    if (thisStep == 0) lenewVolume = 0;
    return (lenewVolume);
  }
//****************
//***********  Function ****************
  void playSound({int thisNote, int laQuelle}) {
    final player = AudioCache();
    double lenewVolume = computeVolume(thisStep: freqMin[laQuelle], maxStep: 5);

    if (lenewVolume > 0.1) lenewVolume = 0.1;
    if (thisNote > 96) lenewVolume = lenewVolume + 1.0;

    if (lenewVolume > 0.0 && lenewVolume < 1.1)
      player.play('z$thisNote.wav', volume: lenewVolume);
    print(lenewVolume.toString() + ' --->playsound');
  }
//****************
//***********  Function ****************
  Row buildSlider({Color color, int thisNote, int thisFreq}) {
    return Row(
      children: <Widget>[
        // Mettre  un icone de son
        Expanded(
          child: IconButton(
            icon: const Icon(Icons.speaker_phone),
            color: Colors.redAccent,
            iconSize: 20.0,
            tooltip: 'sounds',
            onPressed: () {
              playSound(thisNote: thisNote, laQuelle: thisFreq);
            },
          ),
        ),
        Expanded(
            flex: 2,
            child: Text(
              musicos.frequence(thisNote).toString() + ' Hz',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            )),
        Expanded(
          flex: 8,
          child: (Slider(
            label: freqMin[thisFreq].toString(),
            activeColor: color,
            divisions: 12,
            min: 0,
            max: 12,
            value: freqMin[thisFreq].toDouble(),
            onChanged: (double newValue) {
              setState(() {
                freqMin[thisFreq] = newValue.round();
                playSound(thisNote: thisNote, laQuelle: thisFreq);
                print(freqMin[thisFreq].toString() + '---->Slider');
              });
            },
          )),
        ),
      ],
    );
  }

//***************

  // Paul
  Future<bool> _saveList({var maPref}) async {
    {
      print(" Save before");
      print(maPref);
      print(" Save after");
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setStringList(maPref, freqMinStr);
  }

  //**************
  // Paul
  Future<bool> _loadList({var maPref}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      freqMinStr = prefs.getStringList(maPref);

    });
    return true;
  }

  //**************

//**********  end Functions

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      //  appBar: AppBar(title: Text("Volume")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildSlider(color: Colors.greenAccent, thisNote: 36, thisFreq: 1),
          buildSlider(color: Colors.blue, thisNote: 48, thisFreq: 2),
          buildSlider(color: Colors.greenAccent, thisNote: 60, thisFreq: 3),
          buildSlider(color: Colors.brown, thisNote: 67, thisFreq: 4),
          buildSlider(color: Colors.blue, thisNote: 73, thisFreq: 5),
          buildSlider(color: Colors.indigo, thisNote: 79, thisFreq: 6),
          buildSlider(color: Colors.brown, thisNote: 84, thisFreq: 7),
          buildSlider(color: Colors.blue, thisNote: 91, thisFreq: 8),
          buildSlider(color: Colors.blue, thisNote: 94, thisFreq: 9),
          buildSlider(color: Colors.indigo, thisNote: 96, thisFreq: 10),
          //buildSlider(color: Colors.blue, thisNote: 103, thisFreq: 11),
          // buildSlider(color: Colors.blue, thisNote: 106, thisFreq: 12),
          //   buildSlider(color: Colors.indigo, thisNote: 108, thisFreq: 13),
        ],
      ),
      bottomNavigationBar: Row(
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.directions_walk),
            tooltip: 'Boomer',
            iconSize: 50.0,
            color: colorBoomer,
            onPressed: () {
              setState(() {
                otoPlayer = 1;
                colorYoung = colorInactive;
                colorBoomer = colorActive;
                var codeLoad = _loadList(maPref: "PAUL");

                for (int i = 0; i < 16; i++) {
                  freqMin[i] = int.parse(freqMinStr[i]);
                }
                print (codeLoad.toString() + "Retour de _LoadList");
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.save),
            iconSize: 50.0,
            color: Colors.red,
            tooltip: 'Save Results',
            onPressed: () {
              setState(() {
                for (int i = 0; i < 16; i++) {
                  freqMinStr[i] = freqMin[i].toString();
                }
                print(otoPlayer.toString());
                if (otoPlayer == 1) _saveList(maPref: "PAUL");
                if (otoPlayer == 2) _saveList(maPref: "FRANCINE");
              });
            },
          ),
    /* Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
    return (HomePage());
    }*/
          IconButton(
            icon: const Icon(Icons.pie_chart),
            tooltip: 'Grafics',
            iconSize: 50.0,
            color: Colors.red,
            onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return (HomePage());
                  }
    )
              );
    }


          ),
          IconButton(  // Load
            icon: const Icon(Icons.refresh),
            tooltip: 'refresh',
            iconSize: 50.0,
            color: Colors.red,
            onPressed: () {
              setState(() {

              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.tag_faces),
            tooltip: 'Young',
            iconSize: 50.0,
            color: colorYoung,
            onPressed: () {
              setState(() {
                otoPlayer = 2;
                whoIs = "FRANCINE";
                colorYoung = colorActive;
                colorBoomer = colorInactive;
                var codeLoad = _loadList(maPref: whoIs);

                for (int i = 0; i < 16; i++) {
                  freqMin[i] = int.parse(freqMinStr[i]);
                }
              });
            },


          ),
        ],
      ),
    );
  }
}

//84
//91
//96
//103
//108
