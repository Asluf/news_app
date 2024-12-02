import 'package:flutter/material.dart';
import 'package:news_app/components/news_card.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/services/news_db_service.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  _SavedScreenState createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  late Future<List<NewsArticle>> _savedArticles;

  @override
  void initState() {
    super.initState();
    _fetchSavedArticles();
  }

  void _fetchSavedArticles() {
    setState(() {
      _savedArticles = NewsDBService.instance.getSavedArticles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<NewsArticle>>(
        future: _savedArticles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading saved articles'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No saved articles'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return NewsCard(
                  article: snapshot.data![index],
                  onArticleRemoved: _fetchSavedArticles,
                );
              },
            );
          }
        },
      ),
    );
  }
}