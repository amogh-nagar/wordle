import 'package:flutter/material.dart';

class WordleLetterBox extends StatelessWidget {
  final String letter;
  // final String correctword;
  // final bool attempted;
  // final int pos;
   WordleLetterBox(
    // this.pos,
    this.letter,
    // this.attempted,
    // this.correctword,
  );

  // Color bgcolor() {
  //   if (!attempted) {
  //     return null;
  //   }
  //   if (correctword.contains(letter)) {
  //     return Colors.grey;
  //   }
  //   if (correctword.indexOf(letter) == pos) {
  //     return Colors.yellow;
  //   }
  //   return Colors.orangeAccent;
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      padding: EdgeInsets.all(10),
      alignment: Alignment.center,
      margin: EdgeInsets.all(2),
      decoration:
          BoxDecoration(border: Border.all(color: Colors.grey, width: 2)),
      child: Text(
        letter,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
