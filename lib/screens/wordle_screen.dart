import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:twemoji/twemoji.dart';
import 'package:wordle/providers/game_state_provider.dart';
import 'package:wordle/widgets/wordle_bar.dart';
import 'package:wordle/widgets/wordle_grid.dart';
import 'package:wordle/widgets/wordle_keyboard.dart';

class WordleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      body: Container(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [WordleBar(), WordleGrid(), WordleKeyboard()]),
      ),
    );
  }
}
