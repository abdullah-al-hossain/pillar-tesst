import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  @JsonKey(name: "userId")
  late int userId;

  @JsonKey(name: "title")
  late String title;

  @JsonKey(name: "body")
  late String description;

  Post();

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  /// Connect the generated [_$PostToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PostToJson(this);

}