import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/providers/game_state_provider.dart';
import 'package:wordle/providers/settings_provider.dart';

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

class WordleBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<GameSettings>(context);
    const IconData local_fire_department_sharp =
        IconData(0xea8c, fontFamily: 'MaterialIcons');
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20, 0, 3),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        WordleAttempts(),
        Container(
          child: Column(
            children: [
              // Text(
              //   'WORDLE',
              //   style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              // ),
              Container(
                padding: EdgeInsets.fromLTRB(5, 5, 4, 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(color: Colors.grey, width: 2),
                  color: HexColor("#9D4EDD"),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(local_fire_department_sharp),
                    SizedBox(
                      width: 10,
                    ),
                    Text(data.currstreak.toString()),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Difficulty()
      ]),
    );
  }
}

class WordleAttempts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<GameSettings>(context);

    return Container(
        height: 40,
        padding: EdgeInsets.fromLTRB(5, 5, 4, 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          border: Border.all(color: Colors.grey, width: 2),
          color: HexColor("#9D4EDD"),
        ),
        child: Row(
          children: [
            Text("${data.curattempts}/${data.attempts} "),
            SizedBox(
              width: 5,
            ),
            Icon(Icons.stairs_outlined)
          ],
        ));
  }
}

class Difficulty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<GameSettings>(context);
    var text;
    var l = data.level;
    print("level $l");

    return Container(
        height: 40,
        padding: EdgeInsets.fromLTRB(5, 5, 4, 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          border: Border.all(color: Colors.grey, width: 2),
          color: HexColor("#9D4EDD"),
        ),
        child: Container(
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Level ' + l.toStringAsFixed(1)),
            ],
          ),
        ));
  }
}
