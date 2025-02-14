import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:floor/floor.dart';
import 'package:news_app_clean_architecture/features/news/domain/entities/article.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'dao/article_dao.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [ArticleEntity])
abstract class AppDatabase extends FloorDatabase {
  ArticleDao get articleDao;
}
