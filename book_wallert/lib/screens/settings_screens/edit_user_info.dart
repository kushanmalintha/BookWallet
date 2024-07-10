import 'package:book_wallert/buttons/custom_button1.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';

class EditUserInfo extends StatelessWidget {
  const EditUserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgColor,
      appBar: AppBar(
        backgroundColor: MyColors.navigationBarColor,
        title: const Text(
          'Account Details',
          style: TextStyle(color: MyColors.titleColor),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
          },
        ),
      ),
      body: Padding(
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
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                  labelText: 'Full Name',
                  labelStyle: TextStyle(color: MyColors.textColor)),
            ),
            const TextField(
              decoration: InputDecoration(
                  labelText: 'Email',
                  hintStyle: TextStyle(color: MyColors.text2Color),
                  suffixIcon: Icon(
                    Icons.email,
                  ),
                  labelStyle: TextStyle(color: MyColors.textColor)),
            ),
            const TextField(
              decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: Icon(Icons.visibility),
                  labelStyle: TextStyle(color: MyColors.textColor)),
              obscureText: true,
            ),
            const TextField(
              decoration: InputDecoration(
                  labelText: 'Phone Number',
                  labelStyle: TextStyle(color: MyColors.textColor)),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Colors.grey),
                  ),
                  onPressed: () {
                    // Handle cancel button press
                  },
                  child: const Text('CANCEL'),
                ),
                CustomButton1(text: 'SAVE', press: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
