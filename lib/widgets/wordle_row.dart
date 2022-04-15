import 'package:flutter/material.dart';
import 'package:wordle/widgets/wordle_letter_box.dart';

class WordleRow extends StatelessWidget {
  final int wordsize;
  final String word;
  final String correctWord;
  final bool attempted;

  const WordleRow(this.wordsize, this.word, this.correctWord, this.attempted);

  @override
  Widget build(BuildContext context) {
    final List<WordleLetterBox> boxes = List.empty(growable: true);

    for (int j = 0; j < wordsize; j++) {
      var letter = "";
      if (word.length > j) {
        letter = word[j];
      }
      boxes.add(WordleLetterBox(
        j,
        letter,
        attempted,
        correctWord,
      ));
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: boxes,
    );
  }
}
