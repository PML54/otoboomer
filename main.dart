import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otoboomer/otograf.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audio_cache.dart';
import 'musicos.dart';

void main() {
  runApp(XylophoneApp());
}

class XylophoneApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ne Maeche pas
      title: " OTOPAUL . Comparez vos Oreilles avec Votre Petit-Fils  ",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.black, appBar: AppBar(), body: Paramoset()),
    );
  }
}

//********* Statefull
class Paramoset extends StatefulWidget {
  @override
  _ParamosetState createState() => _ParamosetState();
}

class _ParamosetState extends State<Paramoset> {
//
  double leVolume = 1.0; // Pas sur
  final versioname = '1.032606';
  //1.032603  RAZ à chaque lancement
  // Name  '1.032606'  Random
  //final youngName = "PAUL";
  //final oldName = "FRANCINE";
  final youngName = "OTOXWRHEF";
  final oldName = "OTOXWRHCK";
  final int nbValues = 10;
  var freqMin = [0, for (var i = 0; i < 2 * 10; i++) 0];
  var freqMinStr = ['0', for (var i = 0; i < 2 * 10; i++) '0'];
  var freqMinStrFirst = ['0', for (var i = 0; i < 2 * 10; i++) '0'];
  var freqMinStrSecond = ['0', for (var i = 0; i < 2 * 10; i++) '0'];
  var freqGlobStr = ['0', for (var i = 0; i < 2 * 2 * 10; i++) '0'];
  final musicos = Musicos(); // Frequence de  Bases
  int otoPlayer = 1;
  Color colorBoomer = Colors.red;
  Color colorYoung = Colors.red;
  final Color colorActive = Colors.green;
  final Color colorInactive = Colors.grey;
  static int myRunning = 0;

// Mes assais Actuels
  var freqTest = [36, 48, 60, 67, 73, 79, 84, 91, 94, 96, 103, 106, 108];
  var userAuto = UserAuto(); // Mini classe de Base
  List<UserAuto> dataOto;
  // ************  Function *************
// Passage des Frequences en dataOto
  putInBloc() {
 _loadList(maPref: youngName);
    for (int i = 0; i < nbValues; i++) {
      freqGlobStr[i] = freqMinStrFirst[i];
    }
    for (int i = 0; i < nbValues; i++) {
      freqGlobStr[nbValues + i] = freqMinStrSecond[i];
    }

    // recuperer les gammes de Fréquences en 100 de HZ
    dataOto = [
      for (var i = 0; i < 2 * nbValues; i++)
        UserAuto(
            user: i < 10 ? oldName : youngName,
            //hertz: musicos.frequence(freqTest[i % nbValues]),
            hertz: musicos.gamme(freqTest[i % nbValues]),
            otoLevel: int.parse(freqGlobStr[i]))
    ];
  }

  //***********  Function ****************
  double computeVolume({int thisStep, int maxStep}) {
    double startVolume = 1 / 2500;
    double lenewVolume = startVolume;
    for (int i = 1; i < thisStep; i++) lenewVolume = lenewVolume * 1.20;
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
    // buildSlider(color: Colors.greenAccent, thisNote: 36, thisFreq: 1),
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

  //
  Future<bool> _saveList({var maPref}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setStringList(maPref, freqMinStr);
  }

  //**************
  Future<bool> _loadList({var maPref}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      freqMinStr = prefs.getStringList(maPref);
      freqMinStrFirst = prefs.getStringList(oldName);
      freqMinStrSecond = prefs.getStringList(youngName);
    });
    return true;
  }

  //**************

//**********  end Functions

  @override
  Widget build(BuildContext context) {
    if (myRunning == 0) {
      _saveList(maPref: oldName);
      _saveList(maPref: youngName);
      myRunning++;
    }
    return Scaffold(
      backgroundColor: Colors.black,
      //appBar: AppBar(title: Text("Mardi")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          //var freqTest = [36, 48, 60, 67, 73, 79, 84, 91, 94, 96, 103, 106, 108];
          buildSlider(color: Colors.greenAccent, thisNote: 36, thisFreq: 0),
          buildSlider(color: Colors.blue, thisNote: 48, thisFreq: 1),
          buildSlider(color: Colors.greenAccent, thisNote: 60, thisFreq: 2),
          buildSlider(color: Colors.brown, thisNote: 67, thisFreq: 3),
          buildSlider(color: Colors.blue, thisNote: 73, thisFreq: 4),
          buildSlider(color: Colors.indigo, thisNote: 79, thisFreq: 5),
          buildSlider(color: Colors.brown, thisNote: 84, thisFreq: 6),
          buildSlider(color: Colors.blue, thisNote: 91, thisFreq: 7),
          buildSlider(color: Colors.blue, thisNote: 94, thisFreq: 8),
          buildSlider(color: Colors.indigo, thisNote: 96, thisFreq: 9),
          //buildSlider(color: Colors.blue, thisNote: 103, thisFreq: 11),
          // buildSlider(color: Colors.blue, thisNote: 106, thisFreq: 12),
          //   buildSlider(color: Colors.indigo, thisNote: 108, thisFreq: 13),
        ],
      ),
      bottomNavigationBar: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              icon: const Icon(Icons.directions_walk),
              tooltip: 'Boomer',
              iconSize: 50.0,
              color: colorBoomer,
              onPressed: () {
                setState(() {
                  otoPlayer = 1;
                  colorYoung = colorInactive;
                  colorBoomer = colorActive;

_loadList(maPref: oldName);
                  for (int i = 0; i < nbValues; i++) {
                    freqMin[i] = int.parse(freqMinStr[i]);
                  }
                });
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.save),

            // A ce niveau Creer Une Liste d(objets
            iconSize: 50.0,
            color: Colors.blue,
            tooltip: 'Save Results',

            // Prepare dor Grafics
            onPressed: () {
              setState(() {
                for (int i = 0; i < nbValues; i++) {
                  freqMinStr[i] = freqMin[i].toString();
                }

                if (otoPlayer == 1) _saveList(maPref: oldName);
                if (otoPlayer == 2) _saveList(maPref: youngName);
              });
            },
          ),
          //   Graphics************************
          IconButton(
              icon: const Icon(Icons.pie_chart),
              tooltip: versioname,
              iconSize: 50.0,
              color: Colors.blueAccent,
              onPressed: () {
                putInBloc();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Otografic(),
                    settings: RouteSettings(
                      arguments: dataOto,
                    ),
                  ),
                );
              }),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              icon: const Icon(Icons.tag_faces),
              tooltip: 'Young',
              iconSize: 50.0,
              color: colorYoung,
              onPressed: () {
                setState(() {
                  otoPlayer = 2;
                  colorYoung = colorActive;
                  colorBoomer = colorInactive;
                   _loadList(maPref: youngName);

                  for (int i = 0; i < nbValues; i++) {
                    freqMin[i] = int.parse(freqMinStr[i]);
                  }
                });
              },
            ),
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
