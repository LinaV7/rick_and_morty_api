import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/provider/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Light Theme'),
            leading: const Icon(Icons.light_mode),
            onTap: () {
              themeProvider.setThemeMode(ThemeMode.light);
            },
          ),
          ListTile(
            title: const Text('Dark Theme'),
            leading: const Icon(Icons.dark_mode),
            onTap: () {
              themeProvider.setThemeMode(ThemeMode.dark);
            },
          ),
          ListTile(
            title: const Text('System Theme'),
            leading: const Icon(Icons.settings),
            onTap: () {
              themeProvider.setThemeMode(ThemeMode.system);
            },
          ),
        ],
      ),
    );
  }
}
