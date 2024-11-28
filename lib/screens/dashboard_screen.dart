import 'package:flutter/material.dart';
import 'package:news_app/screens/home_page.dart';
import 'package:news_app/screens/search_screen.dart';
import 'package:news_app/screens/saved_screen.dart';
import 'package:news_app/screens/category_selection_screen.dart';
import 'package:news_app/screens/setting.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  String _title = 'Home';

  final List<Widget> _screens = [
    const HomePage(),
    const SearchScreen(),
    const SavedScreen(),
    const CategorySelectionScreen(),
    const Setting(),
  ];
  final List<String> _titles = [
    'Home',
    'Search',
    'Saved',
    'Categories',
    'Setting'
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _title = _titles[index];
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(_title),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
        ),
      ),
      body: _screens[_selectedIndex],
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 85,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                child: const Text(
                  'News',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () => _onItemTapped(0),
            ),
            ListTile(
              title: const Text('Search'),
              onTap: () => _onItemTapped(1),
            ),
            ListTile(
              title: const Text('Saved'),
              onTap: () => _onItemTapped(2),
            ),
            ListTile(
              title: const Text('Categories'),
              onTap: () => _onItemTapped(3),
            ),
            ListTile(
              title: const Text('Setting'),
              onTap: () => _onItemTapped(4),
            ),
          ],
        ),
      ),
    );
  }
}
