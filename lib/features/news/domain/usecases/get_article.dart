import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/features/news/domain/entities/article.dart';
import 'package:news_app_clean_architecture/features/news/domain/repositories/article_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetArticleUsecase {
  final ArticleRepository _articleRepository;

  GetArticleUsecase(this._articleRepository);

  Future<DataState<List<ArticleEntity>>> call() async {
    // TODO: implement call
    return _articleRepository.getArticles();
  }
}
