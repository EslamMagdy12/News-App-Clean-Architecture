import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app_clean_architecture/features/news/domain/entities/article.dart';
import 'package:news_app_clean_architecture/features/news/domain/usecases/get_saved_articles.dart';
import 'package:news_app_clean_architecture/features/news/domain/usecases/remove_article.dart';
import 'package:news_app_clean_architecture/features/news/domain/usecases/save_article.dart';
import 'package:injectable/injectable.dart';

part 'local_article_state.dart';

@injectable
class LocalArticleCubit extends Cubit<LocalArticleState> {
  final GetSavedArticlesUsecase _getSavedArticlesUsecase;
  final RemoveArticleUsecase _removeArticleUsecase;
  final SaveArticleUsecase _saveArticleUsecase;

  LocalArticleCubit(
    this._getSavedArticlesUsecase,
    this._removeArticleUsecase,
    this._saveArticleUsecase,
  ) : super(LocalArticleInitial());

  Future<void> getSavedArticles() async {
    emit(LocalArticleLoading());
    try {
      final articles = await _getSavedArticlesUsecase.call();
      emit(LocalArticleLoaded(articles: articles));
    } catch (e) {
      emit(LocalArticleError(message: 'Failed to load saved articles: $e'));
    }
  }

  Future<void> removeArticle(ArticleEntity article) async {
    if (state is LocalArticleLoaded) {
      final currentState = state as LocalArticleLoaded;

      try {
        // Perform the removal operation
        await _removeArticleUsecase(article);

        // Update the list after successful removal
        final updatedArticles = List<ArticleEntity>.from(currentState.articles!)
          ..removeWhere((a) => a.url == article.url);

        emit(LocalArticleLoaded(articles: updatedArticles));
      } catch (e) {
        emit(LocalArticleError(message: 'Failed to remove article: $e'));

        // Optionally, reload the saved articles to ensure consistency
        await getSavedArticles();
      }
    }
  }

  Future<void> saveArticle(ArticleEntity article) async {
    if (state is LocalArticleLoaded) {
      final currentState = state as LocalArticleLoaded;
      final updatedArticles = List<ArticleEntity>.from(currentState.articles!)
        ..add(article);

      emit(LocalArticleLoaded(articles: updatedArticles));

      try {
        await _saveArticleUsecase(article);
      } catch (e) {
        emit(LocalArticleError(message: 'Failed to save article: $e'));
        await getSavedArticles(); // Revert to the actual state
      }
    }
  }
}
