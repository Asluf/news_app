import 'package:flutter/material.dart';
import 'package:news_app/screens/dashboard_screen.dart';
import 'package:news_app/themes/themes.dart';
import 'package:news_app/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'News',
            debugShowCheckedModeBanner: false,
            theme: themeProvider.themeData,
            darkTheme: darkModeTheme,
            themeMode: themeProvider.themeMode,
            home: const DashboardScreen(),
          );
        },
      ),
    );
  }
}
