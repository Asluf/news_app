import 'package:flutter/material.dart';
import 'package:news_app/models/news_model.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

class NewsDetail extends StatelessWidget {
  final NewsArticle article;

  const NewsDetail({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final DateTime publishedDate = DateTime.parse(article.publishedAt);
    final String formattedDate = timeago.format(publishedDate);

    Future<void> _launchUrl(Uri _url) async {
      if (!await launchUrl(_url)) {
        throw Exception('Could not launch $_url');
      }
    }

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
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    article.urlToImage,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey,
                        child: const Center(
                          child: Icon(
                            Icons.broken_image,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            const SizedBox(height: 10),
            Text(
              'Published by ${article.source.name}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              formattedDate,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              article.description,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            Text(article.content ?? ''),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final urlString = article.url;
                final url = Uri.parse(urlString);
                await _launchUrl(url);
              },
              child: Text('See more info'),
            ),
          ],
        ),
      ),
    );
  }
}
