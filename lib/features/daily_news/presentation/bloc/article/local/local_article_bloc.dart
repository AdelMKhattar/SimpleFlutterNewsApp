import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/daily_news/domain/use%20cases/get_saved_article.dart';
import 'package:news_app/features/daily_news/domain/use%20cases/remove_article.dart';
import 'package:news_app/features/daily_news/domain/use%20cases/save_article.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_article_state.dart';

class LocalArticleBloc extends Bloc<LocalArticlesEvent, LocalArticleState> {
  final SaveArticleUseCase _saveArticleUseCase;
  final RemoveSavedArticleUseCase _removeSavedArticleUseCase;
  final GetSavedArticleUseCase _getSavedArticleUseCase;
  LocalArticleBloc(this._saveArticleUseCase, this._removeSavedArticleUseCase,
      this._getSavedArticleUseCase)
      : super(const LocalArticleLoading()) {
    on<GetSavedArticles>(onGetSavedArticles);
    on<RemoveArticle>(onRemoveArticle);
    on<SaveArticle>(onSaveArticle);
  }
  onGetSavedArticles(GetSavedArticles event, Emitter emit) async {
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticleDone(articles));
  }

  onRemoveArticle(RemoveArticle event, Emitter emit) async {
    await _removeSavedArticleUseCase(param: event.article);
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticleDone(articles));
  }

  onSaveArticle(SaveArticle event, Emitter emit) async {
    await _saveArticleUseCase(param: event.article);
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticleDone(articles));
  }
}
