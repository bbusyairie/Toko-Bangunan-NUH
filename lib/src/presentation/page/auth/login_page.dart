import 'package:flutter/material.dart';
import 'package:toko_bangunan_nuh/src/presentation/page/home/dashboard.dart';
import 'package:toko_bangunan_nuh/src/presentation/page/auth/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Terjadi kesalahan'),
                content: const Text('tidak ada koneksi internet'),
                actions: [
                  TextButton(
                      child: const Text("OK"),
                      onPressed: () {
                        Navigator.of(context).pop(); // Menutup dialog
                      })
                ],
              );
            });
      } else if (e.code == 'wrong-password') {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  title: const Text("Terjadi kesalahan"),
                  content: const Text(
                      'Password salah'), // Pesan kesalahan dari FirebaseAuthException
                  actions: [
                    TextButton(
                        child: const Text("OK"),
                        onPressed: () {
                          Navigator.of(context).pop(); // Menutup dialog
                        })
                  ]);
            });
      } else if (e.code == 'user-not-found') {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Terjadi kesalahan'),
                content: const Text('User tidak ditemukan'),
                actions: [
                  TextButton(
                      child: const Text("OK"),
                      onPressed: () {
                        Navigator.of(context).pop(); // Menutup dialog
                      })
                ],
              );
            });
      } else if (email == null) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Terjadi kesalahan'),
                content: const Text('Tolong masukkan email yang'),
                actions: [
                  TextButton(
                      child: const Text("OK"),
                      onPressed: () {
                        Navigator.of(context).pop(); // Menutup dialog
                      })
                ],
              );
            });
      }
      throw e; // Melempar FirebaseAuthException jika terjadi kesalahan
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: const Color(0xFF6F35A5),
        scaffoldBackgroundColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: const Color(0xFF6F35A5),
            shape: const StadiumBorder(),
            maximumSize: const Size(double.infinity, 56),
            minimumSize: const Size(double.infinity, 56),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFFF1E6FF),
          iconColor: Color(0xFF6F35A5),
          prefixIconColor: Color(0xFF6F35A5),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              SafeArea(
                child: Container(
                  alignment: Alignment.topRight,
                  child: const Column(
                    children: [
                      SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                ),
              ),
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: [
                          const Text(
                            "Selamat datang",
                            style: TextStyle(
                                color: Color(0xFF6F35A5),
                                fontWeight: FontWeight.bold,
                                fontSize: Checkbox.width),
                          ),
                          const SizedBox(height: 16.0 * 2),
                          Row(
                            children: [
                              const Spacer(),
                              Expanded(
                                flex: 2,
                                child: Image.asset(
                                  "assets/images/eco-logo.png",
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                          const SizedBox(height: 16.0 * 2),
                        ],
                      ),
                      Row(
                        children: [
                          const Spacer(),
                          Expanded(
                            flex: 8,
                            child: Form(
                              child: Column(
                                children: [
                                  // TEXTFIELD EMAIL
                                  TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    cursorColor: const Color(0xFF6F35A5),
                                    controller: emailController,
                                    decoration: const InputDecoration(
                                      hintText: "Email",
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Icon(Icons.mail),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    // TEXTFIELD PASSWORD
                                    padding: const EdgeInsets.only(top: 16.0),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.done,
                                      obscureText: _obscureText,
                                      cursorColor: const Color(0xFF6F35A5),
                                      controller: passwordController,
                                      decoration: InputDecoration(
                                        hintText: "Password",
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _obscureText = !_obscureText;
                                            });
                                          },
                                          child: Icon(
                                            _obscureText
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        prefixIcon: const Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Icon(Icons.lock),
                                        ),
                                      ),
                                    ),
                                  ),
                                 
                                  const SizedBox(height: 16.0),
                                  Hero(
                                    tag: "login_btn",
                                    child: ElevatedButton(
                                   
                                      onPressed: () async {
                                        UserCredential userCredential =
                                            await signInWithEmailAndPassword(
                                          emailController.text,
                                          passwordController.text,
                                        );
                                        if (userCredential != null) {
                                          // Login berhasil
                                          
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => Dashboard()),
                                          );
                                          // Lakukan navigasi ke halaman lain atau tampilkan pesan sukses
                                        } else {
                                          // Login gagal // Tampilkan pesan error
                                        }
                                      },

                                      // },
                                      child: Text(
                                        "Masuk".toUpperCase(),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      const Text(
                                        "Belum punya akun ? ",
                                        style:
                                            TextStyle(color: Color(0xFF6F35A5)),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return const SignUpPage();
                                              },
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          "Daftar",
                                          style: TextStyle(
                                            color: Color(0xFF6F35A5),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
