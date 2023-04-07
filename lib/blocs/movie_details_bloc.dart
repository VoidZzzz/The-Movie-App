import 'dart:async';
import 'package:the_movie_app/data/models/movie_model_impl.dart';

import '../data/data.vos/actor_vo.dart';
import '../data/data.vos/movie_vo.dart';
import '../data/models/movie_model.dart';

class MovieDetailsBloc {
  /// Stream Controllers
  StreamController<MovieVO> movieStreamController = StreamController.broadcast();
  StreamController<List<ActorVO>> actorsStreamController = StreamController.broadcast();
  StreamController<List<ActorVO>> creatorsStreamController = StreamController.broadcast();

  /// Model
  MovieModel mMovieModel = MovieModelImpl();

  MovieDetailsBloc(int movieId) {
    /// Movie Details
    mMovieModel.getMovieDetails(movieId).then((movie) {
      movieStreamController.sink.add(movie!);
    }).catchError((error) {});

    /// Movie Details Database
    mMovieModel.getMovieDetailsFromDatabase(movieId).then((movie) {
      movieStreamController.sink.add(movie!);
    }).catchError((error) {});

    /// Actors And Creators
    mMovieModel.getCreditsByMovie(movieId).then((castAndCrew) {
      actorsStreamController.sink.add(castAndCrew[0]!);
      creatorsStreamController.sink.add(castAndCrew[1]!);
    }).catchError((error) {});
  }

  void disposeStreams() {
    movieStreamController.close();
    actorsStreamController.close();
    creatorsStreamController.close();
  }
}
