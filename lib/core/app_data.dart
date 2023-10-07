import 'package:flutter/material.dart';

import 'package:toko_bangunan_nuh/src/data/model/bottom_navigation_item.dart';

class AppData {
  const AppData._();

  static const List<BottomNavigationItem> bottomNavigationItems = [
    BottomNavigationItem(Icon(Icons.home), 'Beranda'),
    BottomNavigationItem(Icon(Icons.add_shopping_cart_rounded), 'Keranjang'),
    BottomNavigationItem(Icon(Icons.bookmark), 'Favorit'),
    
    BottomNavigationItem(Icon(Icons.person), 'Profil'),
    BottomNavigationItem(Icon(Icons.receipt_long_outlined), 'Pesanan'),
  ];
}
