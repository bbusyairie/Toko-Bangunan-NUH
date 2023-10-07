part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class SearchEvent extends ProductEvent {
  final String searchText;

  const SearchEvent(this.searchText);
}


class IncreaseQuantityEvent extends ProductEvent {
  final Product product;
  const IncreaseQuantityEvent({required this.product});
  
  @override
  List<Object?> get props => [product];
}

class DecreaseQuantityEvent extends ProductEvent {
  final Product product;
  const DecreaseQuantityEvent({required this.product});

  @override
  List<Object?> get props => [product];
}

class AddToCartEvent extends ProductEvent {
  final Product product;
  final int index;

  const AddToCartEvent({required this.product, required this.index});

  @override
  List<Object?> get props => [product, index];
}

class AddToFavoriteEvent extends ProductEvent {
  final Product product;

  const AddToFavoriteEvent({required this.product});

  @override
  List<Object?> get props => [product];
}

class ClearCartEvent extends ProductEvent {
  const ClearCartEvent();

  @override
  List<Object?> get props => [];
}

class RemoveFromCartEvent extends ProductEvent {
  final Product product;

  const RemoveFromCartEvent({required this.product});
}