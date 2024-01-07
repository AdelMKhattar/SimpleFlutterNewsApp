import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:news_app/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:news_app/features/daily_news/data/repositories/article_repository_imp.dart';
import 'package:news_app/features/daily_news/domain/repository/article_repository.dart';
import 'package:news_app/features/daily_news/domain/use%20cases/get_article.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';

final sl = GetIt.instance;

Future<void> intializeDependencies() async {
  print("hello");
  //Dio
  sl.registerSingleton<Dio>(Dio());
  //Register Dependencies
  sl.registerSingleton<NewsApiService>(NewsApiService(sl()));
  sl.registerSingleton<ArticleRepository>(
      ArticleRepositoryImplementation(sl()));
  //Register UseCases
  sl.registerSingleton<GetArticleUseCase>(GetArticleUseCase(sl()));
  //Register Bloc
  sl.registerFactory(() => RemoteArticlesBloc(sl()));
}