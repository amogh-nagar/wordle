import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:wordle/data/wordle_repo.dart';
import 'package:wordle/providers/settings_provider.dart';

class GameState extends ChangeNotifier {
  List<String> validwords;
  var corrword;
  final GameSettings settings;
  final List<String> attempts;
  int attempted;
  int idx = 0;
  GameState(this.validwords, this.settings, this.corrword, this.attempts,
      this.attempted);

  List<String> get getvalidwords => validwords;
  List<String> get getattempts => attempts;
  String get getcorrword => corrword;
  int get getattempted => attempted;
  Future<void> updatewords() async {
    final words = await loadwords(settings.wordsize);

    validwords = words;
    corrword = words[(idx + 1) % validwords.length];
    idx++;
    notifyListeners();
  }

  void newCorrectWord(String word) {
    corrword = validwords[Random().nextInt(validwords.length)];
    notifyListeners();
  }

  void updatecurrentattemp(String key) {
    if (attempts.length <= attempted) {
      attempts.add("");
    }
    print("attempts: $attempts");
    var currentAttempt = attempts[attempted];

    if (key == "_") {
      // handle enter press

      if (currentAttempt.length < settings.wordsize) {
        print("attempted word incomplete");
        return;
      }
      print("valid words are $validwords");

      if (!validwords.contains(currentAttempt.toLowerCase())) {
        print("curr $currentAttempt");
        print("not in valid words list");
        return;
      }
      attempted++;
    } else if (key == "<") {
      // handle backpress
      if (currentAttempt.isEmpty) {
        print("cannot backspace on empty string");
        return;
      }
      currentAttempt = currentAttempt.substring(0, currentAttempt.length - 1);
      attempts[attempted] = currentAttempt;
    } else {
      if (currentAttempt.length >= settings.wordsize) {
        print("trying to type word longer than correct word length");
        return;
      }
      currentAttempt += key;
      attempts[attempted] = currentAttempt;
    }

    notifyListeners();
  }
}
