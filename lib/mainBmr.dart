// import 'dart:convert';
// import 'dart:io';
// import 'dart:math';
// import 'package:http/http.dart' as http;
// import 'package:nobes/app/data/models.dart';

// void main() async {
//   stdout.write('Berat badan (kg): ');
//   double weight = double.parse(stdin.readLineSync()!);

//   stdout.write('Tinggi badan (cm): ');
//   double height = double.parse(stdin.readLineSync()!);

//   stdout.write('Usia (tahun): ');
//   int age = int.parse(stdin.readLineSync()!);

//   stdout.write('Jenis kelamin (P/L): ');
//   String gender = stdin.readLineSync()!;

//   stdout.write('Aktivitas fisik (1-3): ');
//   int activityLevel = int.parse(stdin.readLineSync()!);

//   stdout.write('Nama Menu: ');
//   String menuName = stdin.readLineSync()!;

//   stdout.write('Banyak Menu: ');
//   int menuTotal = int.parse(stdin.readLineSync()!);

//   final parameters = {
//     'search_expression': menuName,
//     'method': 'foods.search',
//     'format': 'json',
//   };

//   const accessToken =
//       'eyJhbGciOiJSUzI1NiIsImtpZCI6IjVGQUQ4RTE5MjMwOURFRUJCNzBCMzU5M0E2MDU3OUFEMUM5NjgzNDkiLCJ0eXAiOiJhdCtqd3QiLCJ4NXQiOiJYNjJPR1NNSjN1dTNDeldUcGdWNXJSeVdnMGsifQ.eyJuYmYiOjE2Nzk1MjY3NTMsImV4cCI6MTY3OTYxMzE1MywiaXNzIjoiaHR0cHM6Ly9vYXV0aC5mYXRzZWNyZXQuY29tIiwiYXVkIjoiYmFzaWMiLCJjbGllbnRfaWQiOiIwMDk0MWE0NTM3ZTc0MjY1YWQxNDliZmQ3NDE3YmU0OCIsInNjb3BlIjpbImJhc2ljIl19.VcViDkwaZq5Dj5KdrQ3J2hE_wYRJGxBjrVTzfjdUi-aN5lNuqs-5Ft6RKb6Rp8B92nwmhKs_ez43hOsqUepR1fbY87TNuy-ob-nrWdpO5oIiMs2R0dEsMeNQsn4Bt_B4qrTeAGdjX1xJ2t6EdgXIBBJlD-rcoEyrilnmbNP972erWafAPuBCnN9o-V4Z_WCYOPbNbfTaTdcvz5yZBuhjIdQ-IpSQnAXkrJWwnCkZTEgE2SEOGXh-fVK5_C3LTggcxJ6ZEOsuufYauLUyIzTwr69ApjBCsNn-CGt6RR1Smpvo6j8vKSYCpeOTeXheZv7yyk20n5Z5u2zt6kwOLhl07g';

//   var response = await http.get(
//     Uri.https(
//       'platform.fatsecret.com',
//       '/rest/server.api',
//       parameters,
//     ),
//     headers: {HttpHeaders.authorizationHeader: 'Bearer $accessToken'},
//   );

//   var body = FatSecretModels.fromJson(jsonDecode(response.body));

//   print(body.foods!.food!.map((e) => e.foodName).toList().toString());

//   double bmr;

//   // Menghitung BMR
//   if (gender == 'P') {
//     bmr = 655 + (9.6 * weight) + (1.8 * height) - (4.7 * age);
//   } else {
//     bmr = 66 + (13.7 * weight) + (5 * height) - (6.8 * age);
//   }

//   print('BMR = $bmr');

//   double activity = 0.0;
//   if (activityLevel == 1) {
//     activity = 1.2;
//   } else if (activityLevel == 2) {
//     activity = 1.3;
//   } else if (activityLevel == 3) {
//     activity = 1.4;
//   } else {
//     activity = 0.0;
//   }

//   double kkt;

//   // Menghitung kebutuhan kalori total
//   kkt = bmr * activity;

//   // kkt = kkb + (persentaseActivity * kkb) - (persentaseUmur * kkb);
//   print('KKT = $kkt');
//   // print('\nKebutuhan kalori total: $totalCalories kkal/hari');

//   int ambilKalori(String kalimat) {
//     List<String> kata =
//         kalimat.split(" "); // memecah kalimat menjadi array kata
//     for (int i = 0; i < kata.length; i++) {
//       if (kata[i].endsWith("kcal")) {
//         // mencari kata yang diakhiri dengan "kcal"
//         String angka = kata[i]
//             .replaceAll("kcal", ""); // menghapus "kcal" dari kata tersebut
//         return int.parse(angka); // mengonversi kata menjadi integer
//       }
//     }
//     return 0; // jika tidak ditemukan, kembalikan angka nol
//   }

//   List<String> menuList = body.foods!.food!.map((e) => e.foodName!).toList();

//   List<int> calorieList =
//       body.foods!.food!.map((e) => ambilKalori(e.foodDescription!)).toList();

//   print(calorieList.toString());

//   int hitungFaktorial(int n) {
//     if (n == 0) {
//       return 1;
//     } else {
//       return n * hitungFaktorial(n - 1);
//     }
//   }

//   int hitungKombinasi(int n, int r) {
//     int faktorialN = hitungFaktorial(n);
//     int faktorialR = hitungFaktorial(r);
//     int faktorialNR = hitungFaktorial(n - r);
//     int kombinasi = faktorialN ~/ (faktorialR * faktorialNR);
//     return kombinasi;
//   }

//   int kombinasi = hitungKombinasi(menuList.length, menuTotal);

//   print("${menuList.length}C$menuTotal = $kombinasi");

//   // jumlah sampel yang akan diambil
//   int numSamples = kombinasi * menuTotal;

//   // inisialisasi variabel hasil
//   List<String> resultMenuList = [];
//   int resultTotalCalorie = 0;
//   int resultDiff = 0;

//   // loop untuk mengambil sampel kombinasi menu secara acak
//   for (int i = 0; i < numSamples; i++) {
//     // mengambil 3 menu secara acak
//     List<int> sampleIndices =
//         List.generate(menuTotal, (i) => Random().nextInt(menuList.length));
//     // menghitung jumlah kalori dari 10 menu tersebut
//     int sampleTotalCalorie = 0;
//     for (int j = 0; j < sampleIndices.length; j++) {
//       sampleTotalCalorie += calorieList[sampleIndices[j]];
//     }
//     // memeriksa apakah jumlah kalori lebih mendekati 100 daripada hasil sebelumnya
//     int sampleDiff = (sampleTotalCalorie - kkt.toInt()).abs();
//     if (resultTotalCalorie == 0 ||
//         sampleDiff < resultDiff ||
//         sampleIndices.contains(calorieList)) {
//       resultMenuList = sampleIndices
//           .map((index) => '${menuList[index]} (${calorieList[index]})')
//           .toList();
//       resultTotalCalorie = sampleTotalCalorie;
//       resultDiff = sampleDiff;
//     }
//   }

//   // menampilkan hasil
//   String resultMenuString = resultMenuList.join(', ');
//   int resultCalorieDiff = resultTotalCalorie - kkt.toInt();
//   String resultDiffString =
//       resultCalorieDiff > 0 ? '+$resultCalorieDiff' : '$resultCalorieDiff';
//   print(
//       'Kombinasi menu yang mendekati: $resultMenuString \n(total kalori: $resultTotalCalorie, selisih: $resultDiffString)');
// }
