import 'package:mjg/Mentsu.dart';
import 'package:mjg/Utilities/NumberSelector.dart';

enum MentsuType {
  Head,
  Shuntsu,
  Koutsu,
  Kantsu;

  Mentsu toMentsu(NumberSelector NS, int gameWind, int playerWind) {
    Mentsu output;
    switch (this) {
      case MentsuType.Head:
        output = Mentsu(NS.pickRandomNumber(2), this, gameWind, playerWind);
      case MentsuType.Shuntsu:
        output = Mentsu(NS.pickRandomNumberSequence(), this);
      case MentsuType.Koutsu:
        output = Mentsu(NS.pickRandomNumber(3), this, gameWind, playerWind);
      case MentsuType.Kantsu:
        output = Mentsu(NS.pickRandomNumber(4), this, gameWind, playerWind);
    }
    return output;
  }

  Mentsu toMachi(NumberSelector NS, int gameWind, int playerWind) {
    Mentsu output = toMentsu(NS, gameWind, playerWind);
    output.isCalled = false;
    return output;
  }

  List<int> toNumbers(int number) {
    switch (this) {
      case MentsuType.Head:
        return [number, number];
      case MentsuType.Shuntsu:
        return [number, number + 1, number + 2];
      case MentsuType.Koutsu:
        return [number, number, number];
      case MentsuType.Kantsu:
        return [number, number, number, number];
    }
  }
}
