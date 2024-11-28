import 'package:flutter/material.dart';
import 'package:news_app/screens/category_news_screen.dart';

class CategorySelectionScreen extends StatelessWidget {
  const CategorySelectionScreen({super.key});

  final List<String> categories = const [
    'Business',
    'Entertainment',
    'General',
    'Health',
    'Science',
    'Sports',
    'Technology',
    'World',
    'Politics',
    'Finance',
    'Travel',
    'Food',
    'Fashion',
    'Gaming',
    'Music',
    'Movies',
    'Books',
    'Art',
    'History',
    'Nature',
    'Weather',
    'Education',
    'Crime',
    'Religion',
    'Culture',
    'Environment',
    'Opinion',
    'Real Estate',
    'Automotive',
    'Jobs'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(categories[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CategoryNewsScreen(category: categories[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
