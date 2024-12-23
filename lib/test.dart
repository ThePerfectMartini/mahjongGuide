import 'package:mjg/Enums/MentsuType.dart';
import 'package:mjg/HandInfo.dart';
import 'package:mjg/Mentsu.dart';

void test(HandInfo info) {
  List<int> inHand = info.machi.getNumbers();
  List<int> outHand = [];
  int machiTile = inHand.removeAt(info.machiType.getMachiIndex());
  for (Mentsu i in info.hand) {
    if (i.isCalled || i.type == MentsuType.Kantsu) {
      outHand.addAll(i.getNumbers());
    } else {
      inHand.addAll(i.getNumbers());
    }
  }
  print('${inHand} + ${machiTile}');
  print(outHand);
  print('장풍: ${info.gameWind} 판풍 : ${info.playerWind}');
  print(info.machiType);
  if (info.isMenzen)
    print('멘젠');
  else {
    print('비멘젠');
  }
  print('쯔모? : ${info.isTsumo}');
  print(info.fu);
}

bool testCond(HandInfo info) {
  if (info.isMenzen) {
    if ((info.isTsumo && info.fu == 20) || (!info.isTsumo && info.fu == 30)) {
      test(info);
      print('핑후');
      return true;
    }
  }

  return false;
}
