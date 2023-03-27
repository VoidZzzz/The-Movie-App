import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_app/persistence/hive_constants.dart';

part 'production_company_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_PRODUCTION_COMPANY_VO, adapterName: "ProductionCompanyVOAdapter")
class ProductionCompanyVO{

  @JsonKey(name: "id")
  @HiveField(0)
  int? id;

  @HiveField(1)
  @JsonKey(name: "logo_path")
  String? logoPath;

  @HiveField(2)
  @JsonKey(name: "name")
  String? name;

  @HiveField(3)
  @JsonKey(name: "origin_country")
  String? originCountry;

  ProductionCompanyVO(this.id, this.logoPath, this.name, this.originCountry);

  factory ProductionCompanyVO.fromJson(Map<String, dynamic> json) => _$ProductionCompanyVOFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCompanyVOToJson(this);
}