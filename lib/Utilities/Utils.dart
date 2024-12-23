import 'dart:math';

import 'package:mjg/Enums/MentsuType.dart';
import 'package:mjg/probabilityManager.dart';

class Utils {
  final Random random = Random();
  final ProbabilityManager PM = ProbabilityManager();
  int count = 0;

  Utils._utils(); // Private constructor

  static final Utils _instance = Utils._utils();

  factory Utils() {
    return _instance;
  }

  // 메서드: 리스트에서 랜덤한 요소를 반환
  T pickRandomElement<T>(List<T> items) {
    if (items.isEmpty) {
      throw ArgumentError("The list cannot be empty.");
    }
    int randomIndex = random.nextInt(items.length);
    return items[randomIndex];
  }

  MentsuType pickRandomMachi() {
    double prob = random.nextDouble();
    if (prob < PM.tankiProb) {
      return MentsuType.Head;
    } else if (prob < PM.tankiProb + PM.shanponProb) {
      return MentsuType.Koutsu;
    } else {
      return MentsuType.Shuntsu;
    }
  }

  MentsuType pickRandomMentsu() {
    double prob = random.nextDouble();
    if (prob < PM.shuntsuProb) {
      return MentsuType.Shuntsu;
    } else if (prob < PM.shuntsuProb + PM.koutsuProb) {
      return MentsuType.Koutsu;
    } else {
      return MentsuType.Kantsu;
    }
  }

  bool pickRandomHuro() {
    if (random.nextDouble() < PM.huroProb) {
      return true;
    } else {
      return false;
    }
  }
}
