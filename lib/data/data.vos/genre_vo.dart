import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../persistence/hive_constants.dart';
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GenreVO &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  factory GenreVO.fromJson(Map<String, dynamic> json) => _$GenreVOFromJson(json);

  Map<String, dynamic> toJson() => _$GenreVOToJson(this);


}