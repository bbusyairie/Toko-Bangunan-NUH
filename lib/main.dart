import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toko_bangunan_nuh/src/business_logic/product_bloc.dart';
import 'package:toko_bangunan_nuh/src/data/repository/repository.dart';
import 'package:toko_bangunan_nuh/src/presentation/page/auth/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   
    return RepositoryProvider<Repository>(
      
      create: (context) => Repository(),
      child: BlocProvider<ProductBloc>(
        create:(context) => ProductBloc(repository: context.read()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Toko Bangunan Nuh',
          theme: ThemeData(
           
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const LoginPage(),
        ),
      ),
    );
  }
}

