import 'package:the_movie_app/data/data.vos/genre_vo.dart';
import 'package:the_movie_app/persistence/daos/genre_dao.dart';

class GenreDaoImplMock extends GenreDao {
  Map<int?, GenreVO> genreListFromDatabaseMock = {};

  @override
  List<GenreVO> getAllGenres() {
    return genreListFromDatabaseMock.values.toList();
  }

  @override
  void saveAllGenres(List<GenreVO> genreList) {
    genreList.forEach((genre) {
      genreListFromDatabaseMock[genre.id] = genre;
    });
  }
}
