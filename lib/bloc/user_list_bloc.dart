import 'package:api_call_dio/models/user.dart';
import 'package:api_call_dio/services/data_provider_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_list_event.dart';
import 'user_list_state.dart';
import 'package:api_call_dio/services/connectivityService.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final DataProvider _dataProvider;
  final ConnectivityService _connectivityService;

  UserBloc(this._dataProvider, this._connectivityService) : super(UserListProcessing()) {
    _connectivityService.connectivityStream.stream.listen((event) {
      if (event == ConnectivityResult.none) {
        print('no internet');
        add(NoInternetEvent());
      } else {
        print('yes internet');
        add(FetchUserList());
      }
    });

    on<FetchUserList>((event, emit) async {
      emit(UserInitial());
      final List<User> users = await _dataProvider.getUser('users');
      emit(UserLoaded(users: users));
    });

    on<NoInternetEvent>((event, emit) {
      emit(UserNoInternetState());
    });
  }
}
