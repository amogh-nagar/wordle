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

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: GameSettings()),
        ChangeNotifierProxyProvider<GameSettings, GameState>(
            update: (_, settings, previous) => GameState(
                validwords: previous == null ? [] : previous.getvalidwords,
                settings: settings,
                corrword: previous == null ? "" : previous.getcorrword,
                attempts: previous == null ? [] : previous.getattempts,
                attempted: previous == null ? 0 : previous.getattempted)),
      ],
      child: MaterialApp(
        theme: new ThemeData(scaffoldBackgroundColor: HexColor("#5A189A")),
        home: WordleScreen(),
      ),
    );
  }
}
