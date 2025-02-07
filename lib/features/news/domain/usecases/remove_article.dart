import 'package:dartz/dartz.dart';
import 'package:news_app_clean_architecture/core/resources/failure.dart';
import 'package:news_app_clean_architecture/core/usecases/usecase.dart';
import 'package:news_app_clean_architecture/features/news/domain/entities/article.dart';
import 'package:news_app_clean_architecture/features/news/domain/repositories/article_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class RemoveArticleUsecase implements Usecase<void, ArticleEntity> {
  final ArticleRepository _articleRepository;

  RemoveArticleUsecase(this._articleRepository);

  @override
  Future<void> call([ArticleEntity? input]) {
    // TODO: implement call
    return _articleRepository.deleteArticle(input!);
  }
}
