import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/core/di/di.dart';
import 'package:news_app_clean_architecture/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:news_app_clean_architecture/features/news/presentation/cubit/remote/article_cubit.dart';
import 'package:news_app_clean_architecture/features/news/presentation/widgets/article_tile.dart';

class News extends StatelessWidget {
  const News({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ArticleCubit>(
      future: getIt.getAsync<ArticleCubit>(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
        return BlocProvider(
          create: (context) => snapshot.data!..getArticles(),
          child: Scaffold(
            appBar: _buildAppBar(context),
            body: Column(
              children: [
                _buildHeader(context),
                const SizedBox(height: 8),
                Expanded(child: _buildArticleList()),
              ],
            ),
          ),
        );
      },
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Latest News'),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.bookmark),
          onPressed: () => Navigator.pushNamed(context, '/favorites'),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return FutureBuilder(
      future: getIt.get<AuthCubit>().getSignedInUser(),
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Hello, ${snapshot.data?.username ?? 'there'} 👋',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                'Stay updated with latest news',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.grey),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildArticleList() {
    return BlocBuilder<ArticleCubit, ArticleState>(
      builder: (context, state) {
        if (state is ArticleLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ArticleLoaded) {
          return RefreshIndicator(
            onRefresh: () async => context.read<ArticleCubit>().getArticles(),
            child: ListView.separated(
              padding: const EdgeInsets.only(bottom: 24),
              itemCount: state.articles.length,
              separatorBuilder: (_, __) => const Divider(height: 24),
              itemBuilder: (context, index) =>
                  ArticleTile(article: state.articles[index]),
            ),
          );
        }
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Failed to load articles'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.read<ArticleCubit>().getArticles(),
                child: const Text('Retry'),
              ),
            ],
          ),
        );
      },
    );
  }
}
