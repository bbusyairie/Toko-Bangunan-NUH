

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toko_bangunan_nuh/core/app_color.dart';
import 'package:toko_bangunan_nuh/core/app_style.dart';
import 'package:toko_bangunan_nuh/src/business_logic/product_bloc.dart';
import 'package:toko_bangunan_nuh/src/data/model/product.dart';
import 'package:toko_bangunan_nuh/src/presentation/page/cart/order_confirmation_page.dart';
import 'package:toko_bangunan_nuh/src/presentation/widget/bottom_bar.dart';
import 'package:toko_bangunan_nuh/src/presentation/widget/cart_list_view.dart';
import 'package:toko_bangunan_nuh/src/presentation/widget/counter_button.dart';
import 'package:toko_bangunan_nuh/src/presentation/widget/empty_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Product> cartList = context.watch<ProductBloc>().getCartList;

    final totalPrice = context.watch<ProductBloc>().state.totalPrice;

    PreferredSizeWidget appBar() {
      return AppBar(
        title: const Text("Keranjang", style: h2Style),
        actions: [
          IconButton(
            splashRadius: 20.0,
            onPressed: () {
              context.read<ProductBloc>().add(const ClearCartEvent());
            },
            icon: const Icon(Icons.delete, color: AppColor.lightPurple),
          )
        ],
      );
    }

    void navigateToOrderConfirmationPage() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderConfirmationPage(
            productItems: cartList,
            totalPrice: totalPrice,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: appBar(),
      bottomNavigationBar: BottomBar(
        priceLabel: "Total harga",
        priceValue: CurrencyFormat.convertToIdr(totalPrice),
        buttonLabel: "Checkout",
        onTap: totalPrice > 0 ? navigateToOrderConfirmationPage : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: cartList.isNotEmpty
            ? CartListView(
                productItems: cartList,
                counterButton: (product, index) {
                  return CounterButton(
                    orientation: Axis.vertical,
                    onIncrementSelected: () => context
                        .read<ProductBloc>()
                        .add(IncreaseQuantityEvent(product: product)),
                    onDecrementSelected: () => context
                        .read<ProductBloc>()
                        .add(DecreaseQuantityEvent(product: product)),
                    label: cartList[index].quantity,
                  );
                },
              )
            : const EmptyWidget(title: "Empty cart"),
      ),
    );
  }
}
