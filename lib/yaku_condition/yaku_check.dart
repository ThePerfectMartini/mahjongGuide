import 'dart:math';

import 'package:flutter_mahjong_yakuguide/handClass.dart';
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
Random random = Random();
// 1판역
riichi(handInfo hand) {
  if (random.nextBool()) hand.yaku.add('리치');
}

dora_check(handInfo hand) {
  int dora = 0;
  int uraDora = 0;
  for (int i = 0; i <= hand.kanCount; i++){
    if (i == 4) continue;
    int target = hand.dora[i] + 1;
    dora += hand.body.where((n) => n == target).length;
    if (hand.yaku.contains('리치')){
      int targetUra = hand.dora[i+4] + 1;
      uraDora += hand.body.where((n) => n == targetUra).length;
    }
  }
  if (dora != 0) hand.yaku.add('도라 $dora');
  if (uraDora != 0) hand.yaku.add('뒷도라 $uraDora');
}

// ** 리치 : TODOS : 현재는 멘젠 판정만 함

// 멘젠 쯔모
menzentsumo_check(handInfo hand) {
  if (hand.agariType) hand.yaku.add('멘젠쯔모');
}

// 핑후
pingfu_check(handInfo hand) {
  if (hand.bu == 20){
    hand.yaku.add('핑후');
  }else if (hand.bu == 30 && !hand.agariType){
    hand.yaku.add('핑후');
  }
}

// 이페코 & 량페코
ipeko_check(handInfo hand) {
  List<int> shunList = hand.getShunNumbers();
  Set<int> shunSet = shunList.toSet();
  if (shunList.length > 1){ // 슌츠가 1개인 조합은 걸러짐
    switch (shunList.length - shunSet.length){
      case 1:
        hand.yaku.add('이페코');
      case 2:
        for (int i in shunSet){
          shunList.remove(i);
        }
        if (shunList.toSet().length == 2){
          hand.yaku.add('량페코');
        }else{
          hand.yaku.add('이페코(특수)'); // 커쯔 3개로 쓰는게 나을수도 있음
        }
        
      case 3:
        hand.yaku.add('량페코(특수)'); // 규격외..
    }
  }
}

// 역패, 삼원패
yakuHai_check(handInfo hand) {
  List<int> jOnly = hand.getFirstNumbers().where((int i) => i > 40).toList();
  bool pgWind = (hand.globalWind == hand.playerWind);
  for (int i in jOnly) {
    int n = i - 40;
    if (pgWind && n == hand.globalWind) {
      hand.yaku.add('더블 ' + letterMap[n]!);
    } else if (n == hand.globalWind) {
      hand.yaku.add('판풍 ' + letterMap[n]!);
    } else if (n == hand.playerWind) {
      hand.yaku.add('자풍 ' + letterMap[n]!);
    } else if (n > 4) {
      hand.yaku.add(letterMap[n]!);
    }
  }
}

// 탕야오
tanyao_check(handInfo hand) {
  if (!hand.body.any((int n) => n % 10 == 1 || n % 10 == 9 || n > 40)){
    hand.yaku.add('탕야오');
  }


}

// 2판 역

// 삼색동순 & 삼색동각
sanshoku_check(handInfo hand) {
  List<int> list = hand.getShunNumbers();
  if (list.length == 2) return;

  String yakuName = '삼색동순';
  
  if (list.length < 2){
    yakuName = '삼색동각';
    list = hand.getFirstNumbers();
  }

  for (int i = 11; i < 20; i+=1){
    if ([i,i+10,i+20].every((e) => list.contains(e))){
      hand.yaku.add(yakuName);
      return;
    }
  }
}

// 일기통관
ittsu_check(handInfo hand) {
  List<int> shunList = hand.getShunNumbers();

  for (int i = 10; i < 40; i+=10){
    if ([i+1,i+4,i+7].every((e) => shunList.contains(e))){
      hand.yaku.add('일기통관');
      return;
    }
  }
}

// 또이또이
toitoi_check(handInfo hand) {
  // 멘젠처리는 상위함수에서
  if (!hand.huro.any((e) => e < 2)) {
    hand.yaku.add('또이또이');
  }
}

// 산안커
sanankou_check(handInfo hand) {
  int count = hand.huro.where((e) => e == 2 || e == 4).length;
  if (count == 3){
    if (hand.agariType){
      hand.yaku.add('산안커');
    }else if(hand.machiType != '샤보'){
      hand.yaku.add('산안커');
    }
  }
}

// 산깡쯔
sankanz_check(handInfo hand) {
  int count = hand.huro.where((e) => e >= 4).length;
  if (count == 3) {
    hand.yaku.add('산깡쯔');
  }
}

// 찬타 & 준찬타 & 혼노두 & 청노두
chanta_check(handInfo hand) {
  int counter = 2;
  List<int> filtered = hand.body.where((n) => n > 40 || n % 10 == 1 || n % 10 == 9).toList();
  if (filtered.length == hand.body.length){
    // 혼노두 or 청노두
    if (filtered.any((n) => n > 40)){
      hand.yaku.add('혼노두');
    }else{
      hand.yaku.add('청노두');
    }
    return;
  }
  for (int i in hand.huro){
    switch (i){
      case 2:
        counter += 3;
      case 3:
        counter += 3;
      case 4:
        counter += 4;
      case 5:
        counter += 4;
      default:
        counter ++;
    }
  }
  if (filtered.length == counter){
    if (filtered.any((n) => n > 40)){
      hand.yaku.add('찬타');
    }else{
      hand.yaku.add('준찬타');
    }
    
  }
}


// 소삼원
shousangen_check(handInfo hand) {
  int head = hand.getHeadNumber();
  List<String> container = ['백','발','중'];
  if (container.every((e) => hand.yaku.contains(e))){
      hand.yaku.add('대삼원');
      return;
  }

  if (head > 44){
    container.remove(letterMap[head-40]);
    if (container.every((e) => hand.yaku.contains(e))){
      hand.yaku.add('소삼원');
    }
  }
}

// 3판 역

// 량페코 : 이페코에서 처리가능

// 준찬타 : 찬타에서 처리가능

// 혼일색 & 청일색
honitsu_check(handInfo hand) {
  List<int> nums = hand.getFirstNumbers();
  nums.add(hand.getHeadNumber());
  
  Set<int> cond = nums.map((n) => n ~/ 10).toSet();
  switch (cond.length) {
    case 1:
      if(cond.first != 4) hand.yaku.add('청일색');
    case 2:
      if (cond.contains(4)) hand.yaku.add('혼일색');
  }
}

// 청일색 : 혼일색에서 처리가능
