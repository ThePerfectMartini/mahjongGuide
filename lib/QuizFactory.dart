import 'package:mjg/HandMold.dart';
import 'package:mjg/Utilities/NumberSelector.dart';
import 'package:mjg/HandInfo.dart';

import 'package:mjg/test.dart';

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
    if (a.isOnlySimple) {
      test(a);
      print(i);
      break;
    }
    a = quizFactory.generateHandInfo();
  }
}
