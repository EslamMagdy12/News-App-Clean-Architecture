import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app_clean_architecture/features/news/data/repositories/article_repository_implementation.dart';
import 'package:news_app_clean_architecture/features/news/domain/repositories/article_repository.dart';
import 'package:news_app_clean_architecture/features/news/domain/usecases/get_article.dart';
import 'package:news_app_clean_architecture/features/news/domain/usecases/get_saved_articles.dart';
import 'package:news_app_clean_architecture/features/news/domain/usecases/remove_article.dart';
import 'package:news_app_clean_architecture/features/news/domain/usecases/save_article.dart';
import 'package:news_app_clean_architecture/features/news/presentation/cubit/local/local_article_cubit.dart';
import 'di.config.dart';

final getIt = GetIt.instance;

@injectableInit
Future<void> configureInjection() async {
  await getIt.init(); // Ensure async dependencies are resolved
}

// Future<void> initializeDependencies() async {
//   // Floor
//   final database =
//       await $FloorAppDatabase.databaseBuilder('app_database.db').build();
//   getIt.registerSingleton(database);
//
//   // Dio
//   final dio = Dio();
//   getIt.registerSingleton(dio);
//
//   // Dependencies
//   getIt.registerSingleton<NewsApiService>(NewsApiService(getIt()));
//
//   // Repository
//   getIt.registerSingleton<ArticleRepository>(
//       ArticleRepositoryImplementation(getIt(), getIt()));
//
//   // Usecase
//   getIt.registerSingleton<GetArticleUsecase>(GetArticleUsecase(getIt()));
//
//   getIt.registerSingleton<SaveArticleUsecase>(SaveArticleUsecase(getIt()));
//
//   getIt.registerSingleton<RemoveArticleUsecase>(RemoveArticleUsecase(getIt()));
//
//   getIt.registerSingleton<GetSavedArticlesUsecase>(
//       GetSavedArticlesUsecase(getIt()));
//
//   // Cubit
//   getIt.registerFactory<ArticleCubit>(() => ArticleCubit(getIt()));
//
//   getIt.registerFactory<LocalArticleCubit>(
//       () => LocalArticleCubit(getIt(), getIt(), getIt()));
// }
