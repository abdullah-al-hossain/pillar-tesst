import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
}

class FetchPostList extends PostEvent {
  @override
  List<Object> get props => [];
}

class NoInternetEvent extends PostEvent {
  @override
  List<Object?> get props => [];
}