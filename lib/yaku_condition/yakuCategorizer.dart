import 'package:flutter_mahjong_yakuguide/handClass.dart';
import 'package:flutter_mahjong_yakuguide/tiles.dart';
import 'package:flutter_mahjong_yakuguide/yaku_condition/yaku_check.dart';

// yakuCategorizer(Map hand_map, List<int> body) {
//   // todos: 역별로 파일 분리

//   // todos: 주석 잘 달아서 정리하기.

//   List<String> yaku = [];

//   // dora_check(body, hand_map['도라표시패'], false, yaku);

//   tanyao_check(body, yaku);
//   yakuHai_check(hand_map, yaku);
//   Sanshoku_check(hand_map, yaku);
//   ittsu_check(hand_map, yaku);
//   sanankou_check(hand_map, yaku);
//   sankanz_check(hand_map, yaku);
//   honroutou_check(body, yaku);
//   if (!yaku.contains('혼노두')) chanta_check(hand_map, yaku);
//   shousangen_check(hand_map, yaku);
//   honitsu_check(body, yaku);

//   if (hand_map['멘젠']) {
//     riichi(body, hand_map, yaku);
//     menzentsumo_check(hand_map, yaku);
//     pingfu_check(hand_map, yaku);
//     ipeko_check(hand_map, yaku);
//   } else {
//     toitoi_check(hand_map, yaku);
//   }


//   if (yaku.length > 0) {
//     print(yaku);
//     print(hand_map);
//     print(tiles_map);

//   } else {}
// }


categorizer(handInfo hand) {
  // todos: 역별로 파일 분리

  // todos: 주석 잘 달아서 정리하기.

  yakuHai_check(hand);
  tanyao_check(hand);
  chanta_check(hand);
  ittsu_check(hand);
  sanankou_check(hand);
  sankanz_check(hand);
  honitsu_check(hand);
  shousangen_check(hand);
  sanshoku_check(hand);

  
  if (hand.getMenzenState()) {
    riichi(hand);
    pingfu_check(hand);
    menzentsumo_check(hand);
    ipeko_check(hand);
  } else {
    toitoi_check(hand);
  }
  if (hand.yaku.isNotEmpty) dora_check(hand);
  
}