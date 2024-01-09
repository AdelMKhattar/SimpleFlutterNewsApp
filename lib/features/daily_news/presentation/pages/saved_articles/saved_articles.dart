import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_article_state.dart';
import 'package:news_app/features/daily_news/presentation/pages/article_detail.dart';
import 'package:news_app/features/daily_news/presentation/widgets/articles_widget.dart';
import 'package:news_app/injection_container.dart';

class SavedArticles extends StatelessWidget {
  const SavedArticles({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<LocalArticleBloc>()..add(const GetSavedArticles()),
        child: Scaffold(
          appBar: _buildAppBar(),
          body: _buildBody(context),
        ));
  }

  _buildAppBar() {
    return AppBar(
      title: const Text("Saved Aricles"),
    );
  }

  _buildBody(BuildContext context) {
    return BlocBuilder<LocalArticleBloc, LocalArticleState>(
        builder: (_, state) {
      if (state is LocalArticleLoading) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      }
      if (state is LocalArticleDone) {
        if (state.articleEntities!.isEmpty) {
          return Container(
            child: Center(child: Text("No Saved Articles")),
          );
        }
        return ListView.builder(
            itemCount: state.articleEntities!.length,
            itemBuilder: (context, index) {
              return ArticleWidget(
                isRemovable: true,
                onRemove: (article) => {
                  BlocProvider.of<LocalArticleBloc>(context)
                      .add(RemoveArticle(article))
                },
                article: state.articleEntities![index],
                onArticlePressed: (article) =>
                    _onArticlePressed(context, article),
              );
            });
      }
      return const SizedBox(
        height: 10,
      );
    });
  }

  _onArticlePressed(
    BuildContext context,
    ArticleEntity article,
  ) {
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ArticleDetails(articleEntity: article)));
  }
}
