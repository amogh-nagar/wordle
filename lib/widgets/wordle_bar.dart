import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/providers/game_state_provider.dart';
import 'package:wordle/providers/settings_provider.dart';

class WordleBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<GameSettings>(context);
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20, 0, 3),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        WordleAttempts(),
        Container(
          child: Column(
            children: [
              // Text(
              //   'WORDLE',
              //   style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              // ),
              Container(
                padding: EdgeInsets.fromLTRB(5, 5, 4, 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(color: Colors.grey, width: 2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('currrent streak :'),
                    SizedBox(
                      width: 10,
                    ),
                    Text(data.currstreak.toString())
                  ],
                ),
              ),
            ],
          ),
        ),
        Difficulty()
      ]),
    );
  }
}

class WordleAttempts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<GameSettings>(context);

    return Container(
        padding: EdgeInsets.fromLTRB(5, 5, 4, 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          border: Border.all(color: Colors.grey, width: 2),
        ),
        child: Text("${data.curattempts}/${data.attempts} "));
  }
}

class Difficulty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<GameSettings>(context);
    var text;
    var l = data.level;
    print("level $l");
    return Container(
        padding: EdgeInsets.fromLTRB(5, 5, 4, 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          border: Border.all(color: Colors.grey, width: 2),
        ),
        child: Text('L' + l.toStringAsFixed(1)));
  }
}
