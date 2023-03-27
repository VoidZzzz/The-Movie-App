import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:the_movie_app/network/api_constants.dart';
import 'package:the_movie_app/network/the_movie_api.dart';

import '../../data/data.vos/actor_vo.dart';
import '../../data/data.vos/genre_vo.dart';
import '../../data/data.vos/movie_vo.dart';
import 'movie_data_agent.dart';

class RetrofitMovieDataAgentImpl extends MovieDataAgent {
  late TheMovieApi mApi;

  static RetrofitMovieDataAgentImpl _singleton = RetrofitMovieDataAgentImpl
      ._internal(); //assign private constructor to class level variable

  factory RetrofitMovieDataAgentImpl() {
    return _singleton;
  } // assign var in factory constructor

  RetrofitMovieDataAgentImpl._internal() {
    final dio = Dio();
    mApi = TheMovieApi(dio);
  } // private named constructor

  @override
  Future<List<MovieVO>?> getNowPlayingMovies(int page) {
    return mApi
        .getNowPlayingMovies(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<MovieVO>?> getPopularMovies(int page) {
    return mApi
        .getPopularMovies(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<MovieVO>?> getTopRatedMovies(int page) {
    return mApi
        .getTopRatedMovies(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<GenreVO>?> getGenres() {
    return mApi
        .getGenres(API_KEY, LANGUAGE_EN_US)
        .asStream()
        .map((response) => response.genres)
        .first;
  }

  @override
  Future<List<MovieVO>?> getMoviesByGenre(int genreId) {
    return mApi
        .getMoviesByGenre(API_KEY, LANGUAGE_EN_US, genreId.toString())
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<ActorVO>?> getActors(int page) {
    return mApi
        .getActors(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<List<ActorVO>?>> getCreditsByMovie(int movieId) {
    return mApi
        .getCreditsByMovie(movieId.toString(), API_KEY)
        .asStream()
        .map(
          (getCreditsByMovieResponse) =>
              [getCreditsByMovieResponse.cast, getCreditsByMovieResponse.crew],
        )
        .first;
  }

  @override
  Future<MovieVO?> getMovieDetails(int movieId) {
    return mApi.getMovieDetails(movieId.toString(), API_KEY);
  }
}
