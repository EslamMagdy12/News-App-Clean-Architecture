import '../../../../domain/entities/article.dart';

abstract class OfflineDataSource {
  Future<List<ArticleEntity>> findAllArticles();

  Future<void> insertArticle(ArticleEntity article);

  Future<void> deleteArticle(String url);
}
