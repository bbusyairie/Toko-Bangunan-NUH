part of 'product_bloc.dart';

@immutable
class ProductState extends Equatable {
  final List<Product> mainItems;
  final double totalPrice;

  const ProductState.initial(List<Product> mainItems)
      : this(mainItems: mainItems);

  @override
  List<Object?> get props => [mainItems, totalPrice];

  const ProductState({
    required this.mainItems,
    this.totalPrice = 0.0,
  });

  ProductState copyWith({
    List<Product>? mainItems,
    double? totalPrice,
  }) {
    return ProductState(
      mainItems: mainItems ?? this.mainItems,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}
