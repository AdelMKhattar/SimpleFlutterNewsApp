import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app/config/themes/app_theme.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';

class ArticleDetails extends StatelessWidget {
  final ArticleEntity articleEntity;
  const ArticleDetails({super.key, required this.articleEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
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
          CachedNetworkImage(
              imageUrl: articleEntity.urlToImage!,
              errorWidget: (context, url, error) => Padding(
                    padding: const EdgeInsetsDirectional.only(end: 14),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3,
                        height: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.08),
                        ),
                        child: const Icon(Icons.error),
                      ),
                    ),
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
          Text(
            articleEntity.publishedAt!.isNotEmpty
                ? articleEntity.publishedAt!
                : " ",
            style: theme().textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
