// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_genres_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetGenreResponse _$GetGenreResponseFromJson(Map<String, dynamic> json) =>
    GetGenreResponse(
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => GenreVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetGenreResponseToJson(GetGenreResponse instance) =>
    <String, dynamic>{
      'genres': instance.genres,
    };
