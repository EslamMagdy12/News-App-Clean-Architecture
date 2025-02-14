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
import 'package:pretty_dio_logger/pretty_dio_logger.dart' as _i528;

import '../../features/auth/data/data-sources/online/contract/auth_online_data_source.dart'
    as _i71;
import '../../features/auth/data/data-sources/online/implementation/auth_online_data_source_implementation.dart'
    as _i631;
import '../../features/auth/data/repositories/auth_repository_implementation.dart'
    as _i319;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/presentation/cubit/auth_cubit.dart' as _i117;
import '../../features/news/data/api/dio_provider.dart' as _i1012;
import '../../features/news/data/api/news_api_service.dart' as _i779;
import '../../features/news/data/data-sources/offline/contract/offline_data_source.dart'
    as _i336;
import '../../features/news/data/data-sources/offline/implementation/offline_data_source_implementation.dart'
    as _i921;
import '../../features/news/data/data-sources/online/contract/online_data_source.dart'
    as _i60;
import '../../features/news/data/data-sources/online/implementation/online_data_source_implementation.dart'
    as _i628;
import '../../features/news/data/local/app_database.dart' as _i778;
import '../../features/news/data/local/DatabaseModule.dart' as _i834;
import '../../features/news/data/repositories/article_repository_implementation.dart'
    as _i295;
import '../../features/news/domain/repositories/article_repository.dart'
    as _i999;
import '../../features/news/domain/usecases/get_article.dart' as _i988;
import '../../features/news/domain/usecases/get_saved_articles.dart' as _i88;
import '../../features/news/domain/usecases/remove_article.dart' as _i952;
import '../../features/news/domain/usecases/save_article.dart' as _i865;
import '../../features/news/presentation/cubit/local/local_article_cubit.dart'
    as _i992;
import '../../features/news/presentation/cubit/remote/article_cubit.dart'
    as _i979;
import 'firebase_module.dart' as _i616;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final databaseModule = _$DatabaseModule();
    final firebaseModule = _$FirebaseModule();
    final dioProvider = _$DioProvider();
    await gh.factoryAsync<_i778.AppDatabase>(
      () => databaseModule.appDatabase,
      preResolve: true,
    );
    gh.lazySingleton<_i59.FirebaseAuth>(() => firebaseModule.firebaseAuth);
    gh.lazySingleton<_i974.FirebaseFirestore>(() => firebaseModule.firestore);
    gh.lazySingleton<_i361.Dio>(() => dioProvider.dioProvider());
    gh.lazySingleton<_i528.PrettyDioLogger>(() => dioProvider.providePretty());
    gh.factory<_i336.OfflineDataSource>(
        () => _i921.OfflineDataSourceImplementation(gh<_i778.AppDatabase>()));
    gh.singleton<_i779.NewsApiService>(
        () => _i779.NewsApiService(gh<_i361.Dio>()));
    gh.factory<_i71.AuthOnlineDataSource>(
        () => _i631.AuthOnlineDataSourceImplementation(
              gh<_i59.FirebaseAuth>(),
              gh<_i974.FirebaseFirestore>(),
            ));
    gh.factory<_i60.OnlineDataSource>(
        () => _i628.OnlineDataSourceImplementation(gh<_i779.NewsApiService>()));
    gh.factory<_i787.AuthRepository>(() =>
        _i319.AuthRepositoryImplementation(gh<_i71.AuthOnlineDataSource>()));
    gh.factory<_i999.ArticleRepository>(
        () => _i295.ArticleRepositoryImplementation(
              gh<_i336.OfflineDataSource>(),
              gh<_i60.OnlineDataSource>(),
            ));
    gh.factory<_i117.AuthCubit>(
        () => _i117.AuthCubit(gh<_i787.AuthRepository>()));
    gh.factory<_i988.GetArticleUsecase>(
        () => _i988.GetArticleUsecase(gh<_i999.ArticleRepository>()));
    gh.factory<_i88.GetSavedArticlesUsecase>(
        () => _i88.GetSavedArticlesUsecase(gh<_i999.ArticleRepository>()));
    gh.factory<_i952.RemoveArticleUsecase>(
        () => _i952.RemoveArticleUsecase(gh<_i999.ArticleRepository>()));
    gh.factory<_i865.SaveArticleUsecase>(
        () => _i865.SaveArticleUsecase(gh<_i999.ArticleRepository>()));
    gh.factory<_i979.ArticleCubit>(
        () => _i979.ArticleCubit(gh<_i988.GetArticleUsecase>()));
    gh.factory<_i992.LocalArticleCubit>(() => _i992.LocalArticleCubit(
          gh<_i88.GetSavedArticlesUsecase>(),
          gh<_i952.RemoveArticleUsecase>(),
          gh<_i865.SaveArticleUsecase>(),
        ));
    return this;
  }
}

class _$DatabaseModule extends _i834.DatabaseModule {}

class _$FirebaseModule extends _i616.FirebaseModule {}

class _$DioProvider extends _i1012.DioProvider {}
