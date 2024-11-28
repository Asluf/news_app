import 'package:flutter/material.dart';
import 'package:news_app/providers/theme_provider.dart';
import 'package:news_app/screens/dashboard_screen.dart';
import 'package:news_app/themes/themes.dart';
import 'package:provider/provider.dart';

class ThemeChange extends StatefulWidget {
  const ThemeChange({super.key});

  @override
  State<ThemeChange> createState() => _ThemeChangeState();
}

class _ThemeChangeState extends State<ThemeChange> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Theme'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const DashboardScreen()),
              (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: oceanBreezeTheme.primaryColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            title: const Text('Ocean Breeze'),
            onTap: () {
              themeProvider.setTheme(oceanBreezeTheme, ThemeMode.light);
            },
          ),
          ListTile(
            leading: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: lavenderDreamTheme.primaryColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            title: const Text('Lavender Dream'),
            onTap: () {
              themeProvider.setTheme(lavenderDreamTheme, ThemeMode.light);
            },
          ),
          ListTile(
            leading: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: forestGreenTheme.primaryColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            title: const Text('Forest Green'),
            onTap: () {
              themeProvider.setTheme(forestGreenTheme, ThemeMode.light);
            },
          ),
          ListTile(
            leading: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: sunnyCitrusTheme.primaryColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            title: const Text('Sunny Citrus'),
            onTap: () {
              themeProvider.setTheme(sunnyCitrusTheme, ThemeMode.light);
            },
          ),
          ListTile(
            leading: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: darkModeTheme.primaryColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            title: const Text('Dark'),
            onTap: () {
              themeProvider.setTheme(darkModeTheme, ThemeMode.dark);
            },
          ),
        ],
      ),
    );
  }
}
