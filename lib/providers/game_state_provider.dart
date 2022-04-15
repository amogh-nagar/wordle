import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:twemoji/twemoji.dart';
import 'package:wordle/data/wordle_repo.dart';
import 'package:wordle/providers/settings_provider.dart';

class GameState extends ChangeNotifier {
  List<String> validwords;
  var corrword;
  final GameSettings settings;
  final List<String> attempts;
  Map<String, Color> mp = Map();
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

  void setmp(String letter, Color c) {
    mp[letter] = c;
    print("hashmap ${mp}");
    notifyListeners();
  }

  Color getKeyColor(String letter) {
    var x = mp != null && mp.containsKey(letter)
        ? mp[letter]
        : Color.fromARGB(255, 199, 199, 199);
    print("color: $x");
    return x;
  }

  void updatecurrentattemp(String key, BuildContext context) {
    if (attempts.length <= attempted) {
      attempts.add("");
    }
    print("attempts: $idx");
    var currentAttempt = attempts[attempted];

    if (key == "_") {
      // handle enter press

      if (currentAttempt.length < settings.wordsize) {
        print("attempted word incomplete");
        return;
      }
      print("valid words are $validwords");

      if (!validwords.contains(currentAttempt.toLowerCase())) {
        print("not in valid words list");
        return;
      }
      if (currentAttempt.toLowerCase() == corrword) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                child: Dialog(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(24.0)),
                  ),
                  backgroundColor: Colors.lightGreen,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Center(
                              child: Text(
                            "You Win!",
                            style: GoogleFonts.mulish(
                                fontSize: 32, fontWeight: FontWeight.w700),
                          )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Twemoji(
                          emoji: '🎉',
                          height: 80,
                          width: 80,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Center(
                              child: Text(
                            "Next Wordle",
                            style: GoogleFonts.mulish(
                                fontSize: 25, fontWeight: FontWeight.w700),
                          )),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
        idx++;

        attempts.clear();
        attempted = 0;
        notifyListeners();
        return;
      }
      attempted++;
      notifyListeners();
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
