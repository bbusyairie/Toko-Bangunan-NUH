import 'package:flutter/material.dart';
import 'package:toko_bangunan_nuh/core/app_color.dart';

const h1Style = TextStyle(
    fontSize: 60,
    color: Colors.black,
    fontFamily: "Poppins",
    height: 1.4,
    fontWeight: FontWeight.w900);

const hargaStyle = TextStyle(
    fontSize: 15,
    color: Color.fromARGB(255, 147, 29, 220),
    fontFamily: "Poppins",
    fontWeight: FontWeight.w600);

const h2Style = TextStyle(
    fontSize: 22,
    color: AppColor.lightPurple,
    fontFamily: "Poppins",
    fontWeight: FontWeight.w600);

const h2StyleW = TextStyle(
    fontSize: 25,
    color: Colors.white,
    fontFamily: "Poppins",
    fontWeight: FontWeight.w600);

const h3Style = TextStyle(
    fontFamily: "Poppins",
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: Colors.black);

const h3StyleW = TextStyle(
    fontFamily: "Poppins",
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: Colors.white);

const namaProduct = TextStyle( // style Font nama barang di dashboard
    fontFamily: "Poppins",
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.black);

const h5Style = TextStyle(
    fontFamily: "Poppins",
    fontSize: 20,
    fontWeight: FontWeight.w300,
    color: Colors.black);

final textFieldStyle = OutlineInputBorder(
  borderRadius: BorderRadius.circular(15),
  borderSide: const BorderSide(color: Colors.black, width: 2.0),
);
