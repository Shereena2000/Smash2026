import 'package:flutter/material.dart';
import 'package:smash_music_app/screens/setting_components/about_us.dart';
import 'package:smash_music_app/screens/setting_components/privacy_policy_screen.dart';
import 'package:smash_music_app/screens/setting_components/t_and_c_screen.dart';
import 'package:smash_music_app/screens/setting_components/theme_selection_screen.dart';
import 'package:smash_music_app/widgets/all_color.dart';
import 'package:smash_music_app/widgets/back_button.dart';
import 'package:smash_music_app/widgets/constant.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundColor(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const PreviousButton(),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Settings',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 30),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ThemeSelectionScreen()));
                  },
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.palette,
                    color: Colors.white,
                    size: 30,
                  ),
                  title: const Text(
                    "Theme",
                    style: commontext,
                  ),
                  trailing: forwardIcon,
                ),
                ListTile(
                  onTap: () {
                    diougeabout(context);
                  },
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.info,
                    color: Colors.white,
                    size: 30,
                  ),
                  title: const Text(
                    "About us",
                    style: commontext,
                  ),
                  trailing: forwardIcon,
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TandCScreen()));
                  },
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.description,
                    color: Colors.white,
                    size: 30,
                  ),
                  title: const Text(
                    "Terms & Conditions",
                    style: commontext,
                  ),
                  trailing: forwardIcon,
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PrivacyPolicyScreen()));
                  },
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.shield,
                    color: Colors.white,
                    size: 30,
                  ),
                  title: const Text(
                    "Privacy Policy",
                    style: commontext,
                  ),
                  trailing: forwardIcon,
                ),
                const Spacer(),
                Center(
                  child: Text(
                    'version 1.0.0',
                    style: TextStyle(
                      color: itembgcolor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
