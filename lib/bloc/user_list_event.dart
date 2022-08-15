import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class FetchUserList extends UserEvent {
  @override
  List<Object> get props => [];
}

class NoInternetEvent extends UserEvent {
  @override
  List<Object?> get props => [];
}