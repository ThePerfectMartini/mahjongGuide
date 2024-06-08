
class TileRemains{
  List<int> tiles = [];

  TileRemains(){
    List<int> basicNumberList = List.generate(37, (index) => index+11);
    basicNumberList.remove(20);
    basicNumberList.remove(30);
    basicNumberList.remove(40);
    tiles.addAll(basicNumberList);
    tiles.addAll(basicNumberList);
    tiles.addAll(basicNumberList);
    tiles.addAll(basicNumberList);
    tiles.sort();
  }
  
  getTiles(){
    return tiles;
  }
  
}