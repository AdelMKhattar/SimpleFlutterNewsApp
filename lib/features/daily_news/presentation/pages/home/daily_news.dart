import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:news_app/features/daily_news/presentation/pages/article_detail.dart';
import 'package:news_app/features/daily_news/presentation/pages/saved_articles/saved_articles.dart';
import 'package:news_app/features/daily_news/presentation/widgets/articles_widget.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text("Daily News"),
      leading: IconButton(
        onPressed: () => _onIconButtonPressed(context),
        icon: Icon(Icons.bookmark),
        color: Colors.black,
      ),
    );
  }

  _onIconButtonPressed(BuildContext context) {
    return Navigator.push(context,
        MaterialPageRoute(builder: (context) => const SavedArticles()));
  }

  _buildBody() {
    return BlocBuilder<RemoteArticlesBloc, RemoteArticlesState>(
        builder: (_, state) {
      if (state is RemoteArticlesLoading) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      }
      if (state is RemoteArticlesError) {
        return const Center(
          child: Icon(Icons.refresh),
        );
      }
      if (state is RemoteArticlesDone) {
        return ListView.builder(
          itemBuilder: (context, Index) {
            return ArticleWidget(
              article: state.articles![Index],
              onArticlePressed: (article) =>
                  _onArticlePressed(context, article),
            );
          },
          itemCount: state.articles!.length,
        );
      }
      return const SizedBox(
        height: 10,
      );
    });
  }

  void _onArticlePressed(BuildContext context, ArticleEntity article) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ArticleDetails(articleEntity: article)));
  }
}
