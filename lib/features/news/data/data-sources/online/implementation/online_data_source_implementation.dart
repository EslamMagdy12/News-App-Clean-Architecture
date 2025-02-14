import 'package:injectable/injectable.dart';
import 'package:news_app_clean_architecture/core/constants/constants.dart';
import 'package:news_app_clean_architecture/features/news/data/models/response.dart';

import '../../../api/news_api_service.dart';
import '../contract/online_data_source.dart';

@Injectable(as: OnlineDataSource)
class OnlineDataSourceImplementation implements OnlineDataSource {
  final NewsApiService newsApiService;

  OnlineDataSourceImplementation(this.newsApiService);

  @override
  Future<ResponseAPI> getArticles() async {
    // TODO: implement getArticles
    return await newsApiService.getArticles(
      country: newsAPICountry,
      category: newsAPICategory,
      apiKey: newsAPIKey,
    );
  }
}
