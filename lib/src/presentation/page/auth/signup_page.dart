import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toko_bangunan_nuh/src/presentation/page/home/dashboard.dart';
import 'package:toko_bangunan_nuh/src/presentation/page/auth/login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>
    with AutomaticKeepAliveClientMixin {
      bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController usernameController = TextEditingController();

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
        body: SingleChildScrollView(
          child: SizedBox(
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
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16.0),
                                      child: TextFormField(
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.next,
                                        cursorColor: const Color(0xFF6F35A5),
                                        controller: usernameController,
                                        decoration: const InputDecoration(
                                          hintText: "Username",
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Icon(Icons.person),
                                          ),
                                        ),
                                      ),
                                    ),
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
                                      tag: "signUp_button",
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          final authResult = await FirebaseAuth
                                              .instance
                                              .createUserWithEmailAndPassword(
                                            email: emailController.text,
                                            password: passwordController.text,
                                          );
                                          
                                          final currentContext = context;
                                          if (authResult.user != null) {
                                            final uid = authResult.user!.uid;
                                            await FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(emailController.text)
                                                .set({
                                              'uid': uid,
                                              'email': emailController.text,
                                              'displayName':
                                                  usernameController.text,
                                            });
                                            Navigator.push(
                                              currentContext,
                                              MaterialPageRoute(
                                                  builder: (_) => Dashboard()),
                                            );
                                          }
                                        },
                                        child: Text(
                                          "Daftar".toUpperCase(),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        const Text(
                                          "Sudah punya akun ? ",
                                          style: TextStyle(
                                              color: Color(0xFF6F35A5)),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return LoginPage();
                                                },
                                              ),
                                            );
                                          },
                                          child: const Text(
                                            "Masuk",
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
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
