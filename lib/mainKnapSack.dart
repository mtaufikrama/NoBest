import 'dart:io';
import 'dart:math';
import 'package:nobes/app/data/model/usda_search.dart';
import 'package:nobes/app/data/services/fetch_data.dart';

void main() async {
  stdout.write('Berat badan (kg): ');
  double weight = double.parse(stdin.readLineSync()!);

  stdout.write('Tinggi badan (cm): ');
  double height = double.parse(stdin.readLineSync()!);

  stdout.write('Usia (tahun): ');
  int age = int.parse(stdin.readLineSync()!);

  stdout.write('Jenis kelamin (P/L): ');
  String gender = stdin.readLineSync()!;

  stdout.write('Nama Menu: ');
  String menuName = stdin.readLineSync()!;

  USDASearch getSearch = await API.getSearch(query: menuName);
  print(getSearch.currentPage);
  double bmr = 0.0;

  // Menghitung BMR
  if (gender == 'P') {
    bmr = 655 + (9.6 * weight) + (1.8 * height) - (4.7 * age);
  } else {
    bmr = 66 + (13.7 * weight) + (5 * height) - (6.8 * age);
  }

  print('BMR = $bmr');
  List<Foods> foods = getSearch.foods ?? [];
  foods.shuffle();
  List<int> kaloris = foods
      .map((e) => (e.foodNutrients!
                  .firstWhere((data) => data.nutrientName == 'Energy')
                  .value ??
              0.0)
          .toInt())
      .toList();
  print(kaloris);
  // kayu.shuffle();
  // // kayu.shuffle();
  // print(kayu);
  int totalPanjang = bmr.round();
  int jumlahKayu = kaloris.length;
  List<int> panjangTerpilih = List.filled(jumlahKayu, 0);
  // print('panjang terpilih: $panjangTerpilih');

  // Membuat tabel untuk menyimpan nilai maksimal
  List<List<int>> tabelMaksimal =
      List.generate(jumlahKayu + 1, (_) => List.filled(totalPanjang + 1, 0));

  // Mengisi tabel dengan nilai maksimal
  for (int i = 1; i <= jumlahKayu; i++) {
    for (int j = 1; j <= totalPanjang; j++) {
      // print('${kayu[i - 1]} <= $j');
      if (kaloris[i - 1] <= j) {
        // print('kayu[i - 1] : ${kayu[i - 1]}');
        // print('i = $i, j = $j');
        // print(
        //     'kayu[i - 1] + tabelMaksimal[i - 1][j - kayu[i - 1]] : ${kayu[i - 1]} + ${tabelMaksimal[i - 1][j - kayu[i - 1]]}');
        tabelMaksimal[i][j] = max(tabelMaksimal[i - 1][j],
            kaloris[i - 1] + tabelMaksimal[i - 1][j - kaloris[i - 1]]);
        // print('tabelMaksimal[i][j] : ${tabelMaksimal[i][j]}');
      } else {
        tabelMaksimal[i][j] = tabelMaksimal[i - 1][j];
        // print('i = $i, j = $j');
        // print('tabelMaksimal[i][j] : ${tabelMaksimal[i - 1][j]}');
      }
    }
    // print('tabelMaksimal[i] : ${tabelMaksimal[i]}');
  }
  // print('TABEL MAKSIMAL : $tabelMaksimal');

  // Mencari kayu yang terpilih
  int i = jumlahKayu;
  int j = totalPanjang;
  while (i > 0 && j > 0) {
    // print('i : $i, j: $j');
    // print(
    //     'tabelMaksimal[i][j] != tabelMaksimal[i - 1][j] = ${tabelMaksimal[i][j]} != ${tabelMaksimal[i - 1][j]}');
    if (tabelMaksimal[i][j] != tabelMaksimal[i - 1][j]) {
      panjangTerpilih[i - 1] = 1;
      print(panjangTerpilih);
      // print('j: $j');
      j -= kaloris[i - 1];
      // print('j: $j');
    }
    i--;
  }

  // Menampilkan kayu yang terpilih
  print(
      "Kayu yang harus dipilih untuk mendapatkan panjang $totalPanjang adalah:");
  for (int i = 0; i < jumlahKayu; i++) {
    if (panjangTerpilih[i] == 1) {
      print("${foods[i].description} (${kaloris[i]})");
    }
  }
}
