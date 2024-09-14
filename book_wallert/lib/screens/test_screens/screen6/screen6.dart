import 'package:book_wallert/controllers/group_controller.dart';
import 'package:book_wallert/widgets/buttons/custom_button1.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_wallert/colors.dart';

class Screen6 extends StatelessWidget {
  const Screen6({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController groupNameController = TextEditingController();
    final TextEditingController groupDescriptionController =
        TextEditingController();

    return Scaffold(
      backgroundColor: MyColors.bgColor,
      appBar: AppBar(
        title: const Text(
          'Create Group',
          style: TextStyle(color: MyColors.textColor),
        ),
        backgroundColor: MyColors.navigationBarColor,
      ),
      body: ChangeNotifierProvider(
        create: (_) => GroupController(),
        child: Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Group Image
                  GestureDetector(
                    onTap: () {
                      // Handle image selection
                    },
                    child: Center(
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          color: MyColors.panelColor,
                          borderRadius: BorderRadius.circular(75),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: MyColors.text2Color,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Group Name
                  TextField(
                    controller: groupNameController,
                    style: const TextStyle(color: MyColors.textColor),
                    decoration: InputDecoration(
                      labelText: 'Group Name',
                      labelStyle: const TextStyle(color: MyColors.text2Color),
                      filled: true,
                      fillColor: MyColors.panelColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: MyColors
                              .selectedItemColor, // Change this to your desired focused border color
                          width:
                              2.0, // Optional: Increase the width when focused
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Group Description
                  TextField(
                    controller: groupDescriptionController,
                    maxLines: 3,
                    style: const TextStyle(color: MyColors.textColor),
                    decoration: InputDecoration(
                      labelText: 'Group Description',
                      labelStyle: const TextStyle(color: MyColors.text2Color),
                      filled: true,
                      fillColor: MyColors.panelColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: MyColors
                              .selectedItemColor, // Change this to your desired focused border color
                          width:
                              2.0, // Optional: Increase the width when focused
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Create Group Button
                      CustomButton1(
                        text: 'Create Group',
                        horizontalSpace:
                            35, // Adjusted to match your original button's padding
                        verticalSpace:
                            10, // Adjusted to match your original button's padding
                        textSize:
                            15, // Adjusted to match your original button's font size
                        backgroundColor: MyColors.selectedItemColor,
                        press: () async {
                          final groupName = groupNameController.text.trim();
                          final groupDescription =
                              groupDescriptionController.text.trim();
                          const groupImageUrl =
                              'http://example.com/image.png'; // Replace with actual image URL
                          Navigator.of(context).pop();
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Group created successfully'),
                              ),
                            );
                          }

                          if (groupName.isNotEmpty &&
                              groupDescription.isNotEmpty) {
                            await context.read<GroupController>().createGroup(
                                groupName, groupDescription, groupImageUrl);
                          } else {
                            // Show error if fields are empty
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please fill in all fields')),
                            );
                          }
                        },
                      ),

                      // Cancel Button
                      CustomButton1(
                        text: 'Cancel',
                        horizontalSpace:
                            30, // Adjusted to match your original button's padding
                        verticalSpace:
                            10, // Adjusted to match your original button's padding
                        textSize:
                            15, // Adjusted to match your original button's font size
                        backgroundColor: MyColors.nonSelectedItemColor,
                        press: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
