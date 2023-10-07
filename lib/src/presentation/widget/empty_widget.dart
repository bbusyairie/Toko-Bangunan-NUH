import 'package:flutter/material.dart';

import 'package:toko_bangunan_nuh/core/app_asset.dart';
import 'package:toko_bangunan_nuh/core/app_style.dart';

enum EmptyWidgetType { cart, favorite }

class EmptyWidget extends StatelessWidget {
  final EmptyWidgetType type;
  final String title;

  const EmptyWidget(
      {Key? key, this.type = EmptyWidgetType.cart, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          type == EmptyWidgetType.cart
              ? Expanded(child: Image.asset(AppAsset.emptyCart))
              : Image.asset(AppAsset.emptyFavorite),
          const SizedBox(height: 10),
          Text(title, style: h2Style)
        ],
      ),
    );
  }
}
