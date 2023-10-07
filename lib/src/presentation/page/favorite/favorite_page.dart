import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toko_bangunan_nuh/core/app_style.dart';
import 'package:toko_bangunan_nuh/src/business_logic/product_bloc.dart';
import 'package:toko_bangunan_nuh/src/data/model/product.dart';
import 'package:toko_bangunan_nuh/src/presentation/page/product_detail_page.dart';
import 'package:toko_bangunan_nuh/src/presentation/widget/empty_widget.dart';
import 'package:toko_bangunan_nuh/src/presentation/widget/product_list_view.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Product> favoriteList = context.watch<ProductBloc>().getFavoriteList;
Future<Widget?> navigate(Product product, int index) {
      return Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(seconds: 1),
          pageBuilder: (_, __, ___) =>
              ProductDetailPage(product: product, index: index),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text("Favorites", style: h2Style)),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              favoriteList.isNotEmpty
                  ? ProductListView(
                      isHorizontal: false,
                      productList: favoriteList,
                      onTap: navigate,
                    )
                  : const EmptyWidget(
                      type: EmptyWidgetType.favorite,
                      title: "Empty favorite",
                    )
            ],
          ),
        ),
      ),
    );
  }
}