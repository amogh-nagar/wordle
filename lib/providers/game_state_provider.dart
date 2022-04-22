import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:twemoji/twemoji.dart';
import 'package:wordle/data/dialogue.dart';
import 'package:wordle/data/wordle_repo.dart';
import 'package:wordle/providers/settings_provider.dart';

class GameState extends ChangeNotifier {
  List<String> validwords;
  var corrword;

  final GameSettings settings;
  final List<String> attempts;
  int attempted;

  GameState({
    this.validwords,
    this.settings,
    this.corrword,
    this.attempts,
    this.attempted,
  });

  List<String> get getvalidwords => validwords;
  List<String> get getattempts => attempts;
  String get getcorrword => corrword;
  int get getattempted => attempted;
  Future<void> updatewords() async {
    final words = await loadwords(settings.wordsize);
    validwords = words;
    corrword = words[(settings.idx + 1) % validwords.length];
    var x = Random().nextInt(validwords.length - 1);
    settings.incrementidx(x);
    notifyListeners();
  }

  void changecorrword() {
    var x = Random().nextInt(validwords.length - 1);
    settings.incrementidx(x);
    corrword = validwords[(settings.idx + 1) % validwords.length];
    notifyListeners();
  }

  Future<void> changesize(int x) async {
    settings.changeWordSize(x);
    settings.resetcurrattempts();
    attempts.clear();
    attempted = 0;
    await updatewords();
    notifyListeners();
  }

  void newCorrectWord(String word) {
    corrword = validwords[Random().nextInt(validwords.length)];
    notifyListeners();
  }

  void updatecurrentattemp(String key, BuildContext context) {
    if (attempts.length <= attempted) {
      attempts.add("");
    }
    var currentAttempt = attempts[attempted];

    if (key == "_") {
      // handle enter press
      settings.updatecurattempts();
      if (currentAttempt.length < settings.wordsize) {
        // incompete(context);
        return;
      }
      print("valid words are $validwords");

      if (!validwords.contains(currentAttempt.toLowerCase())) {
        // notinwordslist(context);
        return;
      }
      if (currentAttempt.toLowerCase() == corrword) {
        settings.resetcurrattempts();
        settings.incrementstreak();
        settings.updatelevel();
        changecorrword();

        settings.mpclear();
        attempts.clear();
        attempted = 0;

        notifyListeners();
        if (settings.level == 2 || settings.level == 3 || settings.level == 4) {
          // levelup(context, settings);
          return;
        }

        // nextlevel(context, settings);
        return;
      } else {
        settings.resetstreak();
      }
      attempted++;
      if (attempted >= settings.attempts) {
        settings.resetcurrattempts();
        attempts.clear();
        attempted = 0;

        // lost(context);
      }
      notifyListeners();
    } else if (key == "<") {
      // handle backpress
      if (currentAttempt.isEmpty) {
        // backspace(context);
        return;
      }
      currentAttempt = currentAttempt.substring(0, currentAttempt.length - 1);
      attempts[attempted] = currentAttempt;
    } else {
      if (currentAttempt.length >= settings.wordsize) {
        // longer(context);
        return;
      }

      currentAttempt += key;
      attempts[attempted] = currentAttempt;
    }

    notifyListeners();
  }

  Color getBgColor(String letter) {
    Color x = Colors.grey;
    if (corrword.toString().indexOf(letter) == letter.toLowerCase())
      x = Colors.green;
    else if (corrword.contains(letter.toLowerCase())) x = Colors.orangeAccent;

    return x;
  }
}
