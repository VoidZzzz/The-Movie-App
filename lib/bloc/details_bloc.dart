

import 'package:flutter/foundation.dart';
import 'package:the_movie_app/data/models/movie_model_impl.dart';

import '../data/data.vos/actor_vo.dart';
import '../data/data.vos/movie_vo.dart';
import '../data/models/movie_model.dart';

class MovieDetailsBloc extends ChangeNotifier{
  /// State
  MovieVO? mMovie;
  List<ActorVO>? mActorsList;
  List<ActorVO>? mCreatorsList;

  /// Model
  MovieModel mMovieModel = MovieModelImpl();

  MovieDetailsBloc(int movieId){
    /// Movie Details
    mMovieModel.getMovieDetails(movieId).then((movie) {
      mMovie = movie!;
      notifyListeners();
    }).catchError((error){});

    /// Movie Details DataBase
    mMovieModel.getMovieDetailsFromDatabase(movieId).then((movie) {
      mMovie = movie!;
      notifyListeners();
    }).catchError((error){});

    /// Actors And Creators
    mMovieModel.getCreditsByMovie(movieId).then((actorsAndCreators) {
      mActorsList = actorsAndCreators[0]!;
      mCreatorsList = actorsAndCreators[1]!;
      notifyListeners();
    }).catchError((error){});
  }
}