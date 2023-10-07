import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileImageWidget extends StatefulWidget {
  final double size;
  final Function(File) onImageSelected;

  const ProfileImageWidget({
    Key? key,
    required this.size,
    required this.onImageSelected,
  }) : super(key: key);

  @override
  _ProfileImageWidgetState createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {
  late File _image;

  Future<void> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        widget.onImageSelected(_image);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: getImage,
      child: CircleAvatar(
        // radius: widget.size / 2,
        // backgroundImage: _image != null ? FileImage(_image) : null,
        // child: _image == null
        //     ? Icon(
        //         Icons.camera_alt,
        //         size: widget.size / 2,
        //       )
        //     : null,
      ),
    );
  }
}