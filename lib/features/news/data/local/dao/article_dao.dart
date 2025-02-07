import 'package:floor/floor.dart';
import 'package:news_app_clean_architecture/features/news/domain/entities/article.dart';

@dao
abstract class ArticleDao {
  @Query('SELECT * FROM articles')
  Future<List<ArticleEntity>> findAllArticles();

  @insert
  Future<void> insertArticle(ArticleEntity article);

  @Query('DELETE FROM articles WHERE url = :url')
  Future<void> deleteArticle(String url);
}
