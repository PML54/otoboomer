import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';

import 'Musicos.dart';
import 'otoparam.dart';
//import 'package:wave_generator/wave_generator.dart';
void main() => runApp(XylophoneApp());

class XylophoneApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(backgroundColor: Colors.black,
          appBar:  AppBar ( actions: <Widget>[
          IconButton(
          icon: const Icon(Icons.settings),
        tooltip: 'Show Snackbar',
        onPressed: () {
            print (" Pap Tap Appbar");
          },
      ) ]),
          body: XyloFone()
      ),
    );
  }
}

class XyloFone extends StatefulWidget {
  @override
  _XyloFoneState createState() => _XyloFoneState();
}

class _XyloFoneState extends State<XyloFone> {
  //*****
  int laNote = 0;
  int leVolume = 1;
  final musicos = Musicos();

  void playSound({int thisNote}) {
    final player = AudioCache();

    double lenewVolume = leVolume.toDouble()/100000.0;
    print (lenewVolume.toString());
    player.play('z$thisNote.wav', volume: lenewVolume);
  }

  Expanded buildKey({ Color color, int soundNumber , int frekence }) {
    return (
        Expanded(
            child: FlatButton(
              color: color,
              onPressed: () {
                playSound(thisNote: soundNumber);
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
    Slider(
        value: leVolume.toDouble(),

   min:0,
              max: 1000,
              onChanged: (double newValue) {
                setState(() {
                  leVolume= newValue.round();

                });
              },
            ),

            buildKey(color: Colors.blue, soundNumber: 15,   frekence: musicos.frequence(15)),
            buildKey(color: Colors.orange, soundNumber: 27,   frekence: musicos.frequence(27)),
            buildKey(color: Colors.green, soundNumber: 39,   frekence: musicos.frequence(39)),
            buildKey(color: Colors.yellow, soundNumber: 51,   frekence: musicos.frequence(51)),
            buildKey(color: Colors.deepPurpleAccent, soundNumber: 63,   frekence: musicos.frequence(63)),
            buildKey(color: Colors.red, soundNumber: 75,   frekence: musicos.frequence(75)),
            buildKey(color: Colors.deepPurpleAccent, soundNumber: 87,   frekence: musicos.frequence(87)),
            buildKey(color: Colors.red, soundNumber: 99,   frekence: musicos.frequence(99)),
      Expanded(
        child: IconButton(
          icon: const Icon(Icons.settings),
          color: Colors.redAccent,
          iconSize: 75.0,
          tooltip: 'Setings',
          onPressed: () {
            print (" body ");
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Paramoto()));
          },
        ),
      ),

      
      
          ],
        )
    ),);
  }
}


