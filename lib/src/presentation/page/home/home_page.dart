import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toko_bangunan_nuh/core/app_color.dart';
import 'package:toko_bangunan_nuh/core/app_style.dart';
import 'package:toko_bangunan_nuh/src/business_logic/product_bloc.dart';
import 'package:toko_bangunan_nuh/src/data/model/product.dart';
import 'package:toko_bangunan_nuh/src/presentation/page/product_detail_page.dart';
import 'package:toko_bangunan_nuh/src/presentation/widget/product_list_view.dart';

class ListProductPage extends StatelessWidget {
  const ListProductPage({Key? key}) : super(key: key);

  PreferredSize _appBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(165),
      child: SafeArea(
        child: Container(
            //AppBar UNGU
            decoration: const BoxDecoration(
                color: AppColor.lightPurple,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.elliptical(20, 20),
                    bottomLeft: Radius.elliptical(20, 20))),
            // color: AppColor.lightPurple,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Toko Bangunan NUH", style: h2StyleW),
                          Text("Sedia kebutuhan bangunanmu", style: h3StyleW),
                        ],
                      ),
                      // IconButton(
                      //   onPressed: () {},
                      //   icon: const Icon(Icons.logout),
                      //   color: Colors.white,
                      //   iconSize: 30,
                      // ),
                      
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: _searchBar(),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade500,
              offset: const Offset(1, 2),
              blurRadius: 10,
            )
          ],
        ),
        child: TextFormField(
          decoration: InputDecoration(
            hoverColor: Colors.grey,
            isDense: true,
            isCollapsed: true,
            hintText: 'Cari Barang...',
            hintStyle: const TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.normal),
            contentPadding: const EdgeInsets.all(
                8), //untuk mengatur ketebalan atau tinggi kolom pencarian
            prefixIcon: const Icon(
              Icons.search,
              size: 20,
              color: Colors.black,
            ),
            fillColor: Colors.grey.shade50, //warna isi textfield
            focusColor: Colors.grey.shade600,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                width: 0,
                color:
                    Colors.transparent, // warna outline texfield ketika aktif
              ),
            ),
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: const BorderSide(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Product> items = context.watch<ProductBloc>().state.mainItems;

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

//tampilan PRODUCT
    return Scaffold(
      appBar: _appBar(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 20 / 8,
                  enlargeCenterPage: true,
                ),
                items: [
                  Container(
                    width: MediaQuery.of(context)
                        .size
                        .width, // Menggunakan lebar layar saat ini
                    color: Colors.redAccent,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Slogan 1',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Ornament 1',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context)
                        .size
                        .width, // Menggunakan lebar layar saat ini
                    color: Colors.blueAccent,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Slogan 2',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Ornament 2',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context)
                        .size
                        .width, // Menggunakan lebar layar saat ini
                    color: Colors.greenAccent,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Slogan 3',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Ornament 3',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Tambahkan kontainer lain dengan ornament dan slogan yang berbeda di sini
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Most recent",
                      style: h2Style,
                    ),
                    SizedBox(),
                   
                  ],
                ),
              ),
              ProductListView(
                productList: items,
                onTap: navigate,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Popular", style: h2Style),
                  SizedBox(),
                  
                ],
              ),
              ProductListView(
                productList: items,
                isHorizontal: false,
                onTap: navigate,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
