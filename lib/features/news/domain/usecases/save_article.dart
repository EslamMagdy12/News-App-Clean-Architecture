import 'package:dartz/dartz.dart';
import 'package:news_app_clean_architecture/core/resources/failure.dart';
import 'package:news_app_clean_architecture/features/news/domain/entities/article.dart';
import 'package:news_app_clean_architecture/features/news/domain/repositories/article_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SaveArticleUsecase {
  final ArticleRepository _articleRepository;

  SaveArticleUsecase(this._articleRepository);

  Future<void> call(ArticleEntity input) async {
    // TODO: implement call
    return _articleRepository.insertArticle(input);
  }
}
