import 'dart:io';
import 'package:book_wallert/controllers/image_controller.dart';
import 'package:book_wallert/controllers/user_controller.dart';
import 'package:book_wallert/functions/global_user_provider.dart';
import 'package:book_wallert/textbox/custom_textbox1.dart';
import 'package:book_wallert/widgets/buttons/custom_button1.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';
import 'package:image_picker/image_picker.dart';

class EditUserInfo extends StatefulWidget {
  const EditUserInfo({super.key});

  @override
  _EditUserInfoState createState() => _EditUserInfoState();
}

class _EditUserInfoState extends State<EditUserInfo> {
  final UserController _userController = UserController();
  File? _imageFile;
  final String _imageName =
      globalUser!.imageUrl.substring(globalUser!.imageUrl.lastIndexOf('/') + 1);
  final picker = ImagePicker();
  final ImageController _imageController = ImageController();

  @override
  void initState() {
    super.initState();
    _userController.usernameController.text = globalUser!.username;
    _userController.emailController.text = globalUser!.email;
    _userController.descriptionController.text = globalUser!.description;
  }

  Future<void> _pickImage() async {
    // print(globalUser!.imageUrl.substring(globalUser!.imageUrl.lastIndexOf('/') + 1));
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_imageFile == null) return;
    await _imageController.uploadImageController(_imageFile!, _imageName);
  }

  Future<void> _deleteImage() async {
    await _imageController
        .deleteImageController(_imageName); // Delete current image
  }

  void _handleSave(BuildContext context) async {
    if (_imageFile != null) {
      await _deleteImage();
      await _uploadImage();
    }
    _userController.editUserDetails(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MyColors.navigationBarColor,
        title: const Text(
          'Edit User Profile',
          style: TextStyle(color: MyColors.titleColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: _imageFile != null
                          ? FileImage(_imageFile!)
                          : NetworkImage(globalUser!.imageUrl),
                      foregroundColor: MyColors.textColor,
                      radius: 60,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () async {
                          await _pickImage();
                        },
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: MyColors.selectedItemColor,
                          child: Icon(Icons.edit, color: MyColors.textColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              CustomTextBox1(
                text: globalUser!.username,
                lableText: "Username",
                type: TextInputType.text,
                controller: _userController.usernameController,
              ),
              const SizedBox(height: 20),
              CustomTextBox1(
                text: globalUser!.email,
                lableText: 'Email',
                type: TextInputType.emailAddress,
                controller: _userController.emailController,
              ),
              const SizedBox(height: 20),
              CustomTextBox1(
                lableText: 'Password',
                type: TextInputType.visiblePassword,
                isPassword: true,
                controller: _userController.passwordController,
              ),
              const SizedBox(height: 20),
              CustomTextBox1(
                text: globalUser!.imageUrl,
                lableText: 'Description',
                type: TextInputType.text,
                isPassword: false,
                controller: _userController.descriptionController,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton1(
                    text: 'CANCEL',
                    horizontalSpace: 30,
                    verticalSpace: 10,
                    textSize: 15,
                    backgroundColor: MyColors.textColor,
                    press: () {
                      Navigator.pop(context);
                    },
                  ),
                  CustomButton1(
                    text: 'SAVE',
                    horizontalSpace: 40,
                    verticalSpace: 10,
                    textSize: 15,
                    backgroundColor: MyColors.selectedItemColor,
                    press: () => _handleSave(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
