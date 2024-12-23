import 'package:mjg/Utilities/Utils.dart';

class NumberSelector {
  final Map<int, int> _numberMap;

  NumberSelector()
      : _numberMap = {
          // 초기화: 특정 숫자를 제외한 11부터 47까지 숫자를 키로 사용하며 초기 값은 모두 4로 설정
          for (int i = 11; i <= 47; i++)
            if (i != 20 && i != 30 && i != 40) i: 4
        };

  // 숫자 하나를 선택하여 count만큼 차감하는 메서드
  int pickRandomNumber(int count) {
    // 조건을 만족하는 숫자만 필터링하여 사용 가능한 숫자 리스트 생성
    final availableNumbers =
        _numberMap.keys.where((key) => _numberMap[key]! >= count).toList();

    if (availableNumbers.isEmpty) {
      // 필터링된 숫자가 없으면 예외 발생
      throw StateError(
          'NumberSelector 오류: 차감 가능한 숫자가 없습니다. (범위 내에서 count가 충분하지 않습니다)');
    }

    // ProbabilityManager를 사용하여 랜덤한 키를 선택
    final int randomKey = Utils().pickRandomElement(availableNumbers);

    // 선택된 숫자의 값을 count만큼 차감
    _numberMap[randomKey] = _numberMap[randomKey]! - count;
    return randomKey; // 선택된 숫자 반환
  }

  // 선택된 숫자와 그 다음 두 숫자의 값을 하나씩 차감하는 메서드
  int pickRandomNumberSequence() {
    // 조건: 숫자는 40 미만, 일의 자리가 8, 9가 아니며 +1, +2 범위의 값이 충분해야 함
    final availableNumbers = _numberMap.keys.where((key) {
      final hasValidNextKeys = _numberMap.containsKey(key + 1) &&
          _numberMap.containsKey(key + 2) &&
          _numberMap[key + 1]! >= 1 &&
          _numberMap[key + 2]! >= 1; // +1, +2의 값이 충분한지 확인

      return _numberMap[key]! >= 1 &&
          key < 40 && // 40 미만 숫자
          key % 10 < 8 && // 일의 자리가 7 미만일 때
          hasValidNextKeys; // +1, +2 키 조건 충족 여부
    }).toList();

    if (availableNumbers.isEmpty) {
      // 필터링된 숫자가 없으면 예외 발생
      throw StateError(
          'NumberSelector 오류: 차감 가능한 숫자가 없습니다. (40 미만, 일의 자리가 8 또는 9가 아닌 숫자에서 +1, +2 범위 확인)');
    }

    // ProbabilityManager를 사용하여 랜덤한 키를 선택
    final int randomKey = Utils().pickRandomElement(availableNumbers);

    // 선택된 숫자 및 범위 내 숫자의 값을 하나씩 차감
    _numberMap[randomKey] = _numberMap[randomKey]! - 1;
    _numberMap[randomKey + 1] = _numberMap[randomKey + 1]! - 1;
    _numberMap[randomKey + 2] = _numberMap[randomKey + 2]! - 1;

    return randomKey; // 선택된 숫자 반환
  }
}
