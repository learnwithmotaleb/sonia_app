import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        automaticallyImplyLeading: false,

      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          _buildSectionTitle("Account"),
          _buildSettingTile(
            icon: Icons.person,
            title: "Edit Profile",
            onTap: () {
              // Navigate to profile edit page
            },
          ),
          _buildSettingTile(
            icon: Icons.lock,
            title: "Change Password",
            onTap: () {
              // Navigate to change password page
            },
          ),

          const Divider(height: 40),

          _buildSectionTitle("Preferences"),
          _buildSettingTile(
            icon: Icons.language,
            title: "Language",
            subtitle: "বাংলা",
            onTap: () {
              // Navigate to language selection
            },
          ),
          _buildSettingTile(
            icon: Icons.brightness_6,
            title: "Theme",
            subtitle: "Light",
            onTap: () {
              // Navigate to theme setting
            },
          ),
          _buildSettingTile(
            icon: Icons.notifications,
            title: "Notifications",
            onTap: () {
              // Navigate to notification settings
            },
          ),

          const Divider(height: 40),

          _buildSectionTitle("Support"),
          _buildSettingTile(
            icon: Icons.help_outline,
            title: "Help & FAQ",
            onTap: () {},
          ),
          _buildSettingTile(
            icon: Icons.contact_support,
            title: "Contact Support",
            onTap: () {},
          ),

          const Divider(height: 40),

          _buildSectionTitle("Others"),
          _buildSettingTile(
            icon: Icons.info,
            title: "About",
            onTap: () {},
          ),
          _buildSettingTile(
            icon: Icons.logout,
            title: "Logout",
            onTap: () {
              // logout function
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
