import 'package:injectable/injectable.dart';
import 'package:news_app_clean_architecture/features/news/data/data-sources/offline/contract/offline_data_source.dart';
import 'package:news_app_clean_architecture/features/news/domain/entities/article.dart';

import '../../../local/app_database.dart';

@Injectable(as: OfflineDataSource)
class OfflineDataSourceImplementation implements OfflineDataSource {
  final AppDatabase _appDatabase;

  OfflineDataSourceImplementation(this._appDatabase);

  @override
  Future<void> deleteArticle(String url) async {
    // TODO: implement deleteArticle
    _appDatabase.articleDao.deleteArticle(url);
  }

  @override
  Future<List<ArticleEntity>> findAllArticles() async {
    return _appDatabase.articleDao.findAllArticles();
  }

  @override
  Future<void> insertArticle(ArticleEntity article) async {
    // TODO: implement insertArticle
    _appDatabase.articleDao.insertArticle(article);
  }
}
