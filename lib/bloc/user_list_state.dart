import 'package:equatable/equatable.dart';
import 'package:api_call_dio/models/user.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserListProcessing extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoaded extends UserState {
  final List<User> users;

  const UserLoaded({required this.users});

  @override
  List<Object> get props => [users];
}

class Error extends UserState {
  @override
  List<Object> get props => [];
}