import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:toko_bangunan_nuh/core/app_color.dart';
import 'package:toko_bangunan_nuh/core/app_data.dart';
import 'package:toko_bangunan_nuh/src/presentation/page/cart/cart_page.dart';
import 'package:toko_bangunan_nuh/src/presentation/page/favorite/favorite_page.dart';
import 'package:toko_bangunan_nuh/src/presentation/page/home/home_page.dart';
import 'package:toko_bangunan_nuh/src/presentation/page/order/order_page.dart';
import 'package:toko_bangunan_nuh/src/presentation/page/profile/profile_page.dart';

class Dashboard extends HookWidget {
  final List<Widget> screens =  [
    ListProductPage(),
    CartPage(),
    FavoritePage(),
    ProfilePage(),
    OrderPage(address: '', city: '', name: '', phoneNumber: '', postalCode: '', totalPayment: 0),
  ];

  Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(0);

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColor.lightPurple,
        unselectedItemColor: AppColor.lightPurple,
        currentIndex: selectedIndex.value,
        showUnselectedLabels: true,
        onTap: (int index) {
          selectedIndex.value = index;
        },
        fixedColor: AppColor.lightBlack,
        items: AppData.bottomNavigationItems
            .map(
              (element) => BottomNavigationBarItem(
                  icon: element.icon, label: element.label),
            )
            .toList(),
      ),
      body: screens[selectedIndex.value],
    );
  }
}
