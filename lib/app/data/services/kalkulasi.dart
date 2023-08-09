import 'dart:math';

import 'package:intl/intl.dart';
import 'package:nobes/app/data/model/usda_search.dart';
import 'package:nobes/app/data/services/kategori_imt.dart';
import 'package:nobes/app/data/services/kategori_pal.dart';
import 'package:nobes/app/data/services/public.dart';

class Kalkulator {
  //indeks massa tubuh (BMI)
  static double imt({required double weight, required double height}) =>
      double.parse(
          (weight / ((height / 100) * (height / 100))).toStringAsFixed(2));

  static String kategoriIMT({bool? isMan, double? imt}) {
    String kategori = '';
    bool nilaiisMan =
        isMan ?? Publics.controller.getProfile.value.isMan ?? false;
    double nilaiIMT = double.parse(imt != null
        ? imt.toString()
        : Publics.controller.getProfile.value.imt ?? '0.0');
    if (nilaiisMan == true) {
      if (nilaiIMT < 18.0) {
        kategori = KategoriIMT.kurus;
      } else if (nilaiIMT <= 25.0) {
        kategori = KategoriIMT.normal;
      } else if (nilaiIMT <= 27.0) {
        kategori = KategoriIMT.kegemukkan;
      } else {
        kategori = KategoriIMT.obesitas;
      }
    } else {
      if (nilaiIMT < 17.0) {
        kategori = KategoriIMT.kurus;
      } else if (nilaiIMT <= 23.0) {
        kategori = KategoriIMT.normal;
      } else if (nilaiIMT <= 27.0) {
        kategori = KategoriIMT.kegemukkan;
      } else {
        kategori = KategoriIMT.obesitas;
      }
    }
    return kategori;
  }

  static String kategoriPAL({bool? pal}) {
    String kategori = '';
    double nilaiPAL =
        double.parse(Publics.controller.getProfile.value.pal ?? '1.2');
    if (nilaiPAL == 1.2) {
      kategori = KategoriPAL.tidakPernah.kategori;
    } else if (nilaiPAL == 1.375) {
      kategori = KategoriPAL.jarang.kategori;
    } else if (nilaiPAL == 1.55) {
      kategori = KategoriPAL.normal.kategori;
    } else if (nilaiPAL == 1.725) {
      kategori = KategoriPAL.sering.kategori;
    } else if (nilaiPAL == 1.9) {
      kategori = KategoriPAL.sangatSering.kategori;
    }
    return kategori;
  }

  static double nilaiKiloPembakaran({String? kategoriIMT}) {
    String kategori = kategoriIMT ?? Kalkulator.kategoriIMT();
    double kiloPembakaran = 0.0;
    if (kategori == KategoriIMT.kurus) {
      kiloPembakaran = -1.0;
    } else if (kategori == KategoriIMT.normal) {
      kiloPembakaran = 0.0;
    } else if (kategori == KategoriIMT.kegemukkan) {
      kiloPembakaran = 1.0;
    } else {
      kiloPembakaran = 2.0;
    }
    return kiloPembakaran;
  }

  //mis : kilo = 0.5 maka (7700 x 0.5) / 7 = 3850 / 7 = 550
  static double kaloriPembakaran({required double kilo}) => (7700 * kilo) / 28;

  //mis : kalori = 550 maka (550 x 7) / 7700 = 3850 / 7700 = 0.5
  static double kiloPembakaran({required double kalori}) =>
      (kalori * 28) / 7700;

  static final timeNow = DateFormat.yMd().format(DateTime.now());

  //basal metabolisme rate (AMB)
  static double bmr(
          {required bool isMan,
          required double weight,
          required double height,
          required double age}) =>
      isMan == true
          ? 655.1 + (9.563 * weight) + (1.850 * height) + (4.676 * age)
          : 66.5 + (13.75 * weight) + (5.003 * height) + (6.775 * age);

