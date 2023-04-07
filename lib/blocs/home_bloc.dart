import 'dart:async';
import 'package:the_movie_app/data/data.vos/actor_vo.dart';
import 'package:the_movie_app/data/data.vos/genre_vo.dart';
import 'package:the_movie_app/data/models/movie_model_impl.dart';
import '../data/data.vos/movie_vo.dart';
import '../data/models/movie_model.dart';

class HomeBloc {
  /// Reactive Streams
  StreamController<List<MovieVO>> mNowPlayingStreamController =
      StreamController();
  StreamController<List<MovieVO>> mPopularStreamController = StreamController();
  StreamController<List<MovieVO>> mTopRatedStreamController =
      StreamController();
  StreamController<List<GenreVO>> mGenreListStreamController =
      StreamController();
  StreamController<List<ActorVO>> mActorsStreamController = StreamController();
  StreamController<List<MovieVO>> mMoviesByGenreListStreamController =
      StreamController();

  /// Model
  MovieModel mMovieModel = MovieModelImpl();

  HomeBloc() {

    /// Now Playing Movies Database
    mMovieModel.getNowPlayingMoviesFromDatabase().then((movieList) {
      mNowPlayingStreamController.sink.add(movieList!);
    }).catchError((error) {});

    /// Popular Movies Database
    mMovieModel.getPopularMoviesFromDatabase().then((movieList) {
      mPopularStreamController.sink.add(movieList!);
    }).catchError((error) {});

    /// TopRated Movies Database
    mMovieModel.getTopRatedMoviesFromDatabase().then((movieList) {
      mTopRatedStreamController.sink.add(movieList!);
    }).catchError((error) {});

    /// Genres
    mMovieModel.getGenres().then((genreList) {
      mGenreListStreamController.sink.add(genreList!);

      /// Movies By Genre
      getMoviesByGenresAndRefresh(genreList.first.id!);
    }).catchError((error) {});

    /// Actors
    mMovieModel.getActors(1).then((actorList) {
      mActorsStreamController.sink.add(actorList!);
    }).catchError((error) {});

    /// Actors Database
    mMovieModel.getAllActorsFromDatabase().then((actorList) {
      mActorsStreamController.sink.add(actorList!);
    }).catchError((error) {});
  }

  void onTapGenre(int genreId){
    getMoviesByGenresAndRefresh(genreId);
  }

  void getMoviesByGenresAndRefresh(int genreId) {
    mMovieModel.getMoviesByGenre(genreId).then((moviesByGenre) {
      mMoviesByGenreListStreamController.sink.add(moviesByGenre!);
    }).catchError((error) {});
  }

  void dispose() {
    mNowPlayingStreamController.close();
    mTopRatedStreamController.close();
    mPopularStreamController.close();
    mGenreListStreamController.close();
    mActorsStreamController.close();
    mMoviesByGenreListStreamController.close();
  }
}
