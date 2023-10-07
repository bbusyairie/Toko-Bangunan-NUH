import 'package:flutter/material.dart';
import 'package:toko_bangunan_nuh/core/app_asset.dart';

import 'package:toko_bangunan_nuh/src/data/model/product.dart';
import 'package:toko_bangunan_nuh/src/data/model/product_color.dart';

class Repository {
  get getProductList {
    const dummyText =
        """Lorem Ipsum is simply dummy text of the printing and typesetting
       industry. Lorem Ipsum has been the industry's standard dummy text ever
        since the 1500s, when an unknown printer took a galley of type and
         scrambled it to make a type specimen book. It has survived not only 
         five centuries, but also the leap into electronic typesetting,
          remaining essentially unchanged. It was popularised in the 1960s with
           the release of Letraset sheets containing Lorem Ipsum passages,
            and more recently with desktop publishing software like Aldus
             PageMaker including versions of Lorem Ipsum.""";

    List<Product> productList = [
      Product(
        id: 1,
        quantity: 1,
        isFavorite: false,
        title: 'Paku Beton Marabu',
        description: dummyText,
        price: 2000,
        score: 3.5,
        images: const [
          AppAsset.pakuBetonA01,
          AppAsset.pakuBetonA01,
          AppAsset.pakuBetonA01,
          AppAsset.pakuBetonA01,
          AppAsset.pakuBetonA01,
          AppAsset.pakuBetonA01,
          AppAsset.pakuBetonA01,
        ],
        colors: <ProductColor>[
          ProductColor(color: const Color(0xFF616161), isSelected: true),
          ProductColor(color: const Color(0xFF424242)),
        ],
      ),
      Product(
        id: 2,
        isFavorite: false,
        quantity: 1,
        title: 'Cat Tembok Decofresh',
        description: dummyText,
        price: 14000,
        score: 4.7,
        images: const [
          AppAsset.catDecoA01,
          AppAsset.catDecoA01,
          AppAsset.catDecoA01,
          AppAsset.catDecoA01,
          AppAsset.catDecoA01,
        ],
        colors: <ProductColor>[
          ProductColor(color: const Color(0xFF5d4037), isSelected: true),
          ProductColor(color: const Color(0xFF424242)),
        ],
      ),
      Product(
        id: 3,
        quantity: 1,
        isFavorite: false,
        title: 'Pipa Rucika PVC 1 1/4 D',
        description: dummyText,
        price: 20000,
        score: 4.7,
        images: const [
          AppAsset.pipaRucikaA01,
          AppAsset.pipaRucikaA01,
          AppAsset.pipaRucikaA01,
          AppAsset.pipaRucikaA01,
          AppAsset.pipaRucikaA01,
          AppAsset.pipaRucikaA01,
        ],
        colors: <ProductColor>[
          ProductColor(color: const Color(0xFF616161), isSelected: true),
          ProductColor(color: const Color(0xFF212121)),
        ],
      ),
      Product(
        id: 4,
        quantity: 1,
        isFavorite: false,
        title: 'Djabesmen 7 kaki',
        description: dummyText,
        price: 40000,
        score: 2.5,
        images: const [
          AppAsset.Djabesmen1,
          AppAsset.Djabesmen1,
          AppAsset.Djabesmen1,
          AppAsset.Djabesmen1,
          AppAsset.Djabesmen1,
          AppAsset.Djabesmen1,
        ],
        colors: <ProductColor>[
          ProductColor(color: const Color(0xFF455a64), isSelected: true),
          ProductColor(color: const Color(0xFF263238)),
        ],
      ),
      Product(
        id: 5,
        quantity: 1,
        isFavorite: false,
        title: 'Fitting Pipa L',
        description: dummyText,
        price: 14000,
        score: 2.8,
        images: const [
          AppAsset.fittingPipa,
          AppAsset.fittingPipa,
          AppAsset.fittingPipa,
          AppAsset.fittingPipa,
          AppAsset.fittingPipa,
        ],
        colors: <ProductColor>[
          ProductColor(color: const Color(0xFF5d4037), isSelected: true),
          ProductColor(color: const Color(0xFF455a64)),
        ],
      ),
      Product(
        id: 6,
        quantity: 1,
        isFavorite: false,
        title: 'Remote TV Universal',
        description: dummyText,
        price: 25000,
        score: 2.8,
        images: const [
          AppAsset.remoteTV,
          
        ],
        colors: <ProductColor>[
          ProductColor(color: const Color(0xFF5d4037), isSelected: true),
          ProductColor(color: const Color(0xFF455a64)),
        ],
      ),
      Product(
        id: 7,
        quantity: 1,
        isFavorite: false,
        title: 'Sitrang LED 8 Watt',
        description: dummyText,
        price: 23000,
        score: 2.8,
        images: const [
          AppAsset.sitrangLED,
          AppAsset.sitrangLED,
          AppAsset.sitrangLED,
          AppAsset.sitrangLED,
          AppAsset.sitrangLED,
        ],
        colors: <ProductColor>[
          ProductColor(color: const Color(0xFF5d4037), isSelected: true),
          ProductColor(color: const Color(0xFF455a64)),
        ],
      ),
      Product(
        id: 8,
        quantity: 1,
        isFavorite: false,
        title: 'Stopkontak Tanam',
        description: dummyText,
        price: 19000,
        score: 2.8,
        images: const [
          AppAsset.stopKontak,
          AppAsset.stopKontak,
          AppAsset.stopKontak,
          AppAsset.stopKontak,
          AppAsset.stopKontak,
        ],
        colors: <ProductColor>[
          ProductColor(color: const Color(0xFF5d4037), isSelected: true),
          ProductColor(color: const Color(0xFF455a64)),
        ],
      ),
      Product(
        id: 9,
        quantity: 1,
        isFavorite: false,
        title: 'Engsel PVC',
        description: dummyText,
        price: 10000,
        score: 2.8,
        images: const [
          AppAsset.engsel_pvc,
          AppAsset.engsel_pvc,
          AppAsset.engsel_pvc,
          AppAsset.engsel_pvc,
          AppAsset.engsel_pvc,
        ],
        colors: <ProductColor>[
          ProductColor(color: const Color(0xFF5d4037), isSelected: true),
          ProductColor(color: const Color(0xFF455a64)),
        ],
      ),
      Product(
        id: 10,
        quantity: 1,
        isFavorite: false,
        title: 'Stopkontak Tempel',
        description: dummyText,
        price: 15000,
        score: 2.8,
        images: const [
          AppAsset.stopKontak1,
          AppAsset.stopKontak1,
          AppAsset.stopKontak1,
          AppAsset.stopKontak1,
          AppAsset.stopKontak1,
        ],
        colors: <ProductColor>[
          ProductColor(color: const Color(0xFF5d4037), isSelected: true),
          ProductColor(color: const Color(0xFF455a64)),
        ],
      ),
    ];

    return productList;
  }
}
