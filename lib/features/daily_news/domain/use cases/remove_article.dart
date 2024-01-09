import 'package:news_app/core/use_cases/useCase.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/repository/article_repository.dart';

class RemoveSavedArticleUseCase implements UseCase<void, ArticleEntity> {
  final ArticleRepository _articleRepository;
  RemoveSavedArticleUseCase(this._articleRepository);

  @override
  Future<void> call({ArticleEntity? param}) {
    return _articleRepository.removeSavedArticle(param!);
  }
}
