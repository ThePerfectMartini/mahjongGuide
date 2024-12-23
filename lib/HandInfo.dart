import 'package:flutter_mahjong_yakuguide/Enums/MachiType.dart';
import 'package:flutter_mahjong_yakuguide/Enums/MentsuType.dart';
import 'package:flutter_mahjong_yakuguide/Enums/TileType.dart';
import 'package:flutter_mahjong_yakuguide/Mentsu.dart';
import 'package:flutter_mahjong_yakuguide/Utilities/NumberSelector.dart';
import 'package:flutter_mahjong_yakuguide/Utilities/Utils.dart';
import 'package:flutter_mahjong_yakuguide/Yaku/Yaku.dart';

class HandInfo {
  late Mentsu machi;
  late MachiType machiType;
  late List<Mentsu> hand;
  late List<int> dora;
  late bool isMenzen;
  int fu = 20;

  late YakuStatus yaku;

  bool isTsumo = Utils().random.nextBool();
  int gameWind = Utils().random.nextInt(4) + 1;
  int playerWind = Utils().random.nextInt(4) + 1;

  int steak = Utils().random.nextInt(4);

  HandInfo(NumberSelector NS, List<MentsuType> mold) {
    machi = mold.removeAt(0).toMachi(NS, gameWind, playerWind);
    hand = mold.map((type) => type.toMentsu(NS, gameWind, playerWind)).toList();
    dora = List.generate(8, (_) => NS.pickRandomNumber(1));
    machiType = _pickMachiType();
    isMenzen = !hand.any((i) => i.isCalled);

    _sumAllFu();

    yaku = YakuStatus(this);
  }

  MachiType _pickMachiType() {
    switch (machi.type) {
      case MentsuType.Head:
        return MachiType.Tanki;
      case MentsuType.Shuntsu:
        List<MachiType> picks = [MachiType.Kanchan];
        if (machi.tileType == TileType.Simple) {
          picks.add(MachiType.RyanmenFront);
          picks.add(MachiType.RyanmenBack);
        } else if (machi.tileNumber == 1) {
          picks.add(MachiType.RyanmenFront);
          picks.add(MachiType.PenchanBack);
        } else {
          picks.add(MachiType.PenchanFront);
          picks.add(MachiType.RyanmenBack);
        }
        return Utils().pickRandomElement(picks);
      case MentsuType.Koutsu:
        // 샤보일때 론 : 밍커 / 쯔모 : 안커로 계산
        if (!isTsumo) machi.isCalled = true;
        return MachiType.Shanpon;
      case MentsuType.Kantsu:
        throw Exception("Error: Kantsu는 대기로 선택될 수 없음.");
    }
  }

  void _sumAllFu() {
    // 대기 관련 부수 추가
    if (machiType.name.contains('chan') || machiType == MachiType.Tanki) {
      fu += 2;
    }

    // 몸통 머리 부수 추가
    ([machi] + hand).forEach((item) {
      fu += item.calculateFu();
    });

    if (isTsumo && isMenzen && fu == 20) return;

    // 쯔모 2 멘젠론 10 추가
    if (isTsumo) {
      fu += 2;
    } else if (isMenzen) {
      fu += 10;
    }

    fu = ((fu + 9) ~/ 10) * 10;
  }
}
