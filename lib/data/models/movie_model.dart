import 'package:scoped_model/scoped_model.dart';
import 'package:the_movie_app/data/data.vos/movie_vo.dart';
import '../data.vos/actor_vo.dart';
import '../data.vos/genre_vo.dart';

abstract class MovieModel extends Model{
  // Network
  void getNowPlayingMovies(int page);
  void getPopularMovies(int page);
  void getTopRatedMovies(int page);

  void getGenres();
  void getMoviesByGenre(int genreId);
  void getActors(int page);
  void getMovieDetails(int movieId);
  void getCreditsByMovie(int movieId);

  // Database
  void getNowPlayingMoviesFromDatabase();
  void getTopRatedMoviesFromDatabase();
  void getPopularMoviesFromDatabase();
  void getGenresFromDatabase();
  void getAllActorsFromDatabase();
  void getMovieDetailsFromDatabase(int movieId);

}