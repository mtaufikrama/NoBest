import 'dart:math';

void main() async {
  final Map<String, int> menu = {
    'pizza': 100,
    'burger': 200,
    'kentang': 500,
    'salad': 100,
    'coca cola': 210
  };
  int kebutuhanKalori = 600;
  List<String> menuTerpilih = [];

  while (kebutuhanKalori > 0) {
    // Memilih menu secara acak
    String randomMenu = menu.keys.elementAt(Random().nextInt(menu.length));
    print('random menu : $randomMenu');

    // Memastikan menu belum dipilih sebelumnya
    if (menuTerpilih.contains(randomMenu) == false) {
      int kaloriMenu = menu[randomMenu]!;
      var selisihKalori = kebutuhanKalori - kaloriMenu;
      print('Selisih Kalori : $selisihKalori');
      if (selisihKalori >= 0) {
        menuTerpilih.add(randomMenu);
        print(menuTerpilih);
        kebutuhanKalori -= kaloriMenu;
        print('kebutuhan kalori : $kebutuhanKalori');
      }
    }
  }

  // Menampilkan hasil menu terpilih
  print('Menu yang terpilih:');
  print(menuTerpilih);
}
