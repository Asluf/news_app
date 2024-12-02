import 'package:flutter/material.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/services/news_db_service.dart';
import 'news_detail.dart';

class NewsCard extends StatefulWidget {
  final NewsArticle article;
  final VoidCallback? onArticleRemoved;

  const NewsCard({super.key, required this.article, this.onArticleRemoved});

  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  bool isSaved = false;

  @override
  void initState() {
    super.initState();
    _checkIfSaved();
  }

  Future<void> _checkIfSaved() async {
    bool saved =
        await NewsDBService.instance.isArticleSaved(widget.article.title);
    setState(() {
      isSaved = saved;
    });
  }

  Future<void> _toggleSave() async {
    if (isSaved) {
      await NewsDBService.instance.delete(widget.article.title);
      if (widget.onArticleRemoved != null) {
        widget.onArticleRemoved!();
      }
    } else {
      await NewsDBService.instance.insert(widget.article);
    }
    setState(() {
      isSaved = !isSaved;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // if (widget.article.urlToImage.isNotEmpty)
          //   Image.network(widget.article.urlToImage),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.article.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.article.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                NewsDetail(article: widget.article),
                          ),
                        );
                      },
                      child: const Text('Read More'),
                    ),
                    IconButton(
                      icon: Icon(
                        isSaved ? Icons.bookmark : Icons.bookmark_border,
                        color: isSaved ? Colors.red : Colors.grey,
                      ),
                      onPressed: _toggleSave,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
