import 'package:news_app_clean_architecture/features/news/data/models/response.dart';

abstract class OnlineDataSource {
  Future<ResponseAPI> getArticles();
}
