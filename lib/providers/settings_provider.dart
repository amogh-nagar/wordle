import 'package:provider/provider.dart';

import 'package:flutter/foundation.dart';

class GameSettings extends ChangeNotifier {
  int wordsize;
  int attempts;
  int curattempts;
  bool isexceeded=false;
  GameSettings({this.curattempts=0,this.wordsize = 5, this.attempts = 6});

  void updateattempts(int attempts) {
    attempts = attempts;
    notifyListeners();
  }

  void updatewordssize(int wordsize) {
    wordsize = wordsize;
    notifyListeners();
  }

  void updatecurattempts() {
    curattempts++;
    if(curattempts>attempts){
      isexceeded=true;
    }
    
    notifyListeners();
  }
}
