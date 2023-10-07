import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:toko_bangunan_nuh/src/presentation/page/home/home_page.dart';

class OrderPage extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final String address;
  final String city;
  final String postalCode;
  final double totalPayment;

  const OrderPage({
    Key? key,
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.city,
    required this.postalCode,
    required this.totalPayment,
  }) : super(key: key);

  void openWhatsApp() async {
    String phoneNumber = '+628156743627';
    String message = 'Halo, saya ingin melakukan pembayaran pesanan saya.';

    final Uri _url = Uri.parse(
        'https://wa.me/$phoneNumber/?text=${Uri.encodeFull(message)}');

    Future<void> _launchUrl() async {
      if (!await launch(_url.toString())) {
        throw Exception('Could not launch $_url');
      }
    }

    _launchUrl();
  }

  void navigateToHome(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => ListProductPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesanan'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detail Pesanan',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('Name: $name'),
            Text('Phone Number: $phoneNumber'),
            Text('Address: $address'),
            Text('City: $city'),
            Text('Postal Code: $postalCode'),
            const SizedBox(height: 32),
            const Text(
              'Order Summary',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            totalPayment > 0
                ? const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total Item: 0'),
                      Text('Subtotal: 0'),
                      Text('Ongkir: Gratis'),
                      Text('Total Payment: 0'),
                    ],
                  )
                : Text('Empty'),
            SizedBox(height: 32),
            Text(
              'Pesanan telah berhasil, silahkan hubungi Admin melalui WhatsApp untuk melanjutkan pembayaran',
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: openWhatsApp,
              child: const Text(
                'Hubungi WA Admin: +628156743627',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () => navigateToHome(context),
              child: const Text(
                'Kembali ke Beranda',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
