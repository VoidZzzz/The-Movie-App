import 'package:json_annotation/json_annotation.dart';
import '../../data/data.vos/genre_vo.dart';

part 'get_genres_responses.g.dart';

@JsonSerializable()
class GetGenreResponse{
  @JsonKey(name: "genres")
  List<GenreVO>? genres;

  GetGenreResponse({required this.genres});

  factory GetGenreResponse.fromJson(Map<String, dynamic> json) => _$GetGenreResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetGenreResponseToJson(this);
}