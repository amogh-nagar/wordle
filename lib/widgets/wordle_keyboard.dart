import 'package:flutter/material.dart';
import 'package:wordle/widgets/wordle_key.dart';
import 'package:wordle/widgets/wordle_letter_box.dart';

class WordleKeyboard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i in "QWERTYUIOP".split("")) WordleKey( i)
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [for (var i in "ASDFGHJKL".split("")) WordleKey( i)],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [for (var i in "_ZXCVBNM<".split("")) WordleKey( i)],
        ),
      ],
    );
  }
}
