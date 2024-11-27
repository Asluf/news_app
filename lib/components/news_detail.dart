import 'package:flutter/material.dart';
import 'package:news_app/models/news_model.dart';

class NewsDetail extends StatelessWidget {
  final NewsArticle article;

  const NewsDetail({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    // Format the publishedAt date
    final DateTime publishedDate = DateTime.parse(article.publishedAt);

    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.urlToImage.isNotEmpty)
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(article.urlToImage),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            const SizedBox(height: 10),
            Text(
              article.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              publishedDate.toString(),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Text(article.description),
          ],
        ),
      ),
    );
  }
}
