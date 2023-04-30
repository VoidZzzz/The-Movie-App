import 'package:flutter_test/flutter_test.dart';
import 'package:the_movie_app/bloc/home_bloc.dart';

import '../data_models/movie_model_imp_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  group("Home Bloc Test", () {
    HomeBloc? homeBloc;

    // why initialize in setUp()? because setUp Function reruns on every test run(e.g build method on every hot reload).
    // So, we get refreshed instance every single time we run a test. Refreshed Instance is needed when there are coupling between tests.
    setUp(() {
      homeBloc = HomeBloc(MovieModelImplMock());
    });

    test("Fetch Now Playing Movie Test", () {
      expect(
          homeBloc?.mNowPlayingMoviesList?.contains(getMockMoviesForTest()[0]),
          true);
    });

    test("Fetch Popular Movie Test", () {
      expect(homeBloc?.mPopularMoviesList?.contains(getMockMoviesForTest()[1]),
          true);
    });

    test("Fetch TopRated Movie Test", () {
      expect(homeBloc?.mTopRatedMoviesList?.contains(getMockMoviesForTest()[2]),
          true);
    });

    test("Fetch Genres Test", () {
      expect(homeBloc?.mGenresList?.contains(getMockGenres().first), true);
    });

    // mMoviesByGenre is a double future function. TimeDelay is needed when using double future or first future return might be null
    test("Fetch Initial Movies by Genre Test", () async {
      await Future.delayed(const Duration(milliseconds: 500));
      expect(homeBloc?.mMoviesByGenre?.contains(getMockMoviesForTest().first),
          true);
    });

    test("Fetch Actors Test", () {
      expect(homeBloc?.mActorList?.contains(getMockActors().first), true);
    });

    test("Fetch Movies by Genre on User Action Test", () async {
      homeBloc?.onChooseGenres(3); // <======= To Simulate user Action
      await Future.delayed(const Duration(milliseconds: 500));
      expect(homeBloc?.mMoviesByGenre?.contains(getMockMoviesForTest().last),
          true);
    });
  });
}
