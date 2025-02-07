import 'package:flutter/material.dart';
import 'package:news_app_clean_architecture/features/auth/presentation/pages/login_screen.dart';
import 'package:news_app_clean_architecture/features/auth/presentation/pages/signup_screen.dart';
import 'package:news_app_clean_architecture/features/news/domain/entities/article.dart';
import 'package:news_app_clean_architecture/features/news/presentation/pages/article_details/article_details.dart';
import 'package:news_app_clean_architecture/features/news/presentation/pages/home/news.dart';
import 'package:news_app_clean_architecture/features/news/presentation/pages/saved_articles/saved_articles.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String article = '/article';
  static const String favorites = '/favorites';
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const News());
      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => const News());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const News());
      case AppRoutes.article:
        if (args is ArticleEntity) {
          return MaterialPageRoute(
            builder: (_) => ArticleView(article: args),
          );
        }
        return _errorRoute();
      case AppRoutes.favorites:
        return MaterialPageRoute(builder: (_) => const SavedArticles());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      ),
    );
  }
}
