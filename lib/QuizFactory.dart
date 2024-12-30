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
  for (int i = 0; i < 100000; i++) {
    if (a.yaku.yaku.contains('일기통관')) {
      break;
    }
    a = quizFactory.generateHandInfo();
  }
  test(a);
  print(a.yaku.yaku);
}
