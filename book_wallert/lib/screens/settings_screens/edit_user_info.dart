import 'package:book_wallert/controllers/user_controller.dart';
import 'package:book_wallert/screens/settings_screens/setting_screen.dart';
import 'package:book_wallert/textbox/custom_textbox1.dart';
import 'package:book_wallert/widgets/buttons/custom_button1.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';

class EditUserInfo extends StatelessWidget {
  final UserController _userController = UserController();
  EditUserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false, // to remove the top left back button
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
              const Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          'https://example.com/profile_image.jpg'), // Replace with actual image URL
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: MyColors.selectedItemColor,
                        child: Icon(
                          Icons.edit,
                          size: 15,
                          color: MyColors.textColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              CustomTextBox1(
                lableText: "Username",
                type: TextInputType.text,
                controller: _userController.usernameController,
              ),
              const SizedBox(height: 20),
              CustomTextBox1(
                  lableText: 'Email',
                  type: TextInputType.emailAddress,
                  controller: _userController.emailController),
              const SizedBox(height: 20),
              CustomTextBox1(
                  lableText: 'Password',
                  type: TextInputType.visiblePassword,
                  isPassword: true,
                  controller: _userController.passwordController),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Settingscreen()),
                      );
                    },
                  ),
                  CustomButton1(
                    text: 'SAVE',
                    horizontalSpace: 40,
                    verticalSpace: 10,
                    textSize: 15,
                    backgroundColor: MyColors.selectedItemColor,
                    press: () => _userController.editUserDetails(context),
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
