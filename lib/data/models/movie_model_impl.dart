import 'package:stream_transform/stream_transform.dart';
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

  MovieModelImpl._internal() {
    getNowPlayingMoviesFromDatabase();
    getPopularMoviesFromDatabase();
    getTopRatedMoviesFromDatabase();
    getAllActorsFromDatabase();
    getActors(1);
    getGenres();
    getGenresFromDatabase();
  }

  final MovieDataAgent _dataAgent = RetrofitMovieDataAgentImpl();

  /// Daos
  MovieDao mMovieDao = MovieDao();
  GenreDao mGenreDao = GenreDao();
  ActorDao mActorDao = ActorDao();

  /// Home Page State Variable
  List<MovieVO>? mNowPlayingMoviesList;
  List<MovieVO>? mPopularMoviesList;
  List<MovieVO>? mTopRatedMoviesList;
  List<MovieVO>? mMoviesByGenreList;
  List<GenreVO>? mGenresList;
  List<ActorVO>? mActors;

  /// Movie Details Page State Variable
  MovieVO? mMovieDetails;
  List<ActorVO>? cast;
  List<ActorVO>? crew;

  /// Network
  @override
  void getNowPlayingMovies(int page) {
    _dataAgent.getNowPlayingMovies(page).then((movies) async {
      List<MovieVO> nowPlayingMovies = movies!.map((movie) {
        movie.isNowPlaying = true;
        movie.isTopRated = false;
        movie.isPopular = false;
        return movie;
      }).toList();
      mMovieDao.saveMovies(nowPlayingMovies);
      mNowPlayingMoviesList = nowPlayingMovies;
      notifyListeners();
    });
  }

  @override
  void getPopularMovies(int page) {
    _dataAgent.getPopularMovies(page).then((movies) async {
      List<MovieVO> popularMovies = movies!.map((movie) {
        movie.isNowPlaying = false;
        movie.isTopRated = false;
        movie.isPopular = true;
        return movie;
      }).toList();
      mMovieDao.saveMovies(popularMovies);
      mPopularMoviesList = popularMovies;
      notifyListeners();
    });
  }

  @override
  void getTopRatedMovies(int page) {
    _dataAgent.getTopRatedMovies(page).then((movies) async {
      List<MovieVO> topRatedMovies = movies?.map((movie) {
        movie.isNowPlaying = false;
        movie.isTopRated = true;
        movie.isPopular = false;
        return movie;
      }).toList() ??
          [];
      mMovieDao.saveMovies(topRatedMovies);
      mTopRatedMoviesList = topRatedMovies;
      notifyListeners();
    });
  }

  @override
  void getActors(int page) {
    _dataAgent.getActors(page).then((actors) async {
      mActorDao.saveAllActors(actors ?? []);
      mActors = actors;
      notifyListeners();
      return Future.value(actors);
    });
  }

  @override
  void getGenres() {
    _dataAgent.getGenres().then((genres) async {
      mGenreDao.saveAllGenres(genres ?? []);
      mGenresList = genres;
      getMoviesByGenre(genres?.first.id ?? 0);
      notifyListeners();
      return Future.value(genres);
    });
  }

  @override
  void getMoviesByGenre(int genreId) {
    _dataAgent.getMoviesByGenre(genreId).then((movieByGenreList) {
      mMoviesByGenreList = movieByGenreList;
      notifyListeners();
    });
  }

  @override
  void getCreditsByMovie(int movieId) {
    _dataAgent.getCreditsByMovie(movieId).then((castAndCrew) {
      cast = castAndCrew.first;
      crew = castAndCrew[1];
      notifyListeners();
    });
  }

  @override
  void getMovieDetails(int movieId) {
    _dataAgent.getMovieDetails(movieId).then((movie) async {
      if (movie != null) {
        mMovieDao.saveSingleMovie(movie);
      }
      mMovieDetails = movie;
      notifyListeners();
      return Future.value(movie);
    });
  }

  /// Database

  @override
  void getNowPlayingMoviesFromDatabase() {
    getNowPlayingMovies(1);
    mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getNowPlayingMoviesStream())
        .combineLatest(mMovieDao.getNowPlayingMoviesStream(),
            (event, movieList) => movieList)
        .first
        .then((nowPlayingMovies) => mNowPlayingMoviesList = nowPlayingMovies);
    notifyListeners();
  }

  @override
  void getPopularMoviesFromDatabase() {
    getPopularMovies(1);
    mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getPopularMoviesStream())
        .combineLatest(
        mMovieDao.getPopularMoviesStream(), (event, movieList) => movieList)
        .first
        .then((popularMoviesList) => mPopularMoviesList = popularMoviesList);
    notifyListeners();
  }

  @override
  void getTopRatedMoviesFromDatabase() {
    getTopRatedMovies(1);
    mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getTopRatedMoviesStream())
        .combineLatest(mMovieDao.getTopRatedMoviesStream(),
            (event, movieList) => movieList)
        .first
        .then((topRatedMoviesList) => mTopRatedMoviesList = topRatedMoviesList);
    notifyListeners();
  }

  @override
  void getAllActorsFromDatabase() {
    mActors = mActorDao.getAllActors();
    notifyListeners();
  }

  @override
  void getGenresFromDatabase() {
    mGenresList = mGenreDao.getAllGenres();
    notifyListeners();
  }

  @override
  void getMovieDetailsFromDatabase(int movieId) {
    mMovieDetails = mMovieDao.getMovieById(movieId);
  }
}
