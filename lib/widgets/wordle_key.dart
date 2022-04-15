import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/providers/game_state_provider.dart';

class WordleKey extends StatelessWidget {
  final String letter;

  const WordleKey(this.letter);

  @override
  Widget build(BuildContext context) {
    Widget keyCap;

    double width = 40;
    if (letter == "_") {
      keyCap = Icon(Icons.keyboard_return, size: 20);
    } else if (letter == "<") {
      keyCap = Icon(Icons.backspace_outlined, size: 20);
    } else {
      width = 30;
      keyCap = Text(
        letter,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      );
    }
    return InkWell(
      onTap: () {
        Provider.of<GameState>(context).updatecurrentattemp(letter);
      },
      child: Container(
        width: width,
        height: 60,
        alignment: Alignment.center,
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            shape: BoxShape.rectangle,
            color: Color.fromARGB(44, 44, 44, 44)),
        child: keyCap,
      ),
    );
  }
}
