import 'package:api_call_dio/models/post.dart';
import 'package:api_call_dio/services/data_provider_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_posts_event.dart';
import 'user_posts_state.dart';
import 'package:api_call_dio/services/connectivityService.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final DataProvider _dataProvider;
  final ConnectivityService _connectivityService;

  PostBloc(this._dataProvider, this._connectivityService) : super(PostInitial()) {
    _connectivityService.connectivityStream.stream.listen((event) {
      if (event == ConnectivityResult.none) {
        print('No internet');
        add(NoInternetEvent());
      } else {
        print('Yes internet');
        add(FetchPostList());
      }
    });

    on<FetchPostList>((event, emit) async {
        if (event is FetchPostList) {
          try {
            emit(PostInitial());
            final List<Post> posts = await _dataProvider.getPost('posts');
            emit(PostLoaded(posts: posts));
          } catch (_) {
            emit(PostNoInternetState());
          }
        }

    });

    on<NoInternetEvent>((event, emit) {
      emit(PostNoInternetState());
    });
  }
}
