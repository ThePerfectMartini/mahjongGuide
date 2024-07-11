import 'dart:math';

import 'package:flutter_mahjong_yakuguide/variable.dart';

import 'buCalculator.dart';

class handGenerator {
  Random random = Random();
  late List<int> huro;

  bool menzen = true;

  late Map<int, int> tiles_map;

  late Map<String, dynamic> result_map;

  late List<int> body;

  late List<int> doraList;
  late List<int> uraDoraList;

  init() {
    menzen = true;
    body = [];
    doraList = [];
    uraDoraList = [];
    result_map = {};
    tiles_map = {
      for (int i = 11; i <= 47; i++)
        if (i != 20 && i != 30 && i != 40) i: 4
    };
    addDora();
    tileSet();
    selectAgariTile();
    setWind();

    result_map['부수'] = buCalculator(result_map, menzen);
    result_map['도라표시패'] = doraList;
    result_map['우라도라표시패'] = uraDoraList;
  }

  addDora() {
    doraList
        .add(tiles_map.keys.toList()[random.nextInt(tiles_map.keys.length)]);
    int dora = doraList.last;
    if (dora % 10 == 9) {
      int n = (dora ~/ 10) * 10 + 1;
      tiles_map[n] = tiles_map[n]! - 1;
    } else if (dora == 44) {
      tiles_map[41] = tiles_map[41]! - 1;
    } else if (dora == 47) {
      tiles_map[45] = tiles_map[45]! - 1;
    } else {
      tiles_map[dora + 1] = tiles_map[dora + 1]! - 1;
    }

    uraDoraList
        .add(tiles_map.keys.toList()[random.nextInt(tiles_map.keys.length)]);
    int uraDora = uraDoraList.last;
    if (uraDora % 10 == 9) {
      int n = (uraDora ~/ 10) * 10 + 1;
      tiles_map[n] = tiles_map[n]! - 1;
    } else if (uraDora == 44) {
      tiles_map[41] = tiles_map[41]! - 1;
    } else if (uraDora == 47) {
      tiles_map[45] = tiles_map[45]! - 1;
    } else {
      tiles_map[uraDora + 1] = tiles_map[uraDora + 1]! - 1;
    }
  }

  tileSet() {
    int s = 0;
    int c = 0;
    int k = 0;
    for (int i = 0; i < 4; i++) {
      bool first_con = (random.nextInt(100) < 70);
      bool second_con = (random.nextInt(100) < 10);
      if (first_con) {
        // 80% 확률로 슌츠
        s++;
      } else if (second_con) {
        // 10% 확률로 깡쯔
        k++;
      } else {
        c++;
      }
    }
    result_map['슌츠'] = randomTiles(s, 1);
    result_map['커츠'] = randomTiles(c, 3);
    result_map['깡쯔'] = randomTiles(k, 4);
    result_map['머리'] = randomTiles(1, 2)[0];
    setHuro(s, c, k);
    menzenCheck();
  }

  setHuro(int s, int c, int k) {
    huro = [];
    bool menzen = true;
    for (int i = 0; i < s; i++) {
      if (random.nextBool()) {
        huro.add(0);
      } else {
        huro.add(1);
        menzen = false;
      }
    }
    for (int i = 0; i < c; i++) {
      if (random.nextBool()) {
        huro.add(2);
      } else {
        huro.add(3);
        menzen = false;
      }
    }
    for (int i = 0; i < k; i++) {
      if (random.nextBool()) {
        huro.add(4);
      } else {
        huro.add(5);
        menzen = false;
      }
    }
    result_map['후로'] = huro;
    result_map['멘젠'] = menzen;
  }

  randomTiles(int count, int type) {
    List<int> result = [];

    for (int i = 0; i < count; i++) {
      List<int> availableTiles = [];
      switch (type) {
        case 1: // 슌츠 선택
          tiles_map.forEach((key, value) {
            if ((key % 10 <= 7) && key < 40) {
              int able = value;
              if (able > tiles_map[key + 1]!) able = tiles_map[key + 1]!;
              if (able > tiles_map[key + 2]!) able = tiles_map[key + 2]!;
              for (int i = able; i != 0; i--) {
                availableTiles.add(key);
              }
            }
          });

          int randomInt = random.nextInt(availableTiles.length);
          int selected = availableTiles[randomInt];

          tiles_map[selected] = tiles_map[selected]! - 1;
          tiles_map[selected + 1] = tiles_map[selected + 1]! - 1;
          tiles_map[selected + 2] = tiles_map[selected + 2]! - 1;

          body.add(selected);
          body.add(selected + 1);
          body.add(selected + 2);
          result.add(selected);

        default: // 커츠, 깡쯔, 머리 선택
          tiles_map.forEach((key, value) {
            if (value >= type) availableTiles.add(key);
          });
          int randomInt = random.nextInt(availableTiles.length);
          int selected = availableTiles[randomInt];
          tiles_map[selected] = tiles_map[selected]! - type;
          for (int i = 0; i < type; i++) body.add(selected);
          result.add(selected);
          if (type == 4) addDora();
      }
    }

    return result;
  }

  menzenCheck() {
    huro.forEach((n) {
      if (n % 2 != 0) menzen = false;
    });
  }

  selectAgariTile() {
    late int index;
    List<int> agariProb = [];
    agariProb.add(body.length - 1);
    agariProb.add(body.length - 2);

    if (huro.contains(0)) {
      for (int i = 0; i < huro.length; i++) {
        int index = i * 3;
        if (huro[i] == 0) {
          agariProb.add(index);
          agariProb.add(index + 1);
          agariProb.add(index + 2);
        } else if (huro[i] == 2) {
          agariProb.addAll([index, index, index]);
        }
      }
      index = agariProb[random.nextInt(agariProb.length)];
    } else {
      index = body.length - 1; // 머리선택 (하다까단기)
    }

    if (result_map['슌츠']!.length * 3 >= index + 1) {
      int firstOrLast = (index + 1) % 3;
      int digit = body[index] % 10;
      if (firstOrLast == 2) {
        result_map['대기'] = "간짱";
      } else if (((firstOrLast == 0) && (digit == 3)) ||
          ((firstOrLast == 1) && (digit == 7))) {
        result_map['대기'] = "변짱";
      } else {
        result_map['대기'] = "양면";
      }
    } else if (body.length <= index + 2) {
      result_map['대기'] = "단기";
    } else {
      result_map['대기'] = "샤보";
    }

    // 양면 0, 간짱 1, 변짱 2, / 샤보 3, / 단기 4
    result_map['화료패'] = body[index];
    if (random.nextInt(4) == 0) {
      result_map['화료형태'] = "쯔모";
    } else {
      result_map['화료형태'] = "론";
    }
  }

  setWind() {
    globalWind = random.nextInt(2) + 1; // 반장전 기준
    playerWind = random.nextInt(4) + 1;
  }
}
