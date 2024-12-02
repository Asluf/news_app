import 'package:path/path.dart';
import '../models/news_model.dart';
import 'package:sqflite/sqflite.dart';


class NewsDBService {
  static const _databaseName = "news.db";
  static const _databaseVersion = 1;
  static const table = 'news';

  static const columnId = 'id';
  static const columnSourceId = 'sourceId';
  static const columnSourceName = 'sourceName';
  static const columnTitle = 'title';
  static const columnDescription = 'description';
  static const columnUrl = 'url';
  static const columnUrlToImage = 'urlToImage';
  static const columnPublishedAt = 'publishedAt';
  static const columnContent = 'content';

  NewsDBService._privateConstructor();
  static final NewsDBService instance = NewsDBService._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnSourceId TEXT,
        $columnSourceName TEXT,
        $columnTitle TEXT UNIQUE,
        $columnDescription TEXT,
        $columnUrl TEXT,
        $columnUrlToImage TEXT,
        $columnPublishedAt TEXT,
        $columnContent TEXT
      )
    ''');
  }

  Future<int> insert(NewsArticle article) async {
    Database db = await instance.database;
    return await db.insert(table, article.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> delete(String title) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnTitle = ?', whereArgs: [title]);
  }

  Future<List<NewsArticle>> getSavedArticles() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(table);
    return List.generate(maps.length, (i) {
      return NewsArticle.fromMap(maps[i]);
    });
  }

  Future<bool> isArticleSaved(String title) async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(table, where: '$columnTitle = ?', whereArgs: [title]);
    return maps.isNotEmpty;
  }
}

extension NewsArticleExtension on NewsArticle {
  Map<String, dynamic> toMap() {
    return {
      'sourceId': source.id,
      'sourceName': source.name,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
    };
  }

  static NewsArticle fromMap(Map<String, dynamic> map) {
    return NewsArticle(
      source: Source(id: map['sourceId'], name: map['sourceName']),
      title: map['title'],
      description: map['description'],
      url: map['url'],
      urlToImage: map['urlToImage'],
      publishedAt: map['publishedAt'],
      content: map['content'],
    );
  }
}