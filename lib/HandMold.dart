import 'package:flutter_mahjong_yakuguide/Enums/MentsuType.dart';
import 'package:flutter_mahjong_yakuguide/Utilities/Utils.dart';

class HandMold {
  List<MentsuType> generate() {
    MentsuType machi = Utils().pickRandomMachi();
    List<MentsuType> hand = _generateMentsuList(machi);
    return [machi] + hand;
  }

  List<MentsuType> _generateMentsuList(MentsuType machi) {
    bool isHead = machi == MentsuType.Head;
    int handSize = (isHead) ? 4 : 3;
    List<MentsuType> hand =
        List.generate(handSize, (index) => Utils().pickRandomMentsu());
    return (isHead) ? hand : [MentsuType.Head, ...hand];
  }
}
