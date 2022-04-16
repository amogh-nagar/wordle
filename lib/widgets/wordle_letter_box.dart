import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wordle/providers/game_state_provider.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:wordle/providers/settings_provider.dart';

class WordleLetterBox extends StatelessWidget {
  final String letter;
  final String correctword;
  final bool attempted;
  final int pos;
  WordleLetterBox(
    this.pos,
    this.letter,
    this.attempted,
    this.correctword,
  );

  BoxBorder getBorder() {
    if (!attempted) return Border.all(color: Colors.grey, width: 2);
    return Border.all(color: Colors.transparent, width: 2);
  }

  Color getTextColor() {
    // if (!attempted) return Colors.black87;
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    Color getBgColor() {
      print("correctword $correctword");
      if (!attempted) return null;
      Color x = Colors.grey;
      if (correctword[pos] == letter.toLowerCase())
        x = Colors.green;
      else if (correctword.contains(letter.toLowerCase()))
        x = Colors.orangeAccent;
      // Provider.of<GameSettings>(context, listen: false).setmp(letter, x);
      return x;
    }

    return Container(
      width: 50,
      height: 50,
      padding: EdgeInsets.all(10),
      alignment: Alignment.center,
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
          border: getBorder(),
          color: getBgColor(),
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Text(
        letter.toUpperCase(),
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: getTextColor()),
      ),
    );
  }
}
