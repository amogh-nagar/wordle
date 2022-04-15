import 'package:flutter/material.dart';
import 'package:wordle/providers/game_state_provider.dart';
import 'package:wordle/providers/settings_provider.dart';
import 'package:wordle/screens/wordle_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

void main() => runApp(MyHome());

class MyHome extends StatefulWidget {
  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: GameSettings()),
          ChangeNotifierProxyProvider<GameSettings, GameState>(
              update: (_, settings, previous) => 
                GameState(
                  previous == null ? [] : previous.getvalidwords,
                  settings,
                  previous == null ? "" : previous.getcorrword,
                  previous == null ? [] : previous.getattempts,
                  previous == null ? 0 : previous.getattempted
                  )
          ),
        ],
        child:MaterialApp(
          home: WordleScreen(),
        ) ,
        );
  }
}
