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

  /// Page
  int pageForNowPlayingMovies = 1;

  HomeBloc() {
    /// Now Playing Movies Database
    mMoviemodel.getNowPlayingMoviesFromDatabase().listen((movieList) {
      mNowPlayingMoviesList = movieList;
      notifyListeners();
    }).onError((error) {});

    /// Popular Movies Database
    mMoviemodel.getPopularMoviesFromDatabase().listen((movieList) {
      mPopularMoviesList = movieList;
      notifyListeners();
    }).onError((error) {});

    /// Genres
    mMoviemodel.getGenres().then((genreList) {
      mGenresList = genreList;

      /// Movies By Genres
      getMoviesByGenresAndRefresh(mGenresList!.first.id!);
    }).catchError((error) {});

    /// TopRated Database
    mMoviemodel.getTopRatedMoviesFromDatabase().listen((movieList) {
      mTopRatedMoviesList = movieList;
      notifyListeners();
    }).onError((error) {});

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

  void onNowPlayingMovieListEndReached(){
    pageForNowPlayingMovies += 1;
    mMoviemodel.getNowPlayingMovies(pageForNowPlayingMovies);
  }
}
