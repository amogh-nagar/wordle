import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wordle/providers/game_state_provider.dart';
import 'package:wordle/providers/settings_provider.dart';
import 'package:wordle/widgets/wordle_letter_box.dart';
import 'package:provider/provider.dart';
import 'package:wordle/widgets/wordle_row.dart';

var rows = 6;
var wordsize = 5;

class GridElement extends StatefulWidget {
  @override
  State<GridElement> createState() => _GridElementState();
}

class _GridElementState extends State<GridElement> {
  void initState() {
    Provider.of<GameState>(context, listen: false).updatewords();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var gameSettings = Provider.of<GameSettings>(context);
    var gameState = Provider.of<GameState>(context);
    wordsize = gameSettings.wordsize;
    print("Word size ${gameState.attempts}");
    final List<WordleRow> res = List.empty(growable: true);
    for (int i = 0; i < gameSettings.attempts; i++) {
      var word = "";
      if (gameState.attempts.length > i) {
        word = gameState.attempts[i];
      }
      var attempted = false;
      print("att ${gameState.attempted}");
      if (gameState.attempted > i) {
        attempted = true;
      }
      res.add(WordleRow(
        wordsize,
        word,
        gameState.corrword,
        attempted,
      ));
    }
    return Container(
      child:
          Column(crossAxisAlignment: CrossAxisAlignment.center, children: res),
    );
  }
}
