import 'dart:math';

class handGenerator {
  Random random = Random();
  late bool menzen;
  late List<int> huro;

  late Map<int, int> tiles_map;

  late List<int> tiles_shunz;

  late Map<String, List<int>> result_map;

  int s = 0;
  int c = 0;
  int k = 0;

  init() {
    s = 0;
    c = 0;
    k = 0;
    typeShuffle();


    result_map = {};
    tiles_map = {
      for (int i = 11; i <= 47; i++)
        if (i != 20 && i != 30 && i != 40) i: 4
    };
    tiles_shunz = [
      for (int i = 1; i <= 3; i++)
        for (int j = 1; j <= 7; j++)
          for (int k = 0; k < 4; k++)
            i * 10 + j
    ];


    menzen = random.nextBool();
    huro = [];
    if (menzen) {huro = [0,0,0,0];} else {setHuro();}

    result_map['슌츠'] = randomTiles(s, 1);
    result_map['커츠'] = randomTiles(c, 3);
    result_map['깡츠'] = randomTiles(k, 4);
    result_map['머리'] = randomTiles(1, 2);
    result_map['후로'] = huro;
  }

  setHuro(){
    huro.add(random.nextInt(2));
    huro.add(random.nextInt(2));
    huro.add(random.nextInt(2));
    huro.add(random.nextInt(2));
    if (huro[0] == 0 && huro[1] == 0 && huro[2] == 0 && huro[3] == 0){
      menzen = true;
      }
  }

  randomTiles(int count, int type) {
    List<int> result = [];
    for (int i = 0; i < count; i++){
      switch (type){
        case 1:
          int randomInt = random.nextInt(tiles_shunz.length);
          int selected = tiles_shunz[randomInt];
          tiles_shunz.remove(selected);
          tiles_shunz.remove(selected+1);
          tiles_shunz.remove(selected+2);
          tiles_map[selected] = tiles_map[selected]! - 1;
          tiles_map[selected + 1] = tiles_map[selected + 1]! - 1;
          tiles_map[selected + 2] = tiles_map[selected + 2]! - 1;
          result.add(selected);
        default:
          List<int> tiles = [];

          tiles_map.forEach((key, value) {
            if (value >= type) tiles.add(key);
          });
          int selected = tiles[random.nextInt(tiles.length)];
          result.add(selected);
          tiles_map[selected] = tiles_map[selected]! - type;
      }
    }

    return result;
  }


  typeShuffle() {
    for (int i = 0 ; i < 4; i++){
      bool first_con = (random.nextInt(100)<80);
      bool second_con = (random.nextInt(100)<10);
      if (first_con){ // 80% 확률로 슌츠
        s++;
      }else if(second_con){ // 10% 확률로 깡쯔
        k++;
      }else{
        c++;
      }
    }
  }
}
