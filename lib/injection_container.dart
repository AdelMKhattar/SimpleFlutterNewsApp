import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:news_app/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:news_app/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:news_app/features/daily_news/data/repositories/article_repository_imp.dart';
import 'package:news_app/features/daily_news/domain/repository/article_repository.dart';
import 'package:news_app/features/daily_news/domain/use%20cases/get_article.dart';
import 'package:news_app/features/daily_news/domain/use%20cases/get_saved_article.dart';
import 'package:news_app/features/daily_news/domain/use%20cases/remove_article.dart';
import 'package:news_app/features/daily_news/domain/use%20cases/save_article.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';

final sl = GetIt.instance;

Future<void> intializeDependencies() async {
  //create Database
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(database);

  //Dio
  sl.registerSingleton<Dio>(Dio());
  //Register Dependencies
  sl.registerSingleton<NewsApiService>(NewsApiService(sl()));
  sl.registerSingleton<ArticleRepository>(
      ArticleRepositoryImplementation(sl(), sl()));
  //Register UseCases
  sl.registerSingleton<GetArticleUseCase>(GetArticleUseCase(sl()));
  sl.registerSingleton<GetSavedArticleUseCase>(GetSavedArticleUseCase(sl()));
  sl.registerSingleton<SaveArticleUseCase>(SaveArticleUseCase(sl()));
  sl.registerSingleton<RemoveSavedArticleUseCase>(
      RemoveSavedArticleUseCase(sl()));
  //Register Bloc
  sl.registerFactory(() => RemoteArticlesBloc(sl()));
  sl.registerFactory(() => LocalArticleBloc(sl(), sl(), sl()));
}
