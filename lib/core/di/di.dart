import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
Future<void> configureDependencies() async => getIt.init();
// Ensure async dependencies are resolved

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
