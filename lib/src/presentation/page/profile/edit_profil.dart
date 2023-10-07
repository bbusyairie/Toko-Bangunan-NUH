import 'package:flutter/material.dart';
import 'package:toko_bangunan_nuh/core/app_color.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColor.lightWhite),
        backgroundColor: AppColor
            .lightPurple, // Warna latar belakang Appbar berubah menjadi biru
        title: Text('Edit Profile',
            style: TextStyle(
                color: Colors.white)), // Judul Appbar menjadi "Edit Profile"
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Center(
              child: CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage('assets/images/profile_pic.png'),
              ),
            ),
            SizedBox(height: 4),
            Center(
              child: TextButton(
                onPressed: () {
                  // TODO: Implement logic to change profile picture
                  _buttomSheet(context);
                },
                child: Text(
                  'Ubah Foto',
                  style: TextStyle(
                    color: AppColor.lightPurple,
                    fontSize: 20
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Edit Profile',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // Add your form fields here
          ],
        ),
      ),
    );
  }

  Future<dynamic> _buttomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo),
                title: Text('Ambil dari Galeri'),
                onTap: () {
                  // TODO: Implement logic to select image from gallery
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Ambil dari Kamera'),
                onTap: () {
                  // TODO: Implement logic to capture image from camera
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Hapus Foto'),
                onTap: () {
                  // TODO: Implement logic to delete profile picture
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
