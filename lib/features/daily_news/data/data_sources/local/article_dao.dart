import 'package:news_app/features/daily_news/data/models/article_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class ArticleDao {
  @Query('SELECT * FROM article')
  Future<List<ArticleModel>> getAllArticles();

  @Insert()
  Future<void> insertArticle(ArticleModel article);

  @delete
  Future<void> deleteArticle(ArticleModel article);
}
