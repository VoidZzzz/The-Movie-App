import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_app/persistence/hive_constants.dart';

part 'collection_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_COLLECTION_VO, adapterName: "CollectionVOAdapter")
class CollectionVO{

  @HiveField(0)
  @JsonKey(name: "id")
  int? id;

  @HiveField(1)
  @JsonKey(name: "name")
  String? name;

  @HiveField(2)
  @JsonKey(name: "poster_path")
  String? posterPath;

  @HiveField(3)
  @JsonKey(name: "backdrop_path")
  String? backDropPath;

  CollectionVO(this.id, this.name, this.posterPath, this.backDropPath);

  factory CollectionVO.fromJson(Map<String, dynamic> json) => _$CollectionVOFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionVOToJson(this);
}