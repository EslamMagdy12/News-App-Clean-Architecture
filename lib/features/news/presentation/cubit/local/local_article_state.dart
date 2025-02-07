part of 'local_article_cubit.dart';

sealed class LocalArticleState extends Equatable {
  final List<ArticleEntity>? articles;
  final String? message;

  const LocalArticleState({this.articles, this.message});

  @override
  List<Object?> get props => [articles, message];
}

final class LocalArticleInitial extends LocalArticleState {}

final class LocalArticleLoading extends LocalArticleState {}

final class LocalArticleLoaded extends LocalArticleState {
  const LocalArticleLoaded({required List<ArticleEntity> articles})
      : super(articles: articles);
}

final class LocalArticleError extends LocalArticleState {
  const LocalArticleError({required String message}) : super(message: message);
}
