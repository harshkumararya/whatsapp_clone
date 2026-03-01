import 'package:flutter/material.dart';
import 'package:whatsapp_clone/features/app/global/widgets/profile_widget.dart';
import 'package:whatsapp_clone/features/app/theme/style.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 65,
                  height: 65,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32.5),
                    child: profileWidget(),
                  ),
                ),

                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Username", style: TextStyle(fontSize: 15)),
                      Text(
                        "While true { code() }",
                        style: TextStyle(color: greyColor),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.qr_code_sharp, color: tabColor),
              ],
            ),
          ),
          SizedBox(height: 2),
          Divider(height: 2, color: greyColor.withValues(alpha: 0.4)),
          SizedBox(height: 10),
          _settingsItemWidget(
              title: "Account",
              description: "Security applications, change number",
              icon: Icons.key,
              onTap: () {}
          ),
          _settingsItemWidget(
              title: "Privacy",
              description: "Block contacts, disappearing messages",
              icon: Icons.lock,
              onTap: () {}
          ),
          _settingsItemWidget(
              title: "Chats",
              description: "Theme, wallpapers, chat history",
              icon: Icons.message,
              onTap: () {}
          ),
           _settingsItemWidget(
              title: "LogOut",
              description: "LogOut from whatsApp",
              icon: Icons.exit_to_app,
              onTap: () {}
          ),
        ],
      ),
    );
  }

  _settingsItemWidget({
    String? title,
    String? description,
    IconData? icon,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: Icon(icon, color: greyColor, size: 25),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("$title", style: const TextStyle(fontSize: 17)),
                const SizedBox(height: 3),
                Text("$description", style: const TextStyle(color: greyColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
