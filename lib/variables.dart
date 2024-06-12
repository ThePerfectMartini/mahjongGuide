// import 'dart:math';
// import 'package:flutter_mahjong_yakuguide/tileRemains.dart';

// Random random = Random();

// var numbers = [];
// var shun = [];
// var cuz = [];
// var kanz = [];
// var naki = [];
// var hand = [];

// generate() {
//   int cuzCount = random.nextInt(5);
//   TileRemains tileRemains = TileRemains();
//   List<int> shunRange = tileRemains.tiles_1to7;

//   // 슌츠 추가
//   for (int i = 0; i < 4 - cuzCount; i++) {
//     int selected = shunRange[random.nextInt(shunRange.length)];

//     tileRemains.removeShun(selected);
//     numbers.add(selected);

//     hand.add(selected);
//     hand.add(selected + 1);
//     hand.add(selected + 2);
//   }

//   for (int i = 0; i < cuzCount; i++) {
//     int type = 3; // 3이면 커쯔 4면 깡쯔
//     List<int> cuzRange = [];
//     // 선택할수있는 범위 뽑아내기 (커쯔니까 3개이상 남아있는것들만)

//     for (int number in tileRemains.toSet()) {
//       int count = tileRemains.where((x) => x == number).length;

//       if (count >= type) {
//         cuzRange.add(number);
//       }
//     }

//     ///
//     /// 에러 발생 : allTiles(TileRemail클래스)가 계속 패 전체 배열을 반환하는게 아닌 수정이 된 채로 남아있음
//     ///
//     ///
//     int selected = cuzRange[random.nextInt(cuzRange.length)];

//     for (int i = 0; i < type; i++) {
//       body.add(selected);
//       tileRemains.remove(selected);
//     }

//     selectedNumber.add(selected);
//   }

//   for (int number in tileRemains.toSet()) {
//     int count = tileRemains.where((x) => x == number).length;
//     if (count >= 2) {
//       headRange.add(number);
//     }
//   }

//   // 머리 선택
//   int head = headRange[random.nextInt(headRange.length)];
//   selectedNumber.add(head);
//   body.add(head);
//   body.add(head);

//   body.sort();
// }
