import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/daily_news/domain/use%20cases/get_article.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_articel_event.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';

class RemoteArticlesBloc
    extends Bloc<RemoteArticlesEvent, RemoteArticlesState> {
  GetArticleUseCase _getArticleUseCase;
  RemoteArticlesBloc(this._getArticleUseCase)
      : super(const RemoteArticlesLoading()) {
    on<GetArticles>(onGetArticles);
    on<Text1>(onText1);
  }
  void onGetArticles(GetArticles event, Emitter emit) async {
    final dataState = await _getArticleUseCase.call();
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteArticlesDone(dataState.data!));
    }
    if (dataState is DataFailed) {
      emit(RemoteArticlesError(dataState.error!));
    }
  }

  void onText1(Text1 event, Emitter emit) {
    print("Text 1 event");
  }
}
// class RemoteArticlesBloc
//     extends Bloc<RemoteArticlesEvent, RemoteArticlesState> {
//   final GetArticle _getArticleUseCase;

//   RemoteArticlesBloc(this._getArticleUseCase)
//       : super(const RemoteArticlesLoading()) {
//     on<GetArticles>(onGetArticles);
//   }

//   void onGetArticles(
//       GetArticles event, Emitter<RemoteArticlesState> emit) async {
//     final dataState = await _getArticleUseCase.call();

//     if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
//       emit(RemoteArticlesDone(dataState.data!));
//     }

//     if (dataState is DataFailed) {
//       emit(RemoteArticlesError(dataState.error!));
//     }
//   }
// }
