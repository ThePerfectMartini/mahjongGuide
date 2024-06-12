import 'dart:math';

class TileRemains {
  Random random = Random();

  late Map<int, int> tiles_map = {
    for (int i = 11; i <= 47; i++)
      if (i != 20 && i != 30 && i != 40) i: 4
  };

  init() {
    tiles_map = {
      for (int i = 11; i <= 47; i++)
        if (i != 20 && i != 30 && i != 40) i: 4
    };
  }

  randomShunz(int count) {
    List<int> range = [];
    List<int> tiles = [];
    List<int> result = [];

    range.addAll(List.generate(7, (int index) => index + 11));
    range.addAll(List.generate(7, (int index) => index + 21));
    range.addAll(List.generate(7, (int index) => index + 31));
    tiles.addAll(range);
    tiles.addAll(range);
    tiles.addAll(range);
    tiles.sort();

    for (int i = 0; i < count; i++) {
      int x = random.nextInt(3) + 1;
      int y = random.nextInt(7) + 1;
      int xy = x * 10 + y;
      result.add(xy);
      tiles_map[xy] = tiles_map[xy]! - 1;
      tiles_map[xy + 1] = tiles_map[xy + 1]! - 1;
      tiles_map[xy + 2] = tiles_map[xy + 2]! - 1;
    }

    return result;
  }

  randomCuz(int count, int n) {
    List<int> tiles = [];
    List<int> result = [];

    tiles_map.forEach((key, value) {
      if (value >= n) tiles.add(key);
    });
    for (int i = 0; i < count; i++) {
      int selected = tiles[random.nextInt(tiles.length)];
      result.add(selected);
      tiles.remove(selected);
      tiles_map[selected] = tiles_map[selected]! - n;
    }

    return result;
  }

  show() {
    print(tiles_map);
  }
}
