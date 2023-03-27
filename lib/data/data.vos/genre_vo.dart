import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_app/persistence/hive_constants.dart';

part 'genre_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_GENRE_VO, adapterName: "GenreVOAdapter")
class GenreVO{

  @JsonKey(name: "id")
  @HiveField(0)
  int? id;

  @HiveField(1)
  @JsonKey(name: "name")
  String? name;

  GenreVO({required this.id, required this.name});

  factory GenreVO.fromJson(Map<String, dynamic> json) => _$GenreVOFromJson(json);

  Map<String, dynamic> toJson() => _$GenreVOToJson(this);


}