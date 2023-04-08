import 'package:flutter/foundation.dart';
import 'package:the_movie_app/data/models/movie_model_impl.dart';
import '../data/data.vos/actor_vo.dart';
import '../data/data.vos/genre_vo.dart';
import '../data/data.vos/movie_vo.dart';
import '../data/models/movie_model.dart';

class HomeBloc extends ChangeNotifier {
  /// States
  List<MovieVO>? mNowPlayingMoviesList;
  List<MovieVO>? mPopularMoviesList;
  List<MovieVO>? mTopRatedMoviesList;
  List<MovieVO>? mMoviesByGenre;
  List<GenreVO>? mGenresList;
  List<ActorVO>? mActorList;

  /// Model
  MovieModel mMoviemodel = MovieModelImpl();

  HomeBloc() {
    /// Now Playing Movies Database
    mMoviemodel.getNowPlayingMoviesFromDatabase().then((movieList) {
      mNowPlayingMoviesList = movieList;
      notifyListeners();
    }).catchError((error) {});

    /// Popular Movies Database
    mMoviemodel.getPopularMoviesFromDatabase().then((movieList) {
      mPopularMoviesList = movieList;
      notifyListeners();
    }).catchError((error) {});

    /// Genres
    mMoviemodel.getGenres().then((genreList) {
      mGenresList = genreList;

      /// Movies By Genres
      getMoviesByGenresAndRefresh(mGenresList!.first.id!);
    }).catchError((error) {});

    /// TopRated Database
    mMoviemodel.getTopRatedMoviesFromDatabase().then((movieList) {
      mTopRatedMoviesList = movieList;
      notifyListeners();
    }).catchError((error) {});

    /// Actors
    mMoviemodel.getActors(1).then((actorList) {
      mActorList = actorList;
    }).catchError((error) {});

    /// Actor Database
    mMoviemodel.getAllActorsFromDatabase().then((actorList) {
      mActorList = actorList;
      notifyListeners();
    }).catchError((error) {});
  }

  void getMoviesByGenresAndRefresh(int genreId) {
    mMoviemodel.getMoviesByGenre(genreId).then((moviesByGenres) {
      mMoviesByGenre = moviesByGenres;
      notifyListeners();
    }).catchError((error) {});
  }

  void onChooseGenres(int genreId){
    getMoviesByGenresAndRefresh(genreId);
  }
}
