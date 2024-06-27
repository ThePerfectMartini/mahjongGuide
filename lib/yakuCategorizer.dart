import 'package:flutter_mahjong_yakuguide/handGenerator.dart';
import 'package:flutter_mahjong_yakuguide/yaku_condition/yaku_check.dart';

yakuCategorizer(Map hand_map,List<int> body, bool menzen){

  // todos: 역별로 파일 분리

  // todos: 주석 잘 달아서 정리하기.

  List<String> yaku = [];

  tanyao_check(body, yaku);
  yakuHai_check(hand_map, yaku);
  

  if (menzen){
    menzentsumo_check(hand_map, yaku);
    pingfu_check(hand_map, yaku);
    ipeko_check(hand_map, yaku);

    
    
  }else{

  }

  if (yaku.length >= 1){
    print(hand_map);
    print(yaku);
  }else{

  }

}