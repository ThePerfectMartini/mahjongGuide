import 'package:flutter_mahjong_yakuguide/Enums/MentsuType.dart';
import 'package:flutter_mahjong_yakuguide/Enums/TileType.dart';
import 'package:flutter_mahjong_yakuguide/HandInfo.dart';
import 'package:flutter_mahjong_yakuguide/Mentsu.dart';
import 'package:flutter_mahjong_yakuguide/Utilities/Extension.dart';

class YakuStatus {
  List<String> yaku = [];

  int simpleCount = 0;
  int honorCount = 0;
  int terminalCount = 0;
  int shuntsuCount = 0;
  int koutsuCount = 0;
  int kantsuCount = 0;

  int ankouCount = 0;
  int sameNumberCount = 0;
  List<Mentsu> allHand = [];
  List<Mentsu> mentsus = [];
  List<int> numbers = [];
  List<int> tileNumbers = [];
  Set<int> tileKinds = {};
  Set<int> ipekoSet = {};

  YakuStatus(HandInfo info) {
    _analyzeConditions(info);

    if (info.isMenzen) {
      _shuntsuRelated(info);
    }
    _yakuHai(info.gameWind, info.playerWind);
    _koutsuRelated(info);
    _tileTypeRelated();
    _kindRelated();
    _numberRelated();
  }

  void _analyzeConditions(HandInfo info) {
    allHand = [info.machi] + info.hand;
    mentsus = allHand.where((e) => e.type != MentsuType.Head).toList();
    numbers = mentsus.map((e) => e.number).toList();
    (allHand).forEach((i) {
      switch (i.tileType) {
        case TileType.Simple:
          simpleCount++;
        case TileType.Terminal:
          terminalCount++;
        case TileType.Honor:
          honorCount++;
      }
      switch (i.type) {
        case MentsuType.Shuntsu:
          shuntsuCount++;
          ipekoSet.add(i.number);
        case MentsuType.Koutsu:
          koutsuCount++;
          if (!i.isCalled) {
            ankouCount++;
          }
        case MentsuType.Kantsu:
          koutsuCount++;
          kantsuCount++;
          if (!i.isCalled) {
            ankouCount++;
          }
        case MentsuType.Head:
        // 처리없음 : 맨 밑으로 가야함
      }
      tileKinds.add(i.tileKind);
    });
  }

  void _numberRelated() {
    if (shuntsuCount >= 2 || koutsuCount >= 2) {
      Map<int, Set<int>> digitGroups = {};
      Map<int, Set<MentsuType>> typeGroups = {};
      for (Mentsu mentsu in mentsus) {
        int ones = mentsu.number % 10; // 일의자리 숫자
        int tens = mentsu.number ~/ 10; // 십의자리 숫자

        // 같은 일의자리를 그룹으로 묶기
        digitGroups.putIfAbsent(ones, () => {}).add(tens);
        typeGroups.putIfAbsent(ones, () => {}).add(mentsu.type);
      }

      if (digitGroups.keys.toSet().containsAll({1, 4, 7})) {
        int ittsu = digitGroups[1]!.first;
        if (digitGroups[4]!.first == ittsu && digitGroups[7]!.first == ittsu) {
          yaku.add('일기통관');
          return;
        }
      }
      // 조건에 맞는 그룹이 있는지 확인
      for (var entry in digitGroups.entries) {
        if (entry.value.containsAll({1, 2, 3})) {
          if (!typeGroups[entry.key]!.contains(MentsuType.Shuntsu)) {
            yaku.add('삼색동각');
          } else if (typeGroups[entry.key]!.length == 1) {
            yaku.add('삼색동순');
          }
        }
      }
    }
  }

  void _shuntsuRelated(HandInfo info) {
    if ((info.isTsumo && info.fu == 20) || (!info.isTsumo && info.fu == 30)) {
      yaku.add('핑후');
    }

    if (shuntsuCount - ipekoSet.length == 1) {
      yaku.add('이페코');
    } else if (shuntsuCount - ipekoSet.length == 2) {
      if (numbers.where((e) => e == ipekoSet.first).length == 2) {
        yaku.add('량페코');
      } else {
        yaku.add('이페코'); // 3개 1개 이페코 특수케이스
      }
    }
  }

  void _tileTypeRelated() {
    if (simpleCount == 0) {
      if (shuntsuCount == 0) {
        if (terminalCount == 5) {
          yaku.add('청노두');
        } else {
          yaku.add('혼노두');
        }
      } else {
        if (honorCount == 0) {
          yaku.add('준찬타');
        } else {
          yaku.add('찬타');
        }
      }
    } else if (simpleCount == 5) {
      yaku.add('탕야오');
    }
  }

  void _koutsuRelated(HandInfo info) {
    if (ankouCount == 4) {
      yaku.add('쓰안커');
    } else if (ankouCount == 3) {
      yaku.add('산안커');
    } else if (koutsuCount == 4) {
      yaku.add('또이또이');
    }
    if (kantsuCount == 4) {
      yaku.add('쓰깡쯔');
    } else if (kantsuCount == 3) {
      yaku.add('산깡쯔');
    }
  }

  void _kindRelated() {
    if (tileKinds.length == 1 && tileKinds.contains(4)) {
      yaku.add('자일색');
    } else if (tileKinds.length == 1) {
      yaku.add('청일색');
    } else if (tileKinds.length == 2 && tileKinds.contains(4)) {
      yaku.add('혼일색');
    }
  }

  void _yakuHai(int g, int p) {
    int honorCount = mentsus.where((e) => e.number > 44).length;
    int allCount = allHand.where((e) => e.number > 44).length;
    if (honorCount == 3) {
      yaku.add('대삼원');
      return;
    } else if (honorCount == 2 && allCount == 3) {
      yaku.add('소삼원');
    }
    for (int i in numbers) {
      if (i == 40 + g) yaku.add('자풍');
      if (i == 40 + p) yaku.add('장풍');
      if (i == 45) yaku.add('백');
      if (i == 46) yaku.add('발');
      if (i == 47) yaku.add('중');
    }
  }
}
