import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/core/di/di.dart';
import 'package:news_app_clean_architecture/features/news/presentation/cubit/local/local_article_cubit.dart';
import 'package:news_app_clean_architecture/features/news/presentation/widgets/article_tile.dart';

import '../../../domain/entities/article.dart';
import '../../widgets/saved_article_tile.dart';

class SavedArticles extends StatelessWidget {
  const SavedArticles({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LocalArticleCubit>(
      future: getIt.getAsync<LocalArticleCubit>(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return BlocProvider(
          create: (context) => snapshot.data!..getSavedArticles(),
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Saved Articles'),
              centerTitle: true,
            ),
            body: BlocBuilder<LocalArticleCubit, LocalArticleState>(
              builder: (context, state) {
                if (state is LocalArticleLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is LocalArticleLoaded) {
                  return RefreshIndicator(
                    onRefresh: () async =>
                        context.read<LocalArticleCubit>().getSavedArticles(),
                    child: state.articles!.isEmpty
                        ? _buildEmptyState()
                        : _buildList(context, state.articles!),
                  );
                }
                return _buildErrorState(context);
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bookmark_border, size: 60, color: Colors.grey[400]),
          const SizedBox(height: 20),
          const Text(
            'No Saved Articles',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Text(
            'Save interesting articles to read them later',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context, List<ArticleEntity> articles) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: articles.length,
      separatorBuilder: (_, __) => const Divider(height: 24),
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(articles[index].id),
        direction: DismissDirection.endToStart,
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          child: const Icon(Icons.delete, color: Colors.white, size: 28),
        ),
        onDismissed: (_) {
          context.read<LocalArticleCubit>().removeArticle(articles[index]);
        },
        child: SavedArticleTile(article: articles[index]),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Failed to load saved articles'),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            icon: const Icon(Icons.refresh),
            label: const Text('Try Again'),
            onPressed: () =>
                context.read<LocalArticleCubit>().getSavedArticles(),
          ),
        ],
      ),
    );
  }
}
