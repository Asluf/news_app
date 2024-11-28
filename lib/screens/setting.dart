import 'package:flutter/material.dart';
import 'package:news_app/screens/theme_change.dart';
import 'package:news_app/screens/select_country.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  String? _selectedCountry;

  @override
  void initState() {
    super.initState();
    _loadSelectedCountry();
  }

  Future<void> _loadSelectedCountry() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedCountry = prefs.getString('selectedCountry') ?? 'us';
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            title: const Text('Select Your Country'),
            subtitle: Text(_selectedCountry ?? 'Not selected'),
            onTap: () async {
              final selectedCountry = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SelectCountry(),
                ),
              );
              if (selectedCountry != null) {
                setState(() {
                  _selectedCountry = selectedCountry;
                });
              }
            },
          ),
          ListTile(
            title: const Text('Change Theme'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ThemeChange(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}