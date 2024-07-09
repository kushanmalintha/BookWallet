import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:book_wallert/colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          //inactiveSwitchColor: Colors.grey,
          //activeSwitchColor: Colors.green,
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
                    Text('User Name'),
                  ],
                ),
                onPressed: (BuildContext context) {
                  Navigator.pushReplacementNamed(context, '/EditUserInfo');
                },
              ),
              SettingsTile(
                title: const Text('Phone number'),
                leading: const Icon(Icons.phone),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                title: const Text('Email'),
                leading: const Icon(Icons.email),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                title: const Text('Sign out'),
                leading: const Icon(Icons.exit_to_app),
                onPressed: (BuildContext context) {},
              ),
            ],
          ),
          SettingsSection(
            title: const Text('Common'),
            tiles: [
              SettingsTile(
                title: const Text('Language'),
                //subtitle: Text('English'),
                leading: const Icon(Icons.language),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                title: const Text('Environment'),
                //subtitle: Text('Production'),
                leading: const Icon(Icons.cloud_queue),
                onPressed: (BuildContext context) {},
              ),
            ],
          ),
          SettingsSection(
            title: const Text('Security'),
            tiles: [
              SettingsTile.switchTile(
                title: const Text('Enable Notifications'),
                leading: const Icon(Icons.notifications_active),
                //switchValue: true,
                onToggle: (bool value) {}, initialValue: null,
              ),
              SettingsTile.switchTile(
                title: const Text('Fingerprint Lock'),
                leading: const Icon(Icons.fingerprint),
                //switchValue: false,
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


