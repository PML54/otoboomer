import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
//import 'package:wave_generator/wave_generator.dart';
void main() => runApp(XylophoneApp());

class XylophoneApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(backgroundColor: Colors.black,
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
  void playSound({int thisNote}) {
    final player = AudioCache();
    double lenewVolume = leVolume.toDouble()/10000.0;
    print (lenewVolume.toString());
    player.play('z$thisNote.wav', volume: lenewVolume);
  }

  Expanded buildKey({ Color color, int soundNumber}) {
    return (
        Expanded(
            child: FlatButton(
              color: color,
              onPressed: () {
                playSound(thisNote: soundNumber);
              },
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

            buildKey(color: Colors.blue, soundNumber: 58),
            buildKey(color: Colors.orange, soundNumber: 60),
            buildKey(color: Colors.green, soundNumber: 62),
            buildKey(color: Colors.yellow, soundNumber: 63),
            buildKey(color: Colors.deepPurpleAccent, soundNumber: 65),
            buildKey(color: Colors.red, soundNumber: 67),
          ],
        )
    ),);
  }
}


