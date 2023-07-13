class KategoriPAL {
  static const tidakPernah =
      PALModels(1.2, 'Never Exercise', 'More sitting and sleeping in a week');
  static const jarang =
      PALModels(1.375, 'Rarely Exercise', '1 - 3 days a week');
  static const normal =
      PALModels(1.55, 'Regular Exercise', '3 - 5 days a week');
  static const sering =
      PALModels(1.725, 'Frequently Exercise', '6 - 7 days a week');
  static const sangatSering =
      PALModels(1.9, 'Exercise Very Frequently', '1 - 2 times a day');
}

class PALModels {
  final double nilai;
  final String kategori;
  final String harian;
  const PALModels(this.nilai, this.kategori, this.harian);
}
