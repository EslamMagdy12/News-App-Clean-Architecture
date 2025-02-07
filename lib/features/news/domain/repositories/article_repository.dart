import 'package:dartz/dartz.dart';
import 'package:news_app_clean_architecture/core/resources/failure.dart';
import 'package:news_app_clean_architecture/features/news/domain/entities/article.dart';

/// An abstract repository that defines the contract for fetching and
/// manipulating articles from online and offline data sources.
abstract class ArticleRepository {
  /// Fetches articles from the online API.
  Future<List<ArticleEntity>> getArticles();

  /// Fetches articles stored locally.
  Future<List<ArticleEntity>> getLocalArticles();

  /// Inserts an [ArticleEntity] into offline storage.
  Future<void> insertArticle(ArticleEntity article);

  /// Deletes an [ArticleEntity] from offline storage.
  Future<void> deleteArticle(ArticleEntity article);
}
