
buCalculator(Map hand_map, bool menzen){
  int bu = 20;

  List<int> huro = hand_map['후로'];

  // Todo: 멤버변수 리스트 


  // Todo: 화료 타입별 부수 추가
  if (hand_map['화료형태'] == '쯔모'){
    // 핑후 예외 추가할것 
    bu += 2;
  }else if (menzen){
    bu += 10;
  }



  // Todo: 몸통별 부수 추가
  List<int> cuzOrKanz = hand_map['커츠'] + hand_map['깡쯔'];
  cuzOrKanz = cuzOrKanz.reversed.toList();
  for (int i = 0; i < cuzOrKanz.length; i++){
    int baseBu = 32;
    int digit = cuzOrKanz[i]%10;
    bool tile40 = cuzOrKanz[i] > 40;
    if ( digit != 1 && digit != 9 && !tile40){
      baseBu = baseBu ~/ 2;
    }
    switch (huro[3-i]){
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
  if (hand_map['머리'] > 40) bu += 2; // 자풍, 판풍, 삼원 그리고 연풍패만 해당되게



  // Todo: 대기 부수 추가
  if (hand_map['대기'] == '간짱' || hand_map['대기'] == '변짱' || hand_map['대기'] == '단기') bu += 2;


  // Todo: 리턴으로 부수 제공
  bu = (bu / 10).ceil()*10;
  return bu;

}