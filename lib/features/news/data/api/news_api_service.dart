import 'package:dio/dio.dart';
import 'package:news_app_clean_architecture/core/constants/constants.dart';
import 'package:news_app_clean_architecture/features/news/data/models/response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:injectable/injectable.dart';

part 'news_api_service.g.dart';

@singleton
@RestApi(baseUrl: newsAPIBaseURL)
abstract class NewsApiService {
  @factoryMethod
  factory NewsApiService(Dio dio) = _NewsApiService;

  @GET('/top-headlines')
  Future<ResponseAPI> getArticles({
    @Query('country') required String country,
    @Query('category') required String category,
    @Query('apiKey') required String apiKey,
  });
}
