import 'package:flutter_mahjong_yakuguide/Enums/MachiType.dart';
import 'package:flutter_mahjong_yakuguide/Enums/MentsuType.dart';
import 'package:flutter_mahjong_yakuguide/Enums/TileType.dart';
import 'package:flutter_mahjong_yakuguide/HandInfo.dart';
import 'package:flutter_mahjong_yakuguide/Mentsu.dart';

class YakuStatus {
  List<String> yaku = [];

  int simpleCount = 0;
  int honorCount = 0;
  int terminalCount = 0;
  int shuntsuCount = 0;
  int koutsuCount = 0;
  int kantsuCount = 0;

  int ankouCount = 0;
  int sameNumberCount = 0;
  List<int> numbers = [];
  Set<int> ipekoSet = {};

  YakuStatus(HandInfo info){
    _analyzeConditions(info);

    if (info.isMenzen){
      _shuntsuRelated(info);
    }
    
    _koutsuRelated(info);
    _tileTypeRelated();
  }

  void _analyzeConditions(HandInfo info) {
    List<Mentsu> allHand = [info.machi] + info.hand;
    numbers = allHand.where((e) => e.type != MentsuType.Head).map((e) => e.number).toList();
    (allHand).forEach((i){
      switch (i.tileType){
        case TileType.Simple:
          simpleCount++;
        case TileType.Terminal:
          terminalCount++;
        case TileType.Honor:
          honorCount++;
      }
      switch (i.type){
        case MentsuType.Shuntsu:
          shuntsuCount++;
          ipekoSet.add(i.number);
        case MentsuType.Koutsu:
          koutsuCount++;
          if (!i.isCalled){
            ankouCount++;
          }
        case MentsuType.Kantsu:
          koutsuCount++;
          kantsuCount++;
          if (!i.isCalled){
            ankouCount++;
          }
        case MentsuType.Head:
          // 처리없음 : 맨 밑으로 가야함
      }
    });
  }

  void _shuntsuRelated(HandInfo info) {
    if ((info.isTsumo && info.fu == 20) || (!info.isTsumo && info.fu == 30)) {
      yaku.add('핑후');
    }

    switch(shuntsuCount - ipekoSet.length){
      case 1:
        yaku.add('이페코');
      case 2:
        if (numbers.where((e) => e == ipekoSet.first).length == 2){
          yaku.add('량페코');  
        }else{
          yaku.add('이페코'); // 3개 1개 이페코 특수케이스
        }
      default:
    }
  }

  void _tileTypeRelated(){
    if (simpleCount == 0){
      if (shuntsuCount == 0){
        if (terminalCount == 5){
          yaku.add('청노두');
        }else{
          yaku.add('혼노두');
        }
      }else{
        if (honorCount == 0){
          yaku.add('준찬타');
        }else{
          yaku.add('찬타');
        }
      }
    }else if (simpleCount == 5){
      yaku.add('탕야오');
    }
  }
  
  void _koutsuRelated(HandInfo info){
    if(ankouCount == 4){
      yaku.add('쓰안커');
    }else if (ankouCount == 3){
      yaku.add('산안커');
    }
    if (koutsuCount == 4){
      yaku.add('또이또이');
    }
    if (kantsuCount == 4){
      yaku.add('쓰깡쯔');
    }else if (kantsuCount == 3){
      yaku.add('산깡쯔');
    }
  }
}
