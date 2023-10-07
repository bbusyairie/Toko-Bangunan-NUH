import 'package:toko_bangunan_nuh/core/app_style.dart';
import 'package:toko_bangunan_nuh/src/data/model/product.dart';
import 'package:toko_bangunan_nuh/src/presentation/constant/app_extension.dart';

import '../widget/rating_bar.dart';
import 'package:flutter/material.dart';

class ProductListView extends StatelessWidget {
  final bool isHorizontal;
  final Function(Product product, int index)? onTap;
  final List<Product> productList;
//todo TAMPILKAN JUMLAH TOTAL CHECKOUT KEMUDIAN BERIKAN NOMOR WA UNTUK KONFIRMASI PEMBAYARAN
  const ProductListView({
    Key? key,
    this.isHorizontal = true,
    this.onTap,
    required this.productList,
  }) : super(key: key);

  Widget _productScore(Product product) {
    return Row(
      children: [
        StarRatingBar(score: product.score),
        const SizedBox(width: 10),
        Text(product.score.toString(), style: namaProduct),
      ],
    ).fadeAnimation(1.0);
  }

  Widget _productImage(String image) {
    return ClipRRect(
      child: Image.asset(image, fit: BoxFit.fill),
    ).fadeAnimation(0.4);
  }

  // Bagaimana Produk ditampilkan
  Widget _listViewItem(Product product, int index) {
    Widget widget;
    widget = isHorizontal == true
        ? Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
              // Container wrapper
              width: 120,
              decoration: BoxDecoration(
                // Container decoration
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color:
                        const Color.fromARGB(255, 154, 154, 154).withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 1,
                    offset: const Offset(
                        1,1 ), // Atur offset untuk mengontrol arah bayangan
                  ),
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 8,
                        child: Hero(
                            tag: index, child: _productImage(product.images[0]))),
                    // const SizedBox(height: 10),
                    const SizedBox(height: 10),
                    Expanded(
                        child: Text(product.title.addOverFlow, style: namaProduct)
                            .fadeAnimation(0.8)),
                    Expanded(child: _productScore(product)),
                    Expanded(
                      child: Text(
                        CurrencyFormat.convertToIdr(product.price),
                        style: hargaStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        )
        : Container(
            // Container wrapper
          
            decoration: BoxDecoration(
              // Container decoration
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color:
                      const Color.fromARGB(255, 154, 154, 154).withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 1,
                  offset: const Offset(
                      1,1 ), // Atur offset untuk mengontrol arah bayangan
                ),
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 6,
                      child: Center(child: _productImage(product.images[0]))),
                  const SizedBox(),
                  Expanded(
                      child: Text(product.title.addOverFlow, style: namaProduct)
                          .fadeAnimation(0.8)),
                  Expanded(child: _productScore(product)),
                  Expanded(
                    child: Text(
                      CurrencyFormat.convertToIdr(product.price),
                      style: hargaStyle,
                    ),
                  ),
                ],
              ),
            ),
          );

   
    return GestureDetector(
      onTap: () => onTap?.call(product, index),
      child: widget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return isHorizontal == true
        ? SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: productList.length,
              itemBuilder: (_, index) {
                Product product = productList[index];
                return _listViewItem(product, index);
              },
              separatorBuilder: (_, __) {
                return const Padding(padding: EdgeInsets.only(left: 15));
              },
            ),
          )
        : GridView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: productList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: MediaQuery.of(context).size.width ~/ 110,
              childAspectRatio: 0.65,
            ),
            itemBuilder: (_, index) {
              Product product = productList[index];
              return _listViewItem(product, index);
            },
          );
  }
}
