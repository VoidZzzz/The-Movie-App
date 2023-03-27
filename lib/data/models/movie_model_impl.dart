import 'package:the_movie_app/data/data.vos/actor_vo.dart';
import 'package:the_movie_app/data/data.vos/genre_vo.dart';
import 'package:the_movie_app/data/data.vos/movie_vo.dart';
import 'package:the_movie_app/data/models/movie_model.dart';
import 'package:the_movie_app/network/data_agents/retrofit_movie_data_agent_impl.dart';
import 'package:the_movie_app/persistence/daos/genre_dao.dart';
import '../../network/data_agents/movie_data_agent.dart';
import '../../persistence/daos/actor_dao.dart';
import '../../persistence/daos/movie_dao.dart';

class MovieModelImpl extends MovieModel {
  static final MovieModelImpl _singleton = MovieModelImpl._internal();

  factory MovieModelImpl() {
    return _singleton;
  }

  MovieModelImpl._internal();

  final MovieDataAgent _dataAgent = RetrofitMovieDataAgentImpl();

  /// Daos
  MovieDao mMovieDao = MovieDao();
  GenreDao mGenreDao = GenreDao();
  ActorDao mActorDao = ActorDao();

  /// Network
  @override
  Future<List<MovieVO>?> getNowPlayingMovies(int page) {
    return _dataAgent.getNowPlayingMovies(page).then((movies) async {
      List<MovieVO> nowPlayingMovies = movies!.map((movie) {
        movie.isNowPlaying = true;
        movie.isTopRated = false;
        movie.isPopular = false;
        return movie;
      }).toList();
      mMovieDao.saveMovies(nowPlayingMovies);
      return Future.value(movies);
    });
  }

  @override
  Future<List<ActorVO>?> getActors(int page) {
    return _dataAgent.getActors(page).then((actors) async {
      mActorDao.saveAllActors(actors ?? []);
      return Future.value(actors);
    });
  }

  @override
  Future<List<GenreVO>?> getGenres() {
    return _dataAgent.getGenres().then((genres) async {
      mGenreDao.saveAllGenres(genres ?? []);
      return Future.value(genres);
    });
  }

  @override
  Future<List<MovieVO>?> getMoviesByGenre(int genreId) {
    return _dataAgent.getMoviesByGenre(genreId);
  }

  @override
  Future<List<MovieVO>?> getPopularMovies(int page) {
    return _dataAgent.getPopularMovies(page).then((movies) async {
      List<MovieVO> popularMovies = movies!.map((movie) {
        movie.isNowPlaying = false;
        movie.isTopRated = false;
        movie.isPopular = true;
        return movie;
      }).toList();
      mMovieDao.saveMovies(popularMovies);
      return Future.value(movies);
    });
  }

  @override
  Future<List<MovieVO>?> getTopRatedMovies(int page) {
    return _dataAgent.getTopRatedMovies(page).then((movies) async {
      List<MovieVO> topRatedMovies = movies?.map((movie) {
            movie.isNowPlaying = false;
            movie.isTopRated = true;
            movie.isPopular = false;
            return movie;
          }).toList() ??
          [];
      mMovieDao.saveMovies(topRatedMovies);
      return Future.value(movies);
    });
  }

  @override
  Future<List<List<ActorVO>?>> getCreditsByMovie(int movieId) {
    return _dataAgent.getCreditsByMovie(movieId);
  }

  @override
  Future<MovieVO?> getMovieDetails(int movieId) {
    return _dataAgent.getMovieDetails(movieId).then((movie) async {
      if (movie != null) {
        mMovieDao.saveSingleMovie(movie);
      }
      return Future.value(movie);
    });
  }

  /// Database

  @override
  Future<List<MovieVO>?> getNowPlayingMoviesFromDatabase() {
    return Future.value(mMovieDao
        .getAllMovies()
        .where((movie) => movie.isNowPlaying == true)
        .toList());
  }

  @override
  Future<List<MovieVO>?> getPopularMoviesFromDatabase() {
    return Future.value(mMovieDao
        .getAllMovies()
        .where((movie) => movie.isPopular == true)
        .toList());
  }

  @override
  Future<List<MovieVO>?> getTopRatedMoviesFromDatabase() {
    return Future.value(mMovieDao
        .getAllMovies()
        .where((movie) => movie.isTopRated == true)
        .toList());
  }

  @override
  Future<List<ActorVO>?> getAllActorsFromDatabase() {
    return Future.value(mActorDao.getAllActors());
  }

  @override
  Future<List<GenreVO>?> getGenresFromDatabase() {
    return Future.value(mGenreDao.getAllGenres());
  }

  @override
  Future<MovieVO?> getMovieDetailsFromDatabase(int movieId) {
    return Future.value(mMovieDao.getMovieById(movieId));
  }
}
