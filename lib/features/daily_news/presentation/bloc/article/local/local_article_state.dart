import 'package:equatable/equatable.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';

abstract class LocalArticleState extends Equatable {
  final List<ArticleEntity>? articleEntities;
  const LocalArticleState({this.articleEntities});

  @override
  List<Object> get props => [articleEntities!];
}

class LocalArticleLoading extends LocalArticleState {
  const LocalArticleLoading();
}

class LocalArticleDone extends LocalArticleState {
  const LocalArticleDone(List<ArticleEntity> articles)
      : super(articleEntities: articles);
}
