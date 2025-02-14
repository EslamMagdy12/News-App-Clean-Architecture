import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/features/news/domain/entities/article.dart';
import 'package:news_app_clean_architecture/features/news/domain/usecases/get_article.dart';
import 'package:injectable/injectable.dart';

part 'article_state.dart';

@injectable
class ArticleCubit extends Cubit<ArticleState> {
  final GetArticleUsecase _getArticleUsecase;

  ArticleCubit(this._getArticleUsecase) : super(ArticleInitial());

  /// Fetches articles from the repository via the usecase.
  Future<void> getArticles() async {
    emit(ArticleLoading());
    try {
      final articles = await _getArticleUsecase();
      if (articles is DataSuccess) {
        emit(ArticleLoaded(articles.data!));
      } else {
        emit(ArticleError('Failed to load articles'));
      }
    } catch (e) {
      emit(ArticleError('Failed to load articles: $e'));
    }
  }
}
