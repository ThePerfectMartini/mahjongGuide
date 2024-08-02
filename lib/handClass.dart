import 'dart:math';

import 'package:flutter_mahjong_yakuguide/buCalculator.dart';
import 'package:flutter_mahjong_yakuguide/tiles.dart';

Random random = Random();

class handInfo {
  List<int> body = [];
  List<int> huro = [];
  List<int> dora = [];

  List<int> firstNumberIndex = [];

  List<String> yaku = [];
  
  int agariTile = 0;
  String machiType = '';
  bool agariType = true; // true일때 쯔모 

  int bu = 0;

  int kanCount = 0;
  int globalWind = 0;
  int playerWind = 0;

  int shunProb = 80;
  int cuzProb = 15;

  // 생성자
  handInfo(){
    globalWind = random.nextInt(4)+1;
    playerWind = random.nextInt(4)+1;
    agariType = random.nextBool();
    tiles_standard();
    // tiles_tangyao();
    doraSet();
    tilesSet();
    firstNumberIndexSet();
    agariTileSet();
    bu = buCalculator(this);

  }

  doraSet() {
    for (int i = 0; i < 8; i++){
      this.dora.add(tilesSelectRandomTile(0));
    }
  }

  tilesSet(){
    for (int i = 0; i < 4; i++){
      bool h = false;
      int r = random.nextInt(100);
      if (random.nextInt(100) < 20){
        h = true;
      }
      if (r < shunProb){
        int selected = tilesSelectRandomTileShunz();
        body.addAll([selected,selected+1,selected+2]);
        if (h){
          huro.add(1);
        }else{
          huro.add(0);
        }
      }else if (r < shunProb + cuzProb){
        int selected = tilesSelectRandomTile(2);
        body.addAll([selected,selected,selected]);
        if (h){
          huro.add(3);
        }else{
          huro.add(2);
        }
      }else {
        int selected = tilesSelectRandomTile(3);
        kanCount ++;
        body.addAll([selected,selected,selected,selected]);
        if (h){
          huro.add(5);
        }else{
          huro.add(4);
        }
      }
    }
    int head = tilesSelectRandomTile(1);
    body.addAll([head,head]);
  }

  agariTileSet(){
    Map<int,String> tileMachiType = {};
    int index = 0;
    for (int i in huro){
      switch (i){
        case 0:
          if (body[index] % 10 == 1){
            tileMachiType[index] = '양면';
            tileMachiType[index+1] = '간짱';
            tileMachiType[index+2] = '변짱';
          }else if(body[index+2] % 10 == 9){
            tileMachiType[index] = '변짱';
            tileMachiType[index+1] = '간짱';
            tileMachiType[index+2] = '양면';
          }else{
            tileMachiType[index] = '양면';
            tileMachiType[index+1] = '간짱';
            tileMachiType[index+2] = '양면';
          }
        case 2:
          tileMachiType[index] = '샤보';
          tileMachiType[index+1] = '샤보';
          tileMachiType[index+2] = '샤보';
        default:
          if (i >= 4){
            index ++;
          }
      }
      index += 3;
    }
    tileMachiType[index] = '머리단기';
    tileMachiType[index+1] = '머리단기';

    int selectedTileIndex = tileMachiType.keys.toList()[random.nextInt(tileMachiType.keys.length)];

    agariTile = body[selectedTileIndex];
    machiType = tileMachiType[selectedTileIndex]!;
    
  }

  firstNumberIndexSet(){
    int index = 0;

    for (int i in huro){
      firstNumberIndex.add(index);
      index += 3;
      if (i >= 4){
        index ++;
      }
    }
  }


  // 멘젠
  getMenzenState(){
    if (huro.any((int n) => n == 1 || n == 3 || n == 5)){
      return false;
    }else{
      return true;
    }
  }

  // 숫자 관련 get
  getFirstNumbers(){
    List<int> result = [];
    for (int i in firstNumberIndex){
      result.add(body[i]);
    }

    return result;
  }
  
  // 슌츠 get
  getShunNumbers(){
    List<int> result = [];
    for (int i = 0; i < 4; i++){
      if (huro[i] < 2){
        result.add(body[firstNumberIndex[i]]);
      }
    }
    return result;
  }

  
  // 머리 숫자 get
  getHeadNumber(){
    return body.last;
  }


  // 도라관련 get
  getDora(){}
  getDoraAll(){}




  // 테스트용 
  testPrint(){
    print(
      """

      body : $body
      numbers : ${getFirstNumbers()}
      huro : $huro
      dora : $dora 

      agariTile : $agariTile
      쯔모 : $agariType
      machiType : $machiType
      kanCount : $kanCount
      gwind : $globalWind
      pwind : $playerWind
      부수 : $bu

      역 : $yaku
      """
    );
  }

}