  // import 'dart:math';
  // import 'tileRemains.dart';

  // class HandGenerator {
  //   Random random = Random();
  //   TileRemains allTiles = TileRemains();

  //   late int shunCount;
  //   late int cuzCount;

  //   late List<int> tileRemains;

  //   late List<int> selectedNumber;
  //   late List<int> headRange;
  //   late List<int> body;

  //   // 밖으로 내보낼 것

  //   __init__() {
  //     // 초기화
  //     shunCount = random.nextInt(5);
  //     cuzCount = 4 - shunCount;
  //     tileRemains = List.from(allTiles.getTiles());

  //     selectedNumber = [];
  //     headRange = [];
  //     body = [];
  //   }

  //   generate() {
  //     __init__();

  //     // 슌츠 추가
  //     for (int i = 0; i < shunCount; i++) {
  //       List<int> shunRange = tileRemains
  //           .where((element) => element < 40 && ((element % 10) < 8))
  //           .toList();
  //       int selected = shunRange[random.nextInt(shunRange.length)];

  //       tileRemains.remove(selected);
  //       tileRemains.remove(selected + 1);
  //       tileRemains.remove(selected + 2);
  //       selectedNumber.add(selected);
  //       body.add(selected);
  //       body.add(selected + 1);
  //       body.add(selected + 2);
  //     }

  //     for (int i = 0; i < cuzCount; i++) {
  //       int type = 3; // 3이면 커쯔 4면 깡쯔
  //       List<int> cuzRange = [];
  //       // 선택할수있는 범위 뽑아내기 (커쯔니까 3개이상 남아있는것들만)
  //       for (int number in tileRemains.toSet()) {
  //         int count = tileRemains.where((x) => x == number).length;

  //         if (count >= type) {
  //           cuzRange.add(number);
  //         }
  //       }

  //       ///
  //       /// 에러 발생 : allTiles(TileRemail클래스)가 계속 패 전체 배열을 반환하는게 아닌 수정이 된 채로 남아있음
  //       ///
  //       ///
  //       int selected = cuzRange[random.nextInt(cuzRange.length)];

  //       for (int i = 0; i < type; i++) {
  //         body.add(selected);
  //         tileRemains.remove(selected);
  //       }

  //       selectedNumber.add(selected);
  //     }

  //     for (int number in tileRemains.toSet()) {
  //       int count = tileRemains.where((x) => x == number).length;
  //       if (count >= 2) {
  //         headRange.add(number);
  //       }
  //     }

  //     // 머리 선택
  //     int head = headRange[random.nextInt(headRange.length)];
  //     selectedNumber.add(head);
  //     body.add(head);
  //     body.add(head);

  //     body.sort();

  //     print('''\n
  //       -------------------
  //       패 전체 : $body
  //       슌츠개수 : $shunCount 
  //       슌츠 배열 : ${selectedNumber.sublist(0, shunCount)}
  //       커츠개수 : $cuzCount
  //       커츠 배열 : ${selectedNumber.sublist(shunCount, shunCount + cuzCount)}
  //       머리 : ${selectedNumber.last}
  //       -------------------
  //     ''');
  //   }
  // }
