import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  @JsonKey(name: "userId")
  late int id;

  @JsonKey(name: "title")
  late String email;

  @JsonKey(name: "description")
  late String name;

  Post();

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  /// Connect the generated [_$PostToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PostToJson(this);

}