import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/providers/settings_provider.dart';

class WordleBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        WordleAttempts(),
        Text(
          'WORDLE',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
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

    return Container(child: Text(data.attempts.toString()));
  }
}

class Difficulty extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<GameSettings>(context);
    var text;
    if (data.wordsize == 6) {
      text = 'L1';
    } else if (data.wordsize == 5) {
      text = 'L2';
    } else {
      text = 'L3';
    }

    return Container(child: Text(text));
  }
}
