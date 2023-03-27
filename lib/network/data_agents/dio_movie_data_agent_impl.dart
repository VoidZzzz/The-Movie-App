import 'package:flutter/cupertino.dart';
import 'package:the_movie_app/data/data.vos/actor_vo.dart';
import 'package:the_movie_app/data/data.vos/genre_vo.dart';
import 'package:the_movie_app/data/data.vos/movie_vo.dart';
import 'package:the_movie_app/network/api_constants.dart';
import 'package:dio/dio.dart';

import 'movie_data_agent.dart';

class DioMovieDataAgentImpl extends MovieDataAgent {
  @override
  Future<List<MovieVO>?> getNowPlayingMovies(int page) {
    Map<String, String> queryParameters = {
      PARAM_AKI_KEY: API_KEY,
      PARAM_LANGUAGE: LANGUAGE_EN_US,
      PARAM_PAGE: page.toString()
    };

    return Dio()
        .get("$BASE_URL_DIO$ENDPOINT_GET_NOW_PLAYING",
            queryParameters: queryParameters)
        .then((value) {
      debugPrint(
          "Now Playing Movies ===================> ${value.toString()}");
    }).catchError((error) {
      debugPrint("Error ================> ${error.toString()}");
    });
  }

  @override
  Future<List<ActorVO>?> getActors(int page) {
    // TODO: implement getActors
    throw UnimplementedError();
  }

  @override
  Future<List<GenreVO>?> getGenres() {
    // TODO: implement getGenres
    throw UnimplementedError();
  }

  @override
  Future<List<MovieVO>?> getMoviesByGenre(int genreId) {
    // TODO: implement getMoviesByGenre
    throw UnimplementedError();
  }

  @override
  Future<List<MovieVO>?> getPopularMovies(int page) {
    // TODO: implement getPopularMovies
    throw UnimplementedError();
  }

  @override
  Future<List<MovieVO>?> getTopRatedMovies(int page) {
    // TODO: implement getTopRatedMovies
    throw UnimplementedError();
  }

  @override
  Future<List<List<ActorVO>?>> getCreditsByMovie(int movieId) {
    // TODO: implement getCreditsByMovie
    throw UnimplementedError();
  }

  @override
  Future<MovieVO?> getMovieDetails(int movieId) {
    // TODO: implement getMovieDetails
    throw UnimplementedError();
  }
}
