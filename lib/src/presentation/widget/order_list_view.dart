import 'package:flutter/material.dart';
import 'package:toko_bangunan_nuh/core/app_color.dart';
import 'package:toko_bangunan_nuh/src/data/model/product.dart';

class OrderListView extends StatefulWidget {
  final List<Product> productItems;
  final double totalPrice;

  const OrderListView({
    Key? key,
    required this.productItems,
    required this.totalPrice,
  }) : super(key: key);

  @override
  _OrderListViewState createState() => _OrderListViewState();
}

class _OrderListViewState extends State<OrderListView> {
  List<Product> filteredProductItems = [];

  @override
  void initState() {
    super.initState();
    filteredProductItems = widget.productItems;
  }

  void filterProductItems(String keyword) {
    setState(() {
      filteredProductItems = widget.productItems
          .where((product) =>
              product.title.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Cari produk...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            onChanged: filterProductItems,
          ),
        ),
        
        Expanded(
          child: ListView.builder(
            itemCount: filteredProductItems.length,
            itemBuilder: (context, index) {
              final product = filteredProductItems[index];
              return ListTile(
                leading: Image.asset(product.images[0]),
                title: Text(product.title),
                subtitle: Text('Quantity: ${product.quantity}'),
                trailing: Text(
                  CurrencyFormat.convertToIdr(product.price),
                  // '\$${product.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;

  const FilterButton({
    Key? key,
    required this.label,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Implement filter logic here
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColor.lightPurple : Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColor.lightPurple : Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
