import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/providers/game_state_provider.dart';
import 'package:wordle/providers/settings_provider.dart';
import 'package:wordle/widgets/wordle_key.dart';
import 'package:wordle/widgets/wordle_letter_box.dart';

class WordleKeyboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var x = Provider.of<GameSettings>(context);
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i in "QWERTYUIOP".split("")) WordleKey(i, x.getKeyColor(i))
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i in "ASDFGHJKL".split("")) WordleKey(i, x.getKeyColor(i))
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i in "_ZXCVBNM<".split("")) WordleKey(i, x.getKeyColor(i))
          ],
        ),
      ],
    );
  }
}
