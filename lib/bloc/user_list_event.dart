import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class FetchUserList extends UserEvent {
  const FetchUserList();

  @override
  List<Object> get props => [];
}
