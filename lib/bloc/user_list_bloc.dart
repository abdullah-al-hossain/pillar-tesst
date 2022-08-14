import 'package:api_call_dio/services/data_provider_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:api_call_dio/models/user.dart';
import 'user_list_event.dart';
import 'user_list_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  late DataProvider dataProvider;

  UserBloc({required this.dataProvider});

  @override
  UserState get initialState => UserInitial();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is FetchUserList) {
      yield UserListProcessing();
      try {
        final List<User> users = await dataProvider.getUser('users');
        yield UserLoaded(users: users);
      } catch (_) {
        yield Error();
      }
    }
  }
}
