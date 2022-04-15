import 'package:flutter/material.dart';

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

  Color getBgColor() {
    print("correctword $correctword");
    print("pos $letter and $pos");
    if (!attempted) return null;
    print("indexof ${correctword.indexOf(letter)}");
    if (correctword[pos] == letter.toLowerCase()) return Colors.green;
    if (correctword.contains(letter.toLowerCase())) return Colors.orangeAccent;
    return Colors.grey;
  }

  BoxBorder getBorder() {
    if (!attempted) return Border.all(color: Colors.grey, width: 2);
    return Border.all(color: Colors.transparent, width: 2);
  }

  Color getTextColor() {
    if (!attempted) return Colors.black87;
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
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
