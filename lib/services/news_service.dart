import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/models/news_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsService {
  final String apiKey = 'd6110a04e36249cebde211d9240582eb';
  final String baseUrl = 'https://newsapi.org/v2';

  Future<String> _getSelectedCountry() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('selectedCountry') ?? 'us';
  }

  Future<List<NewsArticle>> fetchNews(
      {String country = 'us', String type = ''}) async {
    final country = await _getSelectedCountry();
    http.Response response;

    if (type == 'headlines') {
      response = await http.get(
        Uri.parse('$baseUrl/top-headlines?country=$country&apiKey=$apiKey'),
      );
    } else {
      response = await http.get(
        Uri.parse('$baseUrl/everything?q=$type&apiKey=$apiKey'),
      );
    }

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> articles = data['articles'];
      return articles.map((json) => NewsArticle.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<List<NewsArticle>> searchNews({String searchQuery = ''}) async {
    http.Response response;
    response = await http.get(
      Uri.parse('$baseUrl/everything?q=$searchQuery&apiKey=$apiKey'),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> articles = data['articles'];
      return articles.map((json) => NewsArticle.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
