// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post()
  ..id = json['userId'] as int
  ..email = json['title'] as String
  ..name = json['description'] as String;

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'userId': instance.id,
      'title': instance.email,
      'description': instance.name,
    };
