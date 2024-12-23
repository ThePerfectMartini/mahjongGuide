import 'package:flutter_mahjong_yakuguide/Enums/MentsuType.dart';
import 'package:flutter_mahjong_yakuguide/Enums/TileType.dart';
import 'package:flutter_mahjong_yakuguide/Utilities/Utils.dart';

class Mentsu {
  final int number;
  final MentsuType type;
  late final int tilekind;
  late final int tileNumber;

  int fu = 0;
  bool isCalled = false;

  late final TileType tileType;

  bool isDragon = false;
  bool isGameWind = false;
  bool isPlayerWind = false;

  Mentsu(this.number, this.type, [int gameWind = 0, int playerWind = 0]) {
    tilekind = number ~/ 10;
    tileNumber = number % 10;
    isCalled = Utils().pickRandomHuro();
    _checkTileType(gameWind, playerWind);
  }

  void _checkTileType(int gWind, int pWind) {
    if (tilekind == 4) {
      tileType = TileType.Honor;
      if (tileNumber > 4) isDragon = true;
      if (tileNumber == gWind) isGameWind = true;
      if (tileNumber == pWind) isPlayerWind = true;
    } else if (tileNumber == 1 || tileNumber == 9) {
      tileType = TileType.Terminal;
    } else if (type == MentsuType.Shuntsu && tileNumber == 7) {
      tileType = TileType.Terminal;
    } else {
      tileType = TileType.Simple;
    }
  }

  int calculateFu() {
    fu = 0;
    switch (type) {
      case MentsuType.Head:
        if (isGameWind) fu += 2;
        if (isPlayerWind) fu += 2;
        if (isDragon) fu = 2;
        return fu;
      case MentsuType.Shuntsu:
        return fu;
      case MentsuType.Koutsu:
        fu = 16;
      case MentsuType.Kantsu:
        fu = 32;
    }

    if (tileType == TileType.Simple) fu ~/= 2;
    if (isCalled) fu ~/= 2;

    return fu;
  }

  // 숫자 배출
  List<int> getNumbers() {
    return type.toNumbers(number);
  }
}
