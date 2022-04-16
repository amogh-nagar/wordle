import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/providers/game_state_provider.dart';
import 'package:wordle/widgets/grid_element.dart';

class WordleGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    

    return Container(child: GridElement());
  }
}
