import 'package:stream_transform/stream_transform.dart';
import 'package:the_movie_app/data/data.vos/actor_vo.dart';
import 'package:the_movie_app/data/data.vos/genre_vo.dart';
import 'package:the_movie_app/data/data.vos/movie_vo.dart';
import 'package:the_movie_app/data/models/movie_model.dart';
import 'package:the_movie_app/network/data_agents/retrofit_movie_data_agent_impl.dart';
import 'package:the_movie_app/persistence/daos/actor_dao.dart';
import 'package:the_movie_app/persistence/daos/genre_dao.dart';
import 'package:the_movie_app/persistence/daos/movie_dao.dart';
import '../../network/data_agents/movie_data_agent.dart';
import '../../persistence/daos/impls/actor_dao_impl.dart';
import '../../persistence/daos/impls/genre_dao_impl.dart';
import '../../persistence/daos/impls/movie_dao_impl.dart';

class MovieModelImpl extends MovieModel {
  static final MovieModelImpl _singleton = MovieModelImpl._internal();

  factory MovieModelImpl() {
    return _singleton;
  }

  MovieModelImpl._internal();

   MovieDataAgent mDataAgent = RetrofitMovieDataAgentImpl();

  /// Daos
  MovieDao mMovieDao = MovieDaoImpl();
  GenreDao mGenreDao = GenreDaoImpl();
  ActorDao mActorDao = ActorDaoImpl();

  /// For Testing Purposes
  void setDaosAndDataAgents(
      MovieDao movieDaoTest, ActorDao actorDaoTest, GenreDao genreDaoTest , MovieDataAgent movieDataAgentTest) {
    mMovieDao = movieDaoTest  ;
    mActorDao = actorDaoTest ;
    mGenreDao = genreDaoTest ;
    mDataAgent = movieDataAgentTest;
  }

  /// Network
  @override
  void getNowPlayingMovies(int page) {
    mDataAgent.getNowPlayingMovies(page).then((movies) async {
      List<MovieVO> nowPlayingMovies = movies!.map((movie) {
        movie.isNowPlaying = true;
        movie.isTopRated = false;
        movie.isPopular = false;
        return movie;
      }).toList();
      mMovieDao.saveMovies(nowPlayingMovies);
    });
  }

  @override
  Future<List<ActorVO>?> getActors(int page) {
    return mDataAgent.getActors(page).then((actors) async {
      mActorDao.saveAllActors(actors ?? []);
      return Future.value(actors);
    });
  }

  @override
  Future<List<GenreVO>?> getGenres() {
    return mDataAgent.getGenres().then((genres) async {
      mGenreDao.saveAllGenres(genres ?? []);
      return Future.value(genres);
    });
  }

  @override
  Future<List<MovieVO>?> getMoviesByGenre(int genreId) {
    return mDataAgent.getMoviesByGenre(genreId);
  }

  @override
  void getPopularMovies(int page) {
    mDataAgent.getPopularMovies(page).then((movies) async {
      List<MovieVO> popularMovies = movies!.map((movie) {
        movie.isNowPlaying = false;
        movie.isTopRated = false;
        movie.isPopular = true;
        return movie;
      }).toList();
      mMovieDao.saveMovies(popularMovies);
    });
  }

  @override
  void getTopRatedMovies(int page) {
    mDataAgent.getTopRatedMovies(page).then((movies) async {
      List<MovieVO> topRatedMovies = movies?.map((movie) {
            movie.isNowPlaying = false;
            movie.isTopRated = true;
            movie.isPopular = false;
            return movie;
          }).toList() ??
          [];
      mMovieDao.saveMovies(topRatedMovies);
    });
  }

  @override
  Future<List<List<ActorVO>?>> getCreditsByMovie(int movieId) {
    return mDataAgent.getCreditsByMovie(movieId);
  }

  @override
  Future<MovieVO?> getMovieDetails(int movieId) {
    return mDataAgent.getMovieDetails(movieId).then((movie) async {
      if (movie != null) {
        mMovieDao.saveSingleMovie(movie);
      }
      return Future.value(movie);
    });
  }

  /// Database

  @override
  Stream<List<MovieVO>?> getNowPlayingMoviesFromDatabase() {
    getNowPlayingMovies(1);
    return mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getNowPlayingMoviesStream())
        .map((event) => mMovieDao.getNowPlayingMovies());
  }

  @override
  Stream<List<MovieVO>?> getPopularMoviesFromDatabase() {
    getPopularMovies(1);
    return mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getPopularMoviesStream())
        .map((event) => mMovieDao.getPopularMovies());
  }

  @override
  Stream<List<MovieVO>?> getTopRatedMoviesFromDatabase() {
    getTopRatedMovies(1);
    return mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getTopRatedMoviesStream())
        .map((event) => mMovieDao.getTopRatedMovies());
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
