import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wordle/providers/game_state_provider.dart';
import 'package:wordle/providers/settings_provider.dart';
import 'package:wordle/widgets/wordle_letter_box.dart';
import 'package:provider/provider.dart';

var rows = 6;
var wordsize = 5;

class GridElement extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<GameSettings>(context);
    var gamestate = Provider.of<GameSettings>(context);
    var state = Provider.of<GameState>(context);
    wordsize = data.wordsize;
    print(data.wordsize);
    final List<Row> res = List.empty(growable: true);
    for (int i = 0; i < rows; i++) {
      final List<WordleLetterBox> boxes = List.empty(growable: true);
      for (int j = 0; j < wordsize; j++) {
        var word = "";
        if (state.attempts.length > i) {
          word = state.attempts[i];
        }
        var attempted = false;
        if (state.attempted > i) {
          attempted = true;
        }
        // boxes.add(WordleLetterBox(
        //   letter: word,
        //   attempted: attempted,
        //   correctword: state.validwords[i],
        // ));
      }
      res.add(Row(
        mainAxisSize: MainAxisSize.min,
        children: boxes,
      ));
    }
    return Container(
      child:
          Column(crossAxisAlignment: CrossAxisAlignment.center, children: res),
    );
  }
}
