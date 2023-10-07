import 'package:flutter/material.dart';

import 'package:toko_bangunan_nuh/src/presentation/animation/fade_in_animation.dart';
import 'package:toko_bangunan_nuh/src/data/model/product.dart';

extension StringExtension on String {
  String get addOverFlow {
    if (length < 15) {
      return this;
    } else {
      return "${substring(0, 14)}...";
    }
  }
}

extension WidgetExtension on Widget {
  Widget fadeAnimation(double delay) {
    return FadeInAnimation(delay: delay, child: this);
  }
}

extension IntegerExtension on int {
  get increase => this + 1;

  get decrease => this - 1;
}

enum Operation { increase, decrease, delete, favorite }

extension ListExtension on List<Product> {
  List<Product> operator(Product product, Operation operation) {
    switch (operation) {
      case Operation.increase:
        product = product.copyWith(quantity: product.quantity.increase);
        break;
      case Operation.decrease:
        product = product.copyWith(quantity: product.quantity.decrease);
        break;
      case Operation.delete:
        product = product.copyWith(cart: false);
        break;
      case Operation.favorite:
        product = product.copyWith(isFavorite: !product.isFavorite);
        break;
    }
    List<Product> list = map((element) {
      if (element.id == product.id) {
        return product;
      }
      return element;
    }).toList();

    return list;
  }
}
