class yakuCategorizer{

  Map<String, List<int>> hand_map;

  late bool menzen;

  yakuCategorizer(this.hand_map);

  init(){
    var huro = hand_map['후로']!;
    if (huro[0] == 0 && huro[1] == 0 && huro[2] == 0 && huro[3] == 0){
      menzen = true;
      print('리치');
    }else{
      menzen = false;
      print('역없음');
    }
  }
}