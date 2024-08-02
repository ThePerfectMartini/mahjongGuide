
// 변수

import 'dart:math';

import 'package:flutter_mahjong_yakuguide/handClass.dart';

Map <int, int> tiles_map = {};

List<int> forbidden = [];

Random random = Random();

// 함수 부
tiles_standard(){
  tiles_map = {
      for (int i = 11; i <= 47; i++)
        if (i != 20 && i != 30 && i != 40) 
          if (forbidden.contains(i)) i:0
          else i:4
  };
}

tiles_tangyao(){
  forbidden = [11,19,21,29,31,39,41,42,43,44,45,46,47];
  tiles_map = {
      for (int i = 11; i <= 47; i++)
        if (i != 20 && i != 30 && i != 40) 
          if (forbidden.contains(i)) i:0
          else i:4
  };
}

tilesSelectRandomTileShunz(){
  List<int> range = tilesGetfilteredMapForShunz();
  int selected = range[random.nextInt(range.length)];
  tilesRemoveShunz(selected);
  return selected;
}

tilesSelectRandomTile(int n){
  List<int> range = tilesGetfilteredMap(n);
  int selected = range[random.nextInt(range.length)];
  // 0이면 하나 1이면 머리 2면 커쯔 3이면 깡쯔
  switch (n){
    case 0:
      tilesRemove(selected);
    case 1:
      tilesRemoveHead(selected);
    case 2:
      tilesRemoveCuz(selected);
    case 3:
      tilesRemoveKanz(selected);
  }
  return selected;
}

tilesGetfilteredMap(int n){
  List<int> filteredMap = [
    for (var entry in tiles_map.entries)
      if (entry.value > n) entry.key
  ];

  return filteredMap;
}

tilesGetfilteredMapForShunz(){
  List<int> filteredMap = tiles_map.keys.toList();
  filteredMap.retainWhere((number) => (number < 40)&&(number % 10 <= 7));
  tiles_map.forEach((key,value) {
    if (value == 0){
      filteredMap.remove(key-2);
      filteredMap.remove(key-1);
      filteredMap.remove(key);
    }
  });

  return filteredMap;
}

tilesRemove(int n){
  tiles_map[n] = tiles_map[n]! - 1;
}
tilesRemoveHead(int n){
  tiles_map[n] = tiles_map[n]! - 2;
}
tilesRemoveShunz(int n){
  tiles_map[n] = tiles_map[n]! - 1;
  tiles_map[n+1] = tiles_map[n+1]! - 1;
  tiles_map[n+2] = tiles_map[n+2]! - 1;
}
tilesRemoveCuz(int n){
  tiles_map[n] = tiles_map[n]! - 3;
}
tilesRemoveKanz(int n){
  tiles_map[n] = tiles_map[n]! - 4;
}

