import 'package:news_app_clean_architecture/features/news/data/models/response.dart';
import 'package:news_app_clean_architecture/features/news/domain/entities/article.dart';

import '../../features/auth/data/models/user_model.dart';
import '../../features/auth/domain/entities/user_entity.dart';

extension ArticleMapper on ArticleModel {
  ArticleEntity toEntity() {
    return ArticleEntity(
      author: author,
      title: title,
      description: description,
      url: url,
      urlToImage: urlToImage,
      publishedAt: publishedAt,
      content: content,
    );
  }
}

extension UserMapper on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      fullname: fullname,
      username: username,
      phone: phone,
    );
  }
}
