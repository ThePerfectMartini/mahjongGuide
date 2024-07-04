import 'package:flutter_mahjong_yakuguide/handGenerator.dart';
import 'package:flutter_mahjong_yakuguide/variable.dart';
import 'package:flutter_mahjong_yakuguide/yaku_condition/yaku_check.dart';

yakuCategorizer(Map hand_map,List<int> body){

  // todos: 역별로 파일 분리

  // todos: 주석 잘 달아서 정리하기.

  List<String> yaku = [];

  tanyao_check(body, yaku);
  yakuHai_check(hand_map, yaku);
  Sanshoku_check(hand_map, yaku);
  ittsu_check(hand_map, yaku);
  sanankou_check(hand_map, yaku);
  sankanz_check(hand_map, yaku);
  honroutou_check(body, yaku);
  if (!yaku.contains('혼노두')) chanta_check(hand_map, yaku);
  shousangen_check(hand_map, yaku);
  honitsu_check(hand_map, yaku);
  
  

  if (hand_map['멘젠']){
    menzentsumo_check(hand_map, yaku);
    pingfu_check(hand_map, yaku);
    ipeko_check(hand_map, yaku);
    
  }else{
    toitoi_check(hand_map, yaku);
  }
  
  if (yaku.length >= 1){
    prob ++;
    if (yaku.length > longest.length) {
      longest = yaku;
      longHand = hand_map;
      }
    
  }else{

  }

}