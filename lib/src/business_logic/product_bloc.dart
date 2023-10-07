import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:toko_bangunan_nuh/src/data/model/product.dart';
import 'package:toko_bangunan_nuh/src/data/repository/repository.dart';
import 'package:toko_bangunan_nuh/src/presentation/constant/app_extension.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({required this.repository})
      : super(ProductState.initial(repository.getProductList)) {
    on<IncreaseQuantityEvent>(_increaseQuantity);
    on<DecreaseQuantityEvent>(_decreaseQuantity);
    on<AddToCartEvent>(_addToCart);
    on<AddToFavoriteEvent>(_addToFavorite);
    on<ClearCartEvent>(_clearCart);
    on<RemoveFromCartEvent>(_removeFromCart);
  }

  final Repository repository;


  void _increaseQuantity(
      IncreaseQuantityEvent event, Emitter<ProductState> emit) {
    final List<Product> items =
        state.mainItems.operator(event.product, Operation.increase);

    emit(ProductState(mainItems: items));
    _getTotalPrice(emit);
  }

  void _decreaseQuantity(
      DecreaseQuantityEvent event, Emitter<ProductState> emit) {
    List<Product> items = [];
    if (event.product.quantity > 1) {
      items = state.mainItems.operator(event.product, Operation.decrease);
    } else {
      items = state.mainItems.operator(event.product, Operation.delete);
    }

    emit(ProductState(mainItems: items));
    _getTotalPrice(emit);
  }

  void _addToCart(AddToCartEvent event, Emitter<ProductState> emit) {
    final List<Product> items = state.mainItems.map((element) {
      if (event.product.id == element.id) {
        return event.product.copyWith(
            cart: true, quantity: state.mainItems[event.index].quantity);
      }
      return element;
    }).toList();

    emit(ProductState(mainItems: items));
    _getTotalPrice(emit);
  }

  void _addToFavorite(AddToFavoriteEvent event, Emitter<ProductState> emit) {
    final List<Product> items =
        state.mainItems.operator(event.product, Operation.favorite);
    emit(ProductState(mainItems: items));
    _getTotalPrice(emit);
  }

  void _clearCart(ClearCartEvent event, Emitter<ProductState> emit) {
    final List<Product> items = state.mainItems
        .map((element) => element.copyWith(cart: false))
        .toList();

    emit(ProductState(mainItems: items));
  }

  void _removeFromCart(RemoveFromCartEvent event, Emitter<ProductState> emit) {
 final List<Product> updatedItems = state.mainItems
      .map((element) =>
          element.id == event.product.id ? element.copyWith(cart: false) : element)
      .toList();

  // Mengurangi harga produk yang dihapus dari total harga saat ini
  final double updatedTotalPrice = state.totalPrice - (event.product.price * event.product.quantity);

  emit(ProductState(mainItems: updatedItems, totalPrice: updatedTotalPrice));
}


  void _getTotalPrice(Emitter<ProductState> emit) {
    double totalPrice = 0.0;

    for (var element in state.mainItems) {
      if (element.cart) {
        totalPrice += element.quantity * element.price;
      }
    }
    emit(ProductState(mainItems: state.mainItems, totalPrice: totalPrice));
  }

  get getCartList => state.mainItems.where((element) => element.cart).toList();

  get getFavoriteList =>
      state.mainItems.where((element) => element.isFavorite).toList();
}
