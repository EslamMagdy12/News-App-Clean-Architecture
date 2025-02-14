import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/core/di/di.dart';
import 'package:news_app_clean_architecture/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:news_app_clean_architecture/features/news/presentation/cubit/remote/article_cubit.dart';
import 'package:news_app_clean_architecture/features/news/presentation/widgets/article_tile.dart';

class News extends StatelessWidget {
  News({super.key});

  final AuthCubit authCubit = getIt<AuthCubit>();
  final ArticleCubit articleCubit = getIt<ArticleCubit>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => authCubit..checkSignInStatus(),
        ),
        BlocProvider<ArticleCubit>(
          create: (_) => articleCubit..getArticles(),
        ),
      ],
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 8),
            Expanded(child: _buildArticleList()),
          ],
        ),
      ),
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

  Widget _buildHeader() {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        String username = 'there';
        if (state is AuthSuccess) {
          username = state.user.username;
        }
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Hello, $username 👋',
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
            onRefresh: () async => articleCubit.getArticles(),
            child: ListView.separated(
              padding: const EdgeInsets.only(bottom: 24),
              itemCount: state.articles.length,
              separatorBuilder: (_, __) => const Divider(height: 24),
              itemBuilder: (context, index) =>
                  ArticleTile(article: state.articles[index]),
            ),
          );
        }
        if (state is ArticleError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(state.error),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => articleCubit.getArticles(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
