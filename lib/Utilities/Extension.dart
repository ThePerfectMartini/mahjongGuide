extension ListUtils<T> on List<T> {
  int count(T value) {
    return this.where((item) => item == value).length;
  }
}
