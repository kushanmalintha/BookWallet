import 'package:book_wallert/functions/global_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_wallert/controllers/GroupController.dart';
import 'package:book_wallert/colors.dart';

class Screen6 extends StatelessWidget {
  const Screen6({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController groupNameController = TextEditingController();
    final TextEditingController groupDescriptionController = TextEditingController();

    final int userId = globalUser!.userId;

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
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Create Group Button
                      ElevatedButton(
                        onPressed: () async {
                          final groupName = groupNameController.text.trim();
                          final groupDescription = groupDescriptionController.text.trim();
                          const groupImageUrl = 'http://example.com/image.png'; // Replace with actual image URL

                          if (groupName.isNotEmpty && groupDescription.isNotEmpty) {
                            await context.read<GroupController>().createGroup(
                              groupName,
                              groupDescription,
                              groupImageUrl,
                              userId,
                            );
                          } else {
                            // Show error if fields are empty
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Please fill in all fields')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.selectedItemColor,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: const Text('Create Group'),
                      ),

                      // Cancel Button
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.nonSelectedItemColor,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: const Text('Cancel'),
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
