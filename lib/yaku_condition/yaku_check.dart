import 'package:flutter_mahjong_yakuguide/variable.dart';

/* 
  특수 
  일발, 영상개화, 창깡, 해저로월, 하저로어

  미완성
  1판
    리치
  2판
    더블리치
    치또이츠

*/

// 1판역

// ** 리치 : TODOS : 현재는 멘젠 판정만 함

// 멘젠 쯔모
menzentsumo_check(Map hand_map, List<String> yaku){
    if (hand_map['화료형태'] == '쯔모') yaku.add('멘젠쯔모');
}

// 핑후
pingfu_check(Map hand_map, List<String> yaku){
  if ((hand_map['슌츠'].length == 4) && (hand_map['대기'] == '양면')) yaku.add('핑후');
}

// 이페코
ipeko_check(Map hand_map, List<String> yaku){
  Map<int,int> frequency = {};

  int ipekoCount = 0;

  for (int n in hand_map['슌츠']){
    if (frequency.containsKey(n)){
      frequency[n] = frequency[n]! + 1;
    }else {
      frequency[n] = 1;
    }
  }

  frequency.forEach((key, value) {
    if (value >= 2){
      ipekoCount ++;
    }
  });

  switch (ipekoCount){
    case 1:
      yaku.add('이페코');
    case 2:
      yaku.add('량페코');
  }
}

// 역패, 삼원패
yakuHai_check(Map hand_map, List<String> yaku){
  List<int> range = hand_map['커츠'] + hand_map['깡츠'];
  for (int n in range){
    if (n == 40 + globalWind){
      yaku.add('판풍패');
    }
    if (n == 40 + playerWind){
      yaku.add('자풍패');
    }
    switch (n){
      case 45:
        yaku.add('삼원패 백');
      case 46:
        yaku.add('삼원패 발');
      case 47:
        yaku.add('삼원패 중');
    }
  }  
}

// 탕야오
tanyao_check(List<int> body, List<String> yaku){
  bool tanyao = true;
  for (int n in body) {
    if (n % 10 == 1 || n % 10 == 9 || n >= 40) {
      tanyao = false;
    }
  }
  if (tanyao) yaku.add('탕야오');
}



// 2판 역

// 삼색동순, 삼색동각 체크
Sanshoku_check(Map hand_map, List<String> yaku){
  List<int> number = List.generate(9, (int index) => index+1);
  for (int i in number){
    bool a = hand_map['슌츠'].contains(10+i);
    bool b = hand_map['슌츠'].contains(20+i);
    bool c = hand_map['슌츠'].contains(30+i);
    if (a && b && c){
      yaku.add('삼색동순');
    }
  }
  
}



// 일기통관


// 또이또이


// 산안커


// 삼색동각


// 삼깡쯔


// 찬타


// 혼노두


// 소삼원



// 3판 역


// 량페코 : 이페코에서 처리가능 


// 준찬타


// 혼일색


// 청일색


