import 'package:flutter/material.dart';
import 'package:news_app/screens/dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectCountry extends StatefulWidget {
  const SelectCountry({super.key});

  @override
  State<SelectCountry> createState() => _SelectCountryState();
}

class _SelectCountryState extends State<SelectCountry> {
  String? _selectedCountry;

  final Map<String, String> _countries = {
  'United States': 'us',
  'United Kingdom': 'gb',
  'India': 'in',
  'Sri Lanka': 'lk',
  'Canada': 'ca',
  'Australia': 'au',
  'Germany': 'de',
  'France': 'fr',
  'Japan': 'jp',
  'China': 'cn',
  'Russia': 'ru',
  'Brazil': 'br',
  'South Africa': 'za',
  'Italy': 'it',
  'Spain': 'es',
  'Mexico': 'mx',
  'South Korea': 'kr',
  'Indonesia': 'id',
  'Saudi Arabia': 'sa',
  'Turkey': 'tr',
  'Netherlands': 'nl',
  'Sweden': 'se',
  'Switzerland': 'ch',
  'New Zealand': 'nz',
  'Singapore': 'sg',
};

  Future<void> _saveSelectedCountry(String countryCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedCountry', countryCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Country'),
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
      body: ListView.builder(
        itemCount: _countries.length,
        itemBuilder: (context, index) {
          String countryName = _countries.keys.elementAt(index);
          String countryCode = _countries.values.elementAt(index);
          return ListTile(
            title: Text(countryName),
            onTap: () {
              setState(() {
                _selectedCountry = countryName;
              });
              _saveSelectedCountry(countryCode);
              Navigator.pop(context, countryCode);
            },
          );
        },
      ),
    );
  }
}
