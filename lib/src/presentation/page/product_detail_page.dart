import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:toko_bangunan_nuh/core/app_color.dart';
import 'package:toko_bangunan_nuh/core/app_style.dart';
import 'package:toko_bangunan_nuh/src/business_logic/product_bloc.dart';
import 'package:toko_bangunan_nuh/src/data/model/product.dart';
import 'package:toko_bangunan_nuh/src/presentation/constant/app_extension.dart';
import 'package:toko_bangunan_nuh/src/presentation/widget/bottom_bar.dart';

import 'package:toko_bangunan_nuh/src/presentation/widget/counter_button.dart';
import 'package:toko_bangunan_nuh/src/presentation/widget/rating_bar.dart';

class ProductDetailPage extends HookWidget {
  final Product product;
  final int index;

  const ProductDetailPage({
    Key? key,
    required this.product,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Product> items =
        context.watch<ProductBloc>().state.mainItems;
    double height = MediaQuery.of(context).size.height;

    final selectedIndex = useState(0);

    Widget productImageSlider(double height) {
      return Container(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
        height: height * 0.4,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView.builder(
              onPageChanged: (int index) {
                selectedIndex.value = index;
              },
              itemCount: product.images.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Hero(
                      tag: index,
                      child: Image.asset(
                        product.images[index],
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                );
              },
            ),
            Positioned(
              bottom: 20,
              child: SmoothIndicator(
                effect: const WormEffect(
                  dotColor: Colors.grey,
                  activeDotColor: Color.fromARGB(255, 198, 7, 241),
                ),
                offset: selectedIndex.value.toDouble(),
                count: product.images.length,
                size: Size(12, 12),
              ),
            ),
          ],
        ),
      );
    }

    PreferredSizeWidget appBar(BuildContext context) {
      return AppBar(
        actions: [
          IconButton(
            splashRadius: 18.0,
            onPressed: () {
              context
                  .read<ProductBloc>()
                  .add(AddToFavoriteEvent(product: items[index]));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Produk ditambahkan ke Favorit'),
                ),
              );
            },
            icon: items[index].isFavorite
                ? const Icon(Icons.bookmark, color: AppColor.lightPurple)
                : const Icon(Icons.bookmark_border, color: Colors.black),
          )
        ],
        leading: IconButton(
          icon: const Icon(
            FontAwesomeIcons.arrowLeft,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(product.title, style: h2Style),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        return Future.value(true);
      },
      child: Scaffold(
        bottomNavigationBar: BottomBar(
          priceLabel: "Harga",
          priceValue: CurrencyFormat.convertToIdr(product.price),
          buttonLabel: "Tambah Ke keranjang",
          onTap: () {
            context
                .read<ProductBloc>()
                .add(AddToCartEvent(product: items[index], index: index));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Produk ditambahkan ke Keranjang'),
              ),
            );
          },
        ),
        appBar: appBar(context),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                productImageSlider(height),
                Center(
                  child: Row(
                    children: [
                      StarRatingBar(score: product.score, itemSize: 20),
                      const SizedBox(width: 10),
                      Text(product.score.toString(), style: TextStyle(fontSize: 20)),
                    ],
                  ).fadeAnimation(1.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: const Text(
                    "Deskripsi",
                    style: h2Style,
                    textAlign: TextAlign.end,
                  ).fadeAnimation(0.6),
                ),
                Text(
                  product.description,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black45),
                ).fadeAnimation(0.8),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: CounterButton(
                        label: items[index].quantity,
                        onIncrementSelected: () {
                          context.read<ProductBloc>().add(
                                IncreaseQuantityEvent(
                                  product: items[index],
                                ),
                              );
                        },
                        onDecrementSelected: () {
                          context.read<ProductBloc>().add(
                                DecreaseQuantityEvent(
                                  product: items[index],
                                ),
                              );
                        },
                      ),
                    ),
                  ],
                ).fadeAnimation(1.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
