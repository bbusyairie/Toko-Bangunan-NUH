import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:toko_bangunan_nuh/core/app_color.dart';

import 'package:toko_bangunan_nuh/src/data/model/product.dart';
import 'package:toko_bangunan_nuh/src/presentation/page/order/order_page.dart';

class OrderConfirmationPage extends StatefulWidget {
  final List<Product> productItems;
  final double totalPrice;

  const OrderConfirmationPage({
    Key? key,
    required this.productItems,
    required this.totalPrice,
  }) : super(key: key);

  @override
  _OrderConfirmationPageState createState() => _OrderConfirmationPageState();
}

class _OrderConfirmationPageState extends State<OrderConfirmationPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();

void createOrder() {
  String name = _nameController.text;
  String phoneNumber = _phoneNumberController.text;
  String address = _addressController.text;
  String city = _cityController.text;
  String postalCode = _postalCodeController.text;

  if (name.isNotEmpty &&
      phoneNumber.isNotEmpty &&
      address.isNotEmpty &&
      city.isNotEmpty &&
      postalCode.isNotEmpty) {
    // Show loading state
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // Simpan data pesanan ke Firestore
    FirebaseFirestore.instance.collection('orders').add({
      'customer': name,
      'address': address,
      'city': city,
      'phone': phoneNumber,
      'postCode': postalCode,
      'totalAmount': widget.totalPrice,
      'time': FieldValue.serverTimestamp(),
    }).then((value) {
      // Hide loading state
      Navigator.pop(context);

      // Show success notification
      Fluttertoast.showToast(
        msg: 'Pesanan berhasil ditambahkan',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );

      // Clear the cart
      widget.productItems.clear();

      // Navigate to order page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderPage(
            name: name,
            phoneNumber: phoneNumber,
            address: address,
            city: city,
            postalCode: postalCode,
            totalPayment: widget.totalPrice,
          ),
        ),
      );
    }).catchError((error) {
      // Hide loading state
      Navigator.pop(context);

      // Show error notification
      Fluttertoast.showToast(
        msg: 'Terjadi kesalahan. Pesanan gagal ditambahkan',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    });
  } else {
    Fluttertoast.showToast(
      msg: 'Harap lengkapi semua data',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konfirmasi Pesanan'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Informasi Pesanan',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text('Nama Lengkap'),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: 'Masukkan Nama Lengkap',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Nomor Telepon'),
            TextField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(
                hintText: 'Masukkan Nomor Telepon',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Alamat Lengkap'),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(
                hintText: 'Masukkan Alamat',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Kota/Kabupaten'),
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                hintText: 'Masukkan Nama Kota',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Kode Pos'),
            TextField(
              controller: _postalCodeController,
              decoration: const InputDecoration(
                hintText: 'Masukkan Kode Pos',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 154, 154, 154).withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset:
                        Offset(0, 3), // Mengatur offset untuk efek bayangan 3D
                  ),
                ],
                color: const Color.fromARGB(255, 241, 225, 255), // Gunakan nilai warna pastel ungu muda yang sesuai
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Order Summary',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColor.lightPurple),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Total Items: ${widget.productItems.length}',
                    style: const TextStyle(fontSize: 16, color: AppColor.lightPurple),
                  ),
                  Text(
                    'Subtotal: ${CurrencyFormat.convertToIdr(widget.totalPrice)}',
                    style: const TextStyle(fontSize: 16, color: AppColor.lightPurple),
                  ),
                  const Text(
                    'Ongkir: Gratis',
                    style: TextStyle(fontSize: 16, color: AppColor.lightPurple),
                  ),
                  Text(
                    'Total Pembayaran: ${CurrencyFormat.convertToIdr(widget.totalPrice)}',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColor.lightPurple),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: createOrder,
              style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.lightPurple, // Background color
            ),
              child: const Text('Konfirmasi Pesanan', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
