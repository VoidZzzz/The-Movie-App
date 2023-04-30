import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_app/data/data.vos/production_company_vo.dart';
import 'package:the_movie_app/data/data.vos/production_country_vo.dart';
import 'package:the_movie_app/data/data.vos/spoken_language_vo.dart';
import '../../persistence/hive_constants.dart';
import 'collection_vo.dart';
import 'genre_vo.dart';

part 'movie_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_MOVIE_VO, adapterName: "MovieVOAdapter")
class MovieVO {

  @JsonKey(name: "adult")
  @HiveField(0)
  bool? adult;

  @HiveField(1)
  @JsonKey(name: "backdrop_path")
  String? backDropPath;

  @HiveField(2)
  @JsonKey(name: "genre_ids")
  List<int>? genreIds;

  @HiveField(3)
  @JsonKey(name: "id")
  int? id;

  @HiveField(4)
  @JsonKey(name: "original_language")
  String? originalLanguage;

  @HiveField(5)
  @JsonKey(name: "original_title")
  String? originalTitle;

  @HiveField(6)
  @JsonKey(name: "overview")
  String? overview;

  @HiveField(7)
  @JsonKey(name: "popularity")
  double? popularity;

  @HiveField(8)
  @JsonKey(name: "poster_path")
  String? posterPath;

  @HiveField(9)
  @JsonKey(name: "release_date")
  String? releaseDate;

  @HiveField(10)
  @JsonKey(name: "title")
  String? title;

  @HiveField(11)
  @JsonKey(name: "video")
  bool? video;

  @HiveField(12)
  @JsonKey(name: "vote_average")
  double? voteAverage;

  @HiveField(13)
  @JsonKey(name: "vote_count")
  int? voteCount;

  @HiveField(14)
  @JsonKey(name: "belongs_to_collection")
  CollectionVO? belongsToCollection;

  @HiveField(15)
  @JsonKey(name: "budget")
  double? budget;

  @HiveField(16)
  @JsonKey(name: "genres")
  List<GenreVO>? genres;

  @HiveField(17)
  @JsonKey(name: "homepage")
  String? homepage;

  @HiveField(18)
  @JsonKey(name: "imdb_id")
  String? imdbId;

  @HiveField(19)
  @JsonKey(name: "production_companies")
  List<ProductionCompanyVO>? productionCompanies;

  @HiveField(20)
  @JsonKey(name: "production_countries")
  List<ProductionCountryVO>? productionCountries;

  @HiveField(21)
  @JsonKey(name: "revenue")
  int? revenue;

  @HiveField(22)
  @JsonKey(name: "runtime")
  int? runTime;

  @HiveField(23)
  @JsonKey(name: "spoken_languages")
  List<SpokenLanguageVO>? spokenLanguages;

  @HiveField(24)
  @JsonKey(name: "status")
  String? status;

  @HiveField(25)
  @JsonKey(name: "tagline")
  String? tagline;

  @HiveField(26)
  bool? isNowPlaying;

  @HiveField(27)
  bool? isPopular;

  @HiveField(28)
  bool? isTopRated;

  MovieVO(
      this.adult,
      this.backDropPath,
      this.genreIds,
      this.id,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount,
      this.belongsToCollection,
      this.budget,
      this.genres,
      this.homepage,
      this.imdbId,
      this.productionCompanies,
      this.productionCountries,
      this.revenue,
      this.runTime,
      this.spokenLanguages,
      this.status,
      this.tagline,
      this.isNowPlaying,
      this.isPopular,
      this.isTopRated);

  factory MovieVO.fromJson(Map<String, dynamic> json) =>
      _$MovieVOFromJson(json);

  Map<String, dynamic> toJson() => _$MovieVOToJson(this);

  List<String> getGenreListAsStringList() {
    return genres?.map((genre) => genre.name ?? "").toList() ?? [];
  }

  String getGenreListAsCommaSeparatedString() {
    return genres?.map((genre) => genre.name ?? "").toList().join(",") ?? "";
  }

  String getProductionCountriesAsCommaSeparatedString() {
    return productionCountries
            ?.map((country) => country.name ?? "")
            .toList()
            .join(",") ??
        "";
  }


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieVO &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title;

  @override
  int get hashCode => id.hashCode ^ title.hashCode;

  @override
  String toString() {
    return 'MovieVO{adult: $adult, backDropPath: $backDropPath, genreIds: $genreIds, id: $id, originalLanguage: $originalLanguage, originalTitle: $originalTitle, overview: $overview, popularity: $popularity, posterPath: $posterPath, releaseDate: $releaseDate, video: $video, voteAverage: $voteAverage, voteCount: $voteCount}';
  }
}