  // umur
  static int umur(String dateString) {
    final today = DateTime.now();
    final birthDate = DateTime.parse(dateString);

    int age = today.year - birthDate.year;
    int monthDiff = today.month - birthDate.month;

    if (monthDiff < 0 || (monthDiff == 0 && today.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  //porsi makanan
  static double porsi({required double size, required double value}) =>
      (size / 100) * value;

  //kebutuhan kalori total
  // static double kkt({required double bmr, double? pal}) =>
  //     pal != null ? bmr * pal : bmr * 1.2;

  //generate KnapSack
  static List<Foods> generateKnapSack({required List<Foods> foods}) {
    foods.shuffle();
    List<int> kaloris = [];
    foods.map(
      (e) {
        int kalori = e.servingSize != null && e.servingSizeUnit != null
            ? Kalkulator.porsi(
                    size: e.servingSize ?? 100,
                    value: e.foodNutrients!
                            .firstWhere(
                              (data) => data.nutrientId == 1008,
                              orElse: () => FoodNutrients(value: 0),
                            )
                            .value ??
                        0)
                .toInt()
            : (e.foodNutrients!
                        .firstWhere(
                          (data) => data.nutrientId == 1008,
                          orElse: () => FoodNutrients(value: 0),
                        )
                        .value ??
                    0)
                .toInt();
        kaloris.add(kalori);
      },
    ).toList();
    final getprofile = Publics.controller.getProfile.value;
    int totalKKT = (double.parse(getprofile.bmr ?? '0') -
            double.parse(getprofile.kaloriPembakaran ?? '0'))
        .round();
    int jumlahMakanan = kaloris.length;
    List<int> panjangTerpilih = List.filled(jumlahMakanan, 0);
    List<List<int>> tabelMaksimal =
        List.generate(jumlahMakanan + 1, (_) => List.filled(totalKKT + 1, 0));

    // Mengisi tabel dengan nilai maksimal
    for (int i = 1; i <= jumlahMakanan; i++) {
      for (int j = 1; j <= totalKKT; j++) {
        if (kaloris[i - 1] <= j) {
          tabelMaksimal[i][j] = max(tabelMaksimal[i - 1][j],
              kaloris[i - 1] + tabelMaksimal[i - 1][j - kaloris[i - 1]]);
        } else {
          tabelMaksimal[i][j] = tabelMaksimal[i - 1][j];
        }
      }
    }

    // Mencari kayu yang terpilih
    int i = jumlahMakanan;
    int j = totalKKT;
    while (i > 0 && j > 0) {
      if (tabelMaksimal[i][j] != tabelMaksimal[i - 1][j]) {
        panjangTerpilih[i - 1] = 1;
        j -= kaloris[i - 1];
      }
      i--;
    }

    // Menampilkan kayu yang terpilih
    List<Foods> foodsGenerate = [];
    for (int i = 0; i < jumlahMakanan; i++) {
      if (panjangTerpilih[i] == 1) {
        foodsGenerate.add(foods[i]);
      }
    }
    return foodsGenerate;
  }

  static double get kkt {
    double kalori =
        double.parse(Publics.controller.getProfile.value.kaloriPembakaran!);
    double kkt = double.parse(Publics.controller.getProfile.value.bmr!);
    double value = kkt - kalori;
    return value;
  }

  static String generateMonteCarlo(
      {required double kkt,
      required int banyakMenu,
      required List<Foods> daftarMenu}) {
    // jumlah sampel yang akan diambil
    int numSamples = 100000;
    // inisialisasi variabel hasil
    List<String> resultMenuList = [];
    int resultTotalCalorie = 0;
    int resultDiff = 0;
    List<int> calorieList = daftarMenu
        .map((e) => (e.foodNutrients!
                    .firstWhere((data) => data.nutrientId == 1008)
                    .value ??
                0.0)
            .toInt())
        .toList();
    // loop untuk mengambil sampel kombinasi menu secara acak
    for (int i = 0; i < numSamples; i++) {
      // mengambil banyak menu secara acak
      List<int> sampleIndices =
          List.generate(banyakMenu, (i) => Random().nextInt(daftarMenu.length));
      // menghitung jumlah kalori dari daftar menu tersebut
      int sampleTotalCalorie = 0;
      for (int j = 0; j < sampleIndices.length; j++) {
        sampleTotalCalorie += calorieList[sampleIndices[j]];
      }
      // memeriksa apakah jumlah kalori lebih mendekati 100 daripada hasil sebelumnya
      int sampleDiff = (sampleTotalCalorie - kkt.toInt()).abs();
      if (resultTotalCalorie == 0 ||
          sampleDiff < resultDiff ||
          sampleIndices.contains(calorieList)) {
        resultMenuList = sampleIndices
            .map((index) =>
                '${daftarMenu[index].description} (${calorieList[index]})')
            .toList();
        resultTotalCalorie = sampleTotalCalorie;
        resultDiff = sampleDiff;
      }
    }
    // menampilkan hasil
    String resultMenuString = resultMenuList.join(', ');
    int resultCalorieDiff = resultTotalCalorie - kkt.toInt();
    String resultDiffString =
        resultCalorieDiff > 0 ? '+$resultCalorieDiff' : '$resultCalorieDiff';
    return 'Kombinasi menu yang mendekati: $resultMenuString \n(total kalori: $resultTotalCalorie, selisih: $resultDiffString)';
  }
}
