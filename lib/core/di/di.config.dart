// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:news_app_clean_architecture/core/di/firebase_module.dart'
    as _i460;
import 'package:news_app_clean_architecture/features/auth/data/data-sources/online/contract/auth_online_data_source.dart'
    as _i989;
import 'package:news_app_clean_architecture/features/auth/data/data-sources/online/implementation/auth_online_data_source_implementation.dart'
    as _i838;
import 'package:news_app_clean_architecture/features/auth/data/repositories/auth_repository_implementation.dart'
    as _i45;
import 'package:news_app_clean_architecture/features/auth/domain/repositories/auth_repository.dart'
    as _i887;
import 'package:news_app_clean_architecture/features/auth/presentation/cubit/auth_cubit.dart'
    as _i368;
import 'package:news_app_clean_architecture/features/news/data/api/dio_provider.dart'
    as _i273;
import 'package:news_app_clean_architecture/features/news/data/api/news_api_service.dart'
    as _i48;
import 'package:news_app_clean_architecture/features/news/data/data-sources/offline/contract/offline_data_source.dart'
    as _i295;
import 'package:news_app_clean_architecture/features/news/data/data-sources/offline/implementation/offline_data_source_implementation.dart'
    as _i615;
import 'package:news_app_clean_architecture/features/news/data/data-sources/online/contract/online_data_source.dart'
    as _i125;
import 'package:news_app_clean_architecture/features/news/data/data-sources/online/implementation/online_data_source_implementation.dart'
    as _i989;
import 'package:news_app_clean_architecture/features/news/data/local/app_database.dart'
    as _i955;
import 'package:news_app_clean_architecture/features/news/data/repositories/article_repository_implementation.dart'
    as _i24;
import 'package:news_app_clean_architecture/features/news/domain/repositories/article_repository.dart'
    as _i279;
import 'package:news_app_clean_architecture/features/news/domain/usecases/get_article.dart'
    as _i838;
import 'package:news_app_clean_architecture/features/news/domain/usecases/get_saved_articles.dart'
    as _i92;
import 'package:news_app_clean_architecture/features/news/domain/usecases/remove_article.dart'
    as _i1042;
import 'package:news_app_clean_architecture/features/news/domain/usecases/save_article.dart'
    as _i150;
import 'package:news_app_clean_architecture/features/news/presentation/cubit/local/local_article_cubit.dart'
    as _i702;
import 'package:news_app_clean_architecture/features/news/presentation/cubit/remote/article_cubit.dart'
    as _i110;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' as _i528;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dioProvider = _$DioProvider();
    final firebaseModule = _$FirebaseModule();
    gh.singletonAsync<_i955.AppDatabase>(
        () => _i955.AppDatabase.initDatabase());
    gh.lazySingleton<_i361.Dio>(() => dioProvider.dioProvider());
    gh.lazySingleton<_i528.PrettyDioLogger>(() => dioProvider.providePretty());
    gh.lazySingleton<_i59.FirebaseAuth>(() => firebaseModule.firebaseAuth);
    gh.lazySingleton<_i974.FirebaseFirestore>(() => firebaseModule.firestore);
    gh.factoryAsync<_i295.OfflineDataSource>(() async =>
        _i615.OfflineDataSourceImplementation(
            await getAsync<_i955.AppDatabase>()));
    gh.singleton<_i48.NewsApiService>(
        () => _i48.NewsApiService(gh<_i361.Dio>()));
    gh.factory<_i989.AuthOnlineDataSource>(
        () => _i838.AuthOnlineDataSourceImplementation(
              gh<_i59.FirebaseAuth>(),
              gh<_i974.FirebaseFirestore>(),
            ));
    gh.factory<_i125.OnlineDataSource>(
        () => _i989.OnlineDataSourceImplementation(gh<_i48.NewsApiService>()));
    gh.factory<_i887.AuthRepository>(() =>
        _i45.AuthRepositoryImplementation(gh<_i989.AuthOnlineDataSource>()));
    gh.factoryAsync<_i279.ArticleRepository>(
        () async => _i24.ArticleRepositoryImplementation(
              await getAsync<_i295.OfflineDataSource>(),
              gh<_i125.OnlineDataSource>(),
            ));
    gh.factory<_i368.AuthCubit>(
        () => _i368.AuthCubit(gh<_i887.AuthRepository>()));
    gh.factoryAsync<_i838.GetArticleUsecase>(() async =>
        _i838.GetArticleUsecase(await getAsync<_i279.ArticleRepository>()));
    gh.factoryAsync<_i92.GetSavedArticlesUsecase>(() async =>
        _i92.GetSavedArticlesUsecase(
            await getAsync<_i279.ArticleRepository>()));
    gh.factoryAsync<_i1042.RemoveArticleUsecase>(() async =>
        _i1042.RemoveArticleUsecase(await getAsync<_i279.ArticleRepository>()));
    gh.factoryAsync<_i150.SaveArticleUsecase>(() async =>
        _i150.SaveArticleUsecase(await getAsync<_i279.ArticleRepository>()));
    gh.factoryAsync<_i110.ArticleCubit>(() async =>
        _i110.ArticleCubit(await getAsync<_i838.GetArticleUsecase>()));
    gh.factoryAsync<_i702.LocalArticleCubit>(
        () async => _i702.LocalArticleCubit(
              await getAsync<_i92.GetSavedArticlesUsecase>(),
              await getAsync<_i1042.RemoveArticleUsecase>(),
              await getAsync<_i150.SaveArticleUsecase>(),
            ));
    return this;
  }
}

class _$DioProvider extends _i273.DioProvider {}

class _$FirebaseModule extends _i460.FirebaseModule {}
