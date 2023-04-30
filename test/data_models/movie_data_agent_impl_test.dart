import 'package:flutter_test/flutter_test.dart';
import 'package:the_movie_app/data/data.vos/movie_vo.dart';
import 'package:the_movie_app/data/models/movie_model_impl.dart';

import '../mock_data/mock_data.dart';
import '../network/movie_data_agent_impl_mock.dart';
import '../persistence/daos/actor_dao_impl_mock.dart';
import '../persistence/daos/genre_dao_impl_mock.dart';
import '../persistence/daos/movie_dao_impl_mock.dart';

void main() {
  group("movie_model_impl", () {
    var movieModel = MovieModelImpl();

    setUp(() {
      movieModel.setDaosAndDataAgents(
        MovieDaoImplMock(),
        ActorDaoImplMock(),
        GenreDaoImplMock(),
        MovieDataAgentImplMock(),
      );
    });

    test(
        "Saving Now Playing Movies and Getting Now Playing Movies from Database",
        () {
      expect(
        movieModel.getNowPlayingMoviesFromDatabase(),
        emits(
          [
            MovieVO(
                false,
                "/iJQIbOPm81fPEGKt5BPuZmfnA54.jpg",
                [16, 12, 10751, 14, 35],
                502356,
                "en",
                "The Super Mario Bros. Movie",
                "While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi are transported down a mysterious pipe and wander into a magical new world. But when the brothers are separated, Mario embarks on an epic quest to find Luigi.",
                6572.614,
                "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg",
                "2023-04-05",
                "The Super Mario Bros. Movie",
                false,
                7.5,
                1546,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                true,
                false,
                false),
          ],
        ),
      );
    });

    test("Saving Popular Movies and Getting Popular Movies from Database", () {
      expect(
        movieModel.getPopularMoviesFromDatabase(),
        emits(
          [
            MovieVO(
                false,
                "/nDxJJyA5giRhXx96q1sWbOUjMBI.jpg",
                [28, 35, 14],
                594767,
                "en",
                "Shazam! Fury of the Gods",
                "Billy Batson and his foster siblings, who transform into superheroes by saying \"Shazam!\", are forced to get back into action and fight the Daughters of Atlas, who they must stop from using a weapon that could destroy the world.",
                4274.232,
                "/2VK4d3mqqTc7LVZLnLPeRiPaJ71.jpg",
                "2023-03-15",
                "Shazam! Fury of the Gods",
                false,
                6.9,
                1231,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                false,
                true,
                false),
          ],
        ),
      );
    });

    // emits for Stream
    test("Saving TopRated Movies and Getting Top Rated Movies from Database",
        () {
      expect(
        movieModel.getPopularMoviesFromDatabase(),
        emits(
          [
            MovieVO(
                false,
                "/nDxJJyA5giRhXx96q1sWbOUjMBI.jpg",
                [28, 35, 14],
                594767,
                "en",
                "Shazam! Fury of the Gods",
                "Billy Batson and his foster siblings, who transform into superheroes by saying \"Shazam!\", are forced to get back into action and fight the Daughters of Atlas, who they must stop from using a weapon that could destroy the world.",
                4274.232,
                "/2VK4d3mqqTc7LVZLnLPeRiPaJ71.jpg",
                "2023-03-15",
                "Shazam! Fury of the Gods",
                false,
                6.9,
                1231,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                false,
                true,
                false),
          ],
        ),
      );
    });

    // completion equals for Future
    test("Get Genres Test", () {
      expect(
        movieModel.getGenres(),
        completion(
          equals(
            getMockGenres(),
          ),
        ),
      );
    });

    test("Get Actor Test", () {
      expect(
        movieModel.getActors(1),
        completion(
          equals(
            getMockActors(),
          ),
        ),
      );
    });

    test("Get Credit Test", () {
      expect(
        movieModel.getCreditsByMovie(1),
        completion(
          equals(
            getMockCredits(),
          ),
        ),
      );
    });

    test("Get Movie Details Test", () {
      expect(
        movieModel.getMovieDetails(1),
        completion(
          equals(
            getMockMoviesForTest().first,
          ),
        ),
      );
    });

    test("Get Actors From Database", () async {
      await movieModel.getActors(1);
      expect(
        movieModel.getAllActorsFromDatabase(),
        completion(
          equals(
            getMockActors(),
          ),
        ),
      );
    });

    test("Get Genres From Database", () async {
      await movieModel.getGenres();
      expect(
        movieModel.getGenresFromDatabase(),
        completion(
          equals(
            getMockGenres(),
          ),
        ),
      );
    });

    test("Get Movie Details From Database", () async {
      await movieModel.getMovieDetails(1);
      expect(
        movieModel.getMovieDetails(1),
        completion(
          equals(
            getMockMoviesForTest().first,
          ),
        ),
      );
    });
  });
}
