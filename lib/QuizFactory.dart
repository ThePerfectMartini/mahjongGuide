import 'package:flutter_mahjong_yakuguide/HandInfo.dart';
import 'package:flutter_mahjong_yakuguide/HandMold.dart';
import 'package:flutter_mahjong_yakuguide/Utilities/NumberSelector.dart';

import 'package:flutter_mahjong_yakuguide/test.dart';

class QuizFactory {
  HandMold HM = HandMold();

  HandInfo generateHandInfo() {
    return HandInfo(NumberSelector(), HM.generate());
  }
}

void main() {
  QuizFactory quizFactory = QuizFactory();
  HandInfo a = quizFactory.generateHandInfo();
  for (int i = 0; i < 100; i++) {
    if (a.yaku.yaku.isNotEmpty){
      break;
    }else{
      a = quizFactory.generateHandInfo();
    }
  }
  test(a);
  print(a.yaku.yaku);
}
