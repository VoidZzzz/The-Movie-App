import 'package:the_movie_app/data/data.vos/movie_vo.dart';
import '../data.vos/actor_vo.dart';
import '../data.vos/genre_vo.dart';

abstract class MovieModel{
  // Network
  void getNowPlayingMovies(int page);
  void getPopularMovies(int page);
  void getTopRatedMovies(int page);
  Future<List<GenreVO>?> getGenres();
  Future<List<MovieVO>?> getMoviesByGenre(int genreId);
  Future<List<ActorVO>?> getActors(int page);
  Future<MovieVO?> getMovieDetails(int movieId);
  Future<List<List<ActorVO>?>> getCreditsByMovie(int movieId);

  // Database
  Stream<List<MovieVO>?> getNowPlayingMoviesFromDatabase();
  Stream<List<MovieVO>?> getTopRatedMoviesFromDatabase();
  Stream<List<MovieVO>?> getPopularMoviesFromDatabase();
  Future<List<GenreVO>?> getGenresFromDatabase();
  Future<List<ActorVO>?> getAllActorsFromDatabase();
  Future<MovieVO?> getMovieDetailsFromDatabase(int movieId);

}