enum MachiType {
  Tanki,
  Shanpon,
  Kanchan,
  RyanmenFront,
  RyanmenBack,
  PenchanFront,
  PenchanBack;

  int getMachiIndex() {
    if (this == MachiType.Kanchan) {
      return 1;
    } else if (this.name.contains('Back')) {
      return 2;
    } else {
      return 0;
    }
  }
}
