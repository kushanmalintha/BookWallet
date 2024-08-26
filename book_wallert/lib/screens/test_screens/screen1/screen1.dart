import 'dart:io';
import 'package:flutter/material.dart';
import 'image_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:book_wallert/colors.dart';

class Screen1 extends StatefulWidget {
  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  File? _imageFile;
  final String _imageName = 'image3'; // Unique image name
  final picker = ImagePicker();
  final ImageController _imageController = ImageController();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_imageFile == null) return;
    await _imageController.uploadImage(_imageFile!, _imageName);
  }

  Future<ImageProvider> _fetchImage() async {
    try {
      final imageModel = await _imageController.fetchImage(_imageName);
      return MemoryImage(imageModel.image);
    } catch (e) {
      return AssetImage('assets/images/placeholder.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<ImageProvider>(
              future: _fetchImage(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError || !snapshot.hasData) {
                  return CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/placeholder.png'),
                    radius: 100,
                  );
                } else {
                  return CircleAvatar(
                    backgroundImage: snapshot.data!,
                    radius: 100,
                  );
                }
              },
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () async {
                await _pickImage();
                await _uploadImage();
              },
              style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  backgroundColor: MyColors.selectedItemColor),
              child: Text(
                'Upload',
                style: TextStyle(color: MyColors.bgColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
