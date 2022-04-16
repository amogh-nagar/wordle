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
    await updatewords();
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
        : Color.fromARGB(255, 227, 255, 246);
    print("color: $x");
    return x;
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
        print("attempted word incomplete");
        return;
      }
      print("valid words are $validwords");

      if (!validwords.contains(currentAttempt.toLowerCase())) {
        print("not in valid words list");
        return;
      }
      if (currentAttempt.toLowerCase() == corrword) {
        settings.resetcurrattempts();
        settings.incrementstreak();
        settings.updatelevel();
        changecorrword();
        mp.clear();
        attempts.clear();
        attempted = 0;

        notifyListeners();
        if (settings.level == 2 || settings.level == 3 || settings.level == 4) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                  child: Dialog(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24.0)),
                    ),
                    backgroundColor: Color.fromARGB(255, 157, 234, 70),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Center(
                                child: Text(
                              "Hurray!",
                              style: GoogleFonts.mulish(
                                  fontSize: 32, fontWeight: FontWeight.w700),
                            )),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Twemoji(
                            emoji: '🤩',
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
                              "You have leveled up!",
                              style: GoogleFonts.mulish(
                                  fontSize: 15, fontWeight: FontWeight.w700),
                            )),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Center(
                                child: Text(
                              "You are now on level ${settings.level}",
                              style: GoogleFonts.mulish(
                                  fontSize: 21, fontWeight: FontWeight.w700),
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
          return;
        }
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                child: Dialog(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(24.0)),
                  ),
                  backgroundColor: Color.fromARGB(255, 157, 234, 70),
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
                            "You have reached level ${settings.level.toStringAsFixed(1)}",
                            style: GoogleFonts.mulish(
                                fontSize: 15, fontWeight: FontWeight.w700),
                          )),
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

        return;
      } else {
        settings.resetstreak();
      }
      attempted++;
      notifyListeners();
    } else if (key == "<") {
      // handle backpress
      if (currentAttempt.isEmpty) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                child: Dialog(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(24.0)),
                  ),
                  backgroundColor: Color.fromARGB(255, 253, 98, 87),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Center(
                              child: Text(
                            "Cannot Backspace on Empty String!",
                            style: GoogleFonts.mulish(
                                fontSize: 15, fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Twemoji(
                          emoji: '😑',
                          height: 80,
                          width: 80,
                        ),
                        const SizedBox(
                          height: 30,
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
        return;
      }
      currentAttempt = currentAttempt.substring(0, currentAttempt.length - 1);
      attempts[attempted] = currentAttempt;
    } else {
      if (currentAttempt.length >= settings.wordsize) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                child: Dialog(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(24.0)),
                  ),
                  backgroundColor: Color.fromARGB(255, 253, 98, 87),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Center(
                              child: Text(
                            "Trying to type word longer than correct word length",
                            style: GoogleFonts.mulish(
                                fontSize: 15, fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Twemoji(
                          emoji: '😑',
                          height: 80,
                          width: 80,
                        ),
                        const SizedBox(
                          height: 30,
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
        return;
      }
      currentAttempt += key;
      attempts[attempted] = currentAttempt;
    }

    notifyListeners();
  }
}
