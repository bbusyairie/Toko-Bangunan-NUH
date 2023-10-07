import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toko_bangunan_nuh/core/app_color.dart';
import 'package:toko_bangunan_nuh/src/presentation/page/auth/login_page.dart';
import 'package:toko_bangunan_nuh/src/presentation/page/profile/edit_profil.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userEmail = user?.email ?? 'No email';

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(240),
        child: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Profile',
              style: TextStyle(
                color: AppColor.lightWhite,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: AppColor.lightPurple,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 24, left: 16, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage:
                        AssetImage('assets/images/profile_pic.png'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text(
              'Name',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user?.email ?? '')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final userData = snapshot.data?.data();
                  final username = userData?['displayName'] ?? '';
                  return Text(
                    username,
                    style: const TextStyle(fontSize: 16),
                  );
                } else if (snapshot.hasError) {
                  return const Text('Error');
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            const SizedBox(height: 8),
            const Text(
              'Email',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              userEmail,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            // const Text(
            //   'Phone',
            //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            // ),
            // const Text(
            //   '-',
            //   style: TextStyle(fontSize: 16),
            // ),
            // const SizedBox(height: 8),
            // const Text(
            //   'Address',
            //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            // ),
            // const Text(
            //   '-',
            //   style: TextStyle(fontSize: 16),
            // ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final currentContext = context;
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pushAndRemoveUntil(
                    currentContext,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
                  );
                }).catchError((error) {
                  // Handle sign out error
                });
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
