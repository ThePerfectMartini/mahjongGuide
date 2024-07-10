import 'package:flutter_mahjong_yakuguide/variable.dart';
import 'package:collection/collection.dart';

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
menzentsumo_check(Map hand_map, List<String> yaku) {
  if (hand_map['화료형태'] == '쯔모') yaku.add('멘젠쯔모');
}

// 핑후
pingfu_check(Map hand_map, List<String> yaku) {
  int standBu = 20;
  if (hand_map['화료형태'] == '론'){
    standBu = 30;
  }
  if (hand_map['부수'] == standBu){
    yaku.add('핑후');
  }
}

// 이페코 & 량페코
ipeko_check(Map hand_map, List<String> yaku) {
  Map<int, int> frequency = {};

  int ipekoCount = 0;

  for (int n in hand_map['슌츠']) {
    if (frequency.containsKey(n)) {
      frequency[n] = frequency[n]! + 1;
    } else {
      frequency[n] = 1;
    }
  }

  frequency.forEach((key, value) {
    if (value >= 2) {
      ipekoCount++;
    }
  });

  switch (ipekoCount) {
    case 1:
      yaku.add('이페코');
    case 2:
      yaku.add('량페코');
  }
}

// 역패, 삼원패
yakuHai_check(Map hand_map, List<String> yaku) {
  List<int> range = hand_map['커츠'] + hand_map['깡쯔'];
  bool pgWind = (globalWind == playerWind);
  for (int n in range) {
    if (pgWind && n == 40 + globalWind){
      yaku.add('더블 ' + letterMap[globalWind]!);
    }else if (n == 40 + globalWind) {
      yaku.add('판풍 ' + letterMap[globalWind]!);
    } else if (n == 40 + playerWind) {
      yaku.add('자풍 ' + letterMap[playerWind]!);
    } else if (n > 44) {
      yaku.add(letterMap[n - 40]!);
    }
  }
}

// 탕야오
tanyao_check(List<int> body, List<String> yaku) {
  bool tanyao = true;
  for (int n in body) {
    if (n % 10 == 1 || n % 10 == 9 || n >= 40) {
      tanyao = false;
    }
  }
  if (tanyao) yaku.add('탕야오');
}

// 2판 역

// 삼색동순 & 삼색동각
Sanshoku_check(Map hand_map, List<String> yaku) {
  List<int> number = List.generate(9, (int index) => index + 1);
  String type = '';

  if (hand_map['슌츠'].length >= 3) {
    type = '슌츠';
  } else if (hand_map['커츠'].length >= 3) {
    type = '커츠';
  }
  if (type != '') {
    for (int i in number) {
      bool a = hand_map[type].contains(10 + i);
      bool b = hand_map[type].contains(20 + i);
      bool c = hand_map[type].contains(30 + i);
      if (a && b && c) {
        if (type == '슌츠') {
          yaku.add('삼색동순');
          break;
        } else {
          yaku.add('삼색동각');
          break;
        }
      }
    }
  }
}

// 일기통관
ittsu_check(Map hand_map, List<String> yaku) {
  if (hand_map['슌츠'].length >= 3) {
    int kind = 10;
    while (kind <= 30) {
      bool a = hand_map['슌츠'].contains(kind + 1);
      bool b = hand_map['슌츠'].contains(kind + 4);
      bool c = hand_map['슌츠'].contains(kind + 7);
      if (a && b && c) {
        yaku.add('일기통관');
        break;
      }
      kind += 10;
    }
  }
}

// 또이또이
toitoi_check(Map hand_map, List<String> yaku) {
  // 멘젠처리는 상위함수에서
  if (hand_map['슌츠'].length == 0) {
    yaku.add('또이또이');
  }
}

// 산안커
sanankou_check(Map hand_map, List<String> yaku) {
  var grouped = groupBy(hand_map['후로'], (int count) => count);
  int cuz = grouped[2]?.length ?? 0;
  int kanz = grouped[4]?.length ?? 0;

  if (cuz + kanz == 3) {
    yaku.add('산안커');
  }
}

// 삼깡츠
sankanz_check(Map hand_map, List<String> yaku) {
  if (hand_map['깡쯔'].length == 3) {
    yaku.add('산깡쯔');
  }
}

// 찬타 & 준찬타
chanta_check(Map hand_map, List<String> yaku) {
  List body = hand_map['슌츠'] + hand_map['커츠'] + hand_map['깡쯔'];
  body.add(hand_map['머리']);
  bool chanta = true;
  bool junchanta = true;
  for (int n in body) {
    if (n >= 40) junchanta = false;
    if (!(n % 10 == 1 || n % 10 == 9 || n >= 40)) {
      chanta = false;
    }
  }
  if (chanta) {
    if (junchanta) {
      yaku.add('준찬타');
    } else {
      yaku.add('찬타');
    }
  }
}

// 혼노두
honroutou_check(List<int> body, List<String> yaku) {
  bool honroutou = true;
  for (int n in body) {
    if (!(n % 10 == 1 || n % 10 == 9 || n >= 40)) {
      honroutou = false;
    }
  }
  if (honroutou) yaku.add('혼노두');
}

// 소삼원
shousangen_check(Map hand_map, List<String> yaku) {
  List<int> body = hand_map['커츠'] + hand_map['깡쯔'];
  bool cond = hand_map['머리'] > 44 && body.length >= 2;
  if (cond) {
    int count = 0;
    for (int n in body) {
      if (n > 44) count++;
    }
    if (count == 2) {
      yaku.add('소삼원');
    }
  }
}

// 3판 역

// 량페코 : 이페코에서 처리가능

// 준찬타 : 찬타에서 처리가능

// 혼일색 & 청일색
honitsu_check(Map hand_map, List<String> yaku) {
  List<int> body = hand_map['슌츠'] + hand_map['커츠'] + hand_map['깡쯔'];
  body.add(hand_map['머리']);
  Set<int> cond = body.map((n) => n ~/ 10).toSet();
  switch (cond.length) {
    case 1:
      yaku.add('청일색');
    case 2:
      if (cond.contains(4)) yaku.add('혼일색');
  }
}

// 청일색 : 혼일색에서 처리가능
