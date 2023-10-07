import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:toko_bangunan_nuh/core/app_style.dart';
import 'package:toko_bangunan_nuh/src/business_logic/product_bloc.dart';
import 'package:toko_bangunan_nuh/src/data/model/product.dart';
import 'package:toko_bangunan_nuh/src/presentation/constant/app_extension.dart';

class CartListView extends StatelessWidget {
  const CartListView({
    Key? key,
    required this.counterButton,
    required this.productItems,
  }) : super(key: key);

  final Widget Function(Product product, int index) counterButton;
  final List<Product> productItems;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: productItems.length,
        itemBuilder: (_, index) {
          Product product = productItems[index];
          return Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 241, 225, 255),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 154, 154, 154).withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset:
                      Offset(0, 2), // Atur offset untuk mengontrol arah bayangan
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(product.images[0]),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.title.addOverFlow, style: namaProduct),
                      const SizedBox(height: 5),
                      Text(
                        CurrencyFormat.convertToIdr(product.price),
                        
                        style: h2Style,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 100, // Atur lebar Container sesuai kebutuhan
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          // Hapus item dari keranjang
                            context.read<ProductBloc>().add(
                            RemoveFromCartEvent(product: product),
                          );
                        },
                        icon: Icon(Icons.delete),
                      ),
                      counterButton(product, index),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (_, __) {
          return const SizedBox(height: 10);
        },
      ),
    );
  }
}
