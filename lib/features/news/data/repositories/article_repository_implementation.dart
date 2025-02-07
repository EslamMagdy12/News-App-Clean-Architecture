import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:news_app_clean_architecture/core/constants/constants.dart';
import 'package:news_app_clean_architecture/core/resources/failure.dart';
import 'package:news_app_clean_architecture/core/utils/mapper.dart';
import 'package:news_app_clean_architecture/features/news/domain/entities/article.dart';
import 'package:news_app_clean_architecture/features/news/domain/repositories/article_repository.dart';
import 'package:injectable/injectable.dart';

import '../data-sources/offline/contract/offline_data_source.dart';
import '../data-sources/online/contract/online_data_source.dart';

@Injectable(as: ArticleRepository)
class ArticleRepositoryImplementation implements ArticleRepository {
  final OnlineDataSource _onlineDataSource;
  final OfflineDataSource _offlineDataSource;

  ArticleRepositoryImplementation(
      this._offlineDataSource, this._onlineDataSource);

  @override
  Future<List<ArticleEntity>> getArticles() async {
    try {
      final result = await _onlineDataSource.getArticles();
      return result.articles?.map((article) => article.toEntity()).toList() ??
          [];
    } catch (e) {
      throw Exception('Failed to fetch articles: \$e');
    }
  }

  @override
  Future<void> deleteArticle(ArticleEntity article) async {
    try {
      await _offlineDataSource.deleteArticle(article.url!);
    } catch (e) {
      throw Exception('Failed to delete article: $e');
    }
  }

  @override
  Future<List<ArticleEntity>> getLocalArticles() async {
    try {
      final articles = await _offlineDataSource.findAllArticles();
      return articles;
    } catch (e) {
      throw Exception('Failed to fetch offline articles: $e');
    }
  }

  @override
  Future<void> insertArticle(ArticleEntity article) async {
    try {
      await _offlineDataSource.insertArticle(article);
    } catch (e) {
      throw Exception('Failed to insert article: $e');
    }
  }
}
