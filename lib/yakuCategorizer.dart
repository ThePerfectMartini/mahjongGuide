import 'package:flutter_mahjong_yakuguide/handGenerator.dart';

class yakuCategorizer {
  late Map<String, List<int>> hand_map;
  handGenerator handClass;

  late bool menzen;

  yakuCategorizer(this.handClass) {}

  init() {
    List<int> huro = handClass.huro;
    if (huro[0] == 0 && huro[1] == 0 && huro[2] == 0 && huro[3] == 0) {
      menzen = true;
      print('리치');
    } else {
      menzen = false;
      print('역없음');
    }
  }
}
