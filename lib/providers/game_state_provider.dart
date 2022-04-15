import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:wordle/data/wordle_repo.dart';
import 'package:wordle/providers/settings_provider.dart';

class GameState extends ChangeNotifier {
  final List<String> validwords;
  var corrword;
  final GameSettings settings;
  final List<String> attempts;
  int attempted;

  GameState(this.validwords, this.settings, this.corrword, this.attempts,
      this.attempted);

  List<String> get getvalidwords => validwords;
  List<String> get getattempts => attempts;
  String get getcorrword => corrword;
  int get getattempted => attempted;
  Future<void> updatewords() {
    final words = loadwords(settings.wordsize);
    return words.then((value) {
      validwords.clear();
      validwords.addAll(value);
      corrword = validwords[Random().nextInt(validwords.length)];

      notifyListeners();
    });
  }

  void newCorrectWord(String word) {
    corrword = validwords[Random().nextInt(validwords.length)];
    notifyListeners();
  }

  void updatecurrentattemp(String key) {
    var currattempt = "";
    print("Hello $attempted");
    print(attempts);
    currattempt = attempts.length == 0 ? "" : attempts[attempted];
    if (key == "_") {
      if (currattempt.length < settings.wordsize) {
        return;
      }
      attempted++;
    } else if (key == "<") {
      if (currattempt.isEmpty) {
        return;
      }
      currattempt = currattempt.substring(0, currattempt.length - 1);
    } else {
      if (currattempt.length > settings.wordsize) {
        return;
      }
      currattempt += key;
      attempts.add(currattempt);
    }
    notifyListeners();
  }
}
