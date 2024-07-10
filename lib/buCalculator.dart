import 'package:flutter_mahjong_yakuguide/variable.dart';

buCalculator(Map hand_map, bool menzen) {
  int bu = 20;

  List<int> huro = hand_map['후로'];

  // Todo: 멤버변수 리스트
  


  // Todo: 몸통별 부수 추가
  List<int> cuzOrKanz = hand_map['커츠'] + hand_map['깡쯔'];
  cuzOrKanz = cuzOrKanz.reversed.toList();
  for (int i = 0; i < cuzOrKanz.length; i++) {
    int baseBu = 32;
    int digit = cuzOrKanz[i] % 10;
    bool tile40 = cuzOrKanz[i] > 40;
    if (digit != 1 && digit != 9 && !tile40) {
      baseBu = baseBu ~/ 2;
    }
    switch (huro[3 - i]) {
      case 2:
        baseBu = baseBu ~/ 4;
      case 3:
        baseBu = baseBu ~/ 8;
      case 4:
      case 5:
        baseBu = baseBu ~/ 2;
    }
    bu += baseBu;
  }

  // Todo: 머리 특수 부수 추가
  if (hand_map['머리'] == 40 + globalWind) bu += 2;
  if (hand_map['머리'] == 40 + playerWind) bu += 2;
  if (hand_map['머리'] > 44) bu += 2; // 자풍, 판풍, 삼원 그리고 연풍패만 해당되게

  // Todo: 대기 부수 추가
  if (hand_map['대기'] == '간짱' ||
      hand_map['대기'] == '변짱' ||
      hand_map['대기'] == '단기') bu += 2;

  // Todo: 화료 타입별 부수 추가 - 순서상 마지막으로 옮기기
  if (menzen){
    if (hand_map['화료형태'] == '론'){
      bu += 10;
    }else { // 멘젠 + 쯔모
      if (bu > 20){ // 추가된 부가 있다면 +2부 -> 핑후가 성립할때만 쯔모에 부수 안붙기 때문
        bu += 2;
      }
    }
  }else{
    if (hand_map['화료형태'] == '쯔모'){
      bu += 2;
    }
  }

  // Todo: 리턴으로 부수 제공
  bu = (bu / 10).ceil() * 10;
  return bu;
}
