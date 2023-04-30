import 'package:flutter_test/flutter_test.dart';
import 'package:the_movie_app/bloc/details_bloc.dart';
import '../data_models/movie_model_imp_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  group("Movie Details Bloc Test", () {
    MovieDetailsBloc? movieDetailsBloc;

    setUp(() {
      movieDetailsBloc = MovieDetailsBloc(1, MovieModelImplMock());
    });

    test("Fetch Movie Details Test", () {
      expect(movieDetailsBloc?.mMovie, getMockMoviesForTest().first);
    });

    test("Fetch Creators Test", () {
      expect(movieDetailsBloc?.mCreatorsList?.contains(getMockCredits()[1][1]),
          true);
    });

    test("Fetch Actors Test", () {
      expect(movieDetailsBloc?.mActorsList?.contains(getMockCredits()[0][0]),
          true);
    });
  });
}
