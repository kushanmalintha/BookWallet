import 'package:book_wallert/controllers/token_controller.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:book_wallert/colors.dart';

class Settingscreen extends StatelessWidget {
  const Settingscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MyColors.navigationBarColor,
        title: const Text(
          'Settings',
          style: TextStyle(color: MyColors.titleColor),
        ),
      ),
      body: SettingsList(
        lightTheme: const SettingsThemeData(
          settingsListBackground: MyColors.bgColor,
          titleTextColor: MyColors.textColor,
          tileDescriptionTextColor: MyColors.textColor,
          leadingIconsColor: MyColors.textColor,
          trailingTextColor: MyColors.text2Color,
          settingsTileTextColor: MyColors.titleColor,
        ),
        sections: [
          SettingsSection(
            title: const Text('Account'),
            tiles: [
              SettingsTile(
                title: const Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://example.com/profile_image.jpg'), // Replace with actual image URL
                    ),
                    SizedBox(width: 10),
                    Text('Edit User Details'),
                  ],
                ),
                onPressed: (BuildContext context) {
                  Navigator.pushNamed(context, '/EditUserInfo');
                },
              ),
              SettingsTile(
                title: const Text('Sign out'),
                leading: const Icon(Icons.exit_to_app),
                onPressed: (BuildContext context) {
                  removeToken(); // remove access token so user has to login again
                  Navigator.pushNamed(context, '/LoginScreen');
                },
              ),
            ],
          ),
          SettingsSection(
            title: const Text('Common'),
            tiles: [
              SettingsTile(
                title: const Text('Language'),
                leading: const Icon(Icons.language),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                title: const Text('Environment'),
                leading: const Icon(Icons.cloud_queue),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                title: const Text('Group Create'),
                leading: const Icon(Icons.notifications),
                onPressed: (BuildContext context) {
                  Navigator.pushNamed(context, '/GroupCreate'); // Navigate to notification screen
                },
              ),
            ],
          ),
          SettingsSection(
            title: const Text('Security'),
            tiles: [
              SettingsTile.switchTile(
                title: const Text('Enable Notifications'),
                leading: const Icon(Icons.notifications_active),
                onToggle: (bool value) {}, initialValue: null,
              ),
              SettingsTile.switchTile(
                title: const Text('Fingerprint Lock'),
                leading: const Icon(Icons.fingerprint),
                onToggle: (bool value) {}, initialValue: null,
              ),
            ],
          ),
          SettingsSection(
            title: const Text('Miscellaneous'),
            tiles: [
              SettingsTile(
                title: const Text('Terms of Service'),
                leading: const Icon(Icons.description),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                title: const Text('Privacy Policy'),
                leading: const Icon(Icons.lock),
                onPressed: (BuildContext context) {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
