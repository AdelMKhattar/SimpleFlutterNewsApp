import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/themes/app_theme.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:news_app/injection_container.dart';

class ArticleDetails extends StatelessWidget {
  final ArticleEntity articleEntity;
  const ArticleDetails({super.key, required this.articleEntity});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LocalArticleBloc>(),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(context),
        floatingActionButton: _buildFloatingActionButton(context),
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: Text(articleEntity.title!.isNotEmpty
          ? articleEntity.title.toString()
          : " "),
    );
  }

  _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Text(
            articleEntity.title.toString(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            articleEntity.publishedAt!.isNotEmpty
                ? articleEntity.publishedAt!
                : " ",
            style: theme().textTheme.bodySmall,
          ),
          const SizedBox(
            height: 3,
          ),
          Image.network(articleEntity.urlToImage!,
              errorBuilder: (context, error, stackTrace) => Container(
                    height: MediaQuery.of(context).size.height * 20 / 100,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white24,
                    child: const Center(child: Text("Error Loading Image")),
                  )),
          Text(
            articleEntity.description!.isNotEmpty
                ? articleEntity.description!
                : " ",
          ),
          Text(
            articleEntity.content!.isNotEmpty ? articleEntity.content! : " ",
            maxLines: 11,
          ),
          Text(
            articleEntity.author!.isNotEmpty ? articleEntity.author! : "Author",
            style: theme().textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  _buildFloatingActionButton(BuildContext context) {
    return Builder(
        builder: (context) => FloatingActionButton(
              child: Icon(Icons.bookmark),
              onPressed: () => BlocProvider.of<LocalArticleBloc>(context)
                  .add(SaveArticle(articleEntity)),
            ));
  }
}
