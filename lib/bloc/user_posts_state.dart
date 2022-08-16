import 'package:api_call_dio/models/post.dart';
import 'package:equatable/equatable.dart';

abstract class PostState extends Equatable {
  const PostState();
}

class PostInitial extends PostState {
  @override
  List<Object> get props => [];
}

class PostListProcessing extends PostState {
  @override
  List<Object> get props => [];
}

class PostLoaded extends PostState {
  final List<Post> posts;

  const PostLoaded({required this.posts});

  @override
  List<Object?> get props => [posts];
}

class PostNoInternetState extends PostState {
  @override
  List<Object> get props => [];
}