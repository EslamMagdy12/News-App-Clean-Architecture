import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:news_app_clean_architecture/core/di/di.dart';
import 'package:news_app_clean_architecture/features/news/domain/entities/article.dart';
import 'package:news_app_clean_architecture/features/news/presentation/cubit/local/local_article_cubit.dart';

class ArticleView extends StatelessWidget {
  final ArticleEntity? article;

  const ArticleView({super.key, this.article});

  @override
  Widget build(BuildContext context) {
    if (article?.url == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Article')),
        body: const Center(child: Text('Could not load article')),
      );
    }

    return FutureBuilder<LocalArticleCubit>(
      future: getIt.getAsync<LocalArticleCubit>(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));

        return BlocProvider(
          create: (context) => snapshot.data!..getSavedArticles(),
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                article!.title ?? 'Article',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              actions: [_buildFavoriteButton(context)],
            ),
            body: WebViewWidget(
              controller: WebViewController()
                ..loadRequest(Uri.parse(article!.url!))
                ..setJavaScriptMode(JavaScriptMode.unrestricted),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFavoriteButton(BuildContext context) {
    return BlocBuilder<LocalArticleCubit, LocalArticleState>(
      builder: (context, state) {
        final isSaved = state is LocalArticleLoaded &&
            state.articles!.any((a) => a.url == article!.url);

        return IconButton(
          icon: Icon(
            isSaved ? Icons.bookmark : Icons.bookmark_border,
            color: isSaved ? Theme.of(context).primaryColor : null,
          ),
          onPressed: () => _toggleFavorite(context, isSaved),
        );
      },
    );
  }

  void _toggleFavorite(BuildContext context, bool isSaved) {
    final cubit = context.read<LocalArticleCubit>();
    isSaved ? cubit.removeArticle(article!) : cubit.saveArticle(article!);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isSaved ? 'Removed from saved' : 'Added to saved'),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
