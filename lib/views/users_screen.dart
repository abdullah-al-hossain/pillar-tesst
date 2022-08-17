import 'dart:async';

import 'package:api_call_dio/bloc/user_list_bloc.dart';
import 'package:api_call_dio/bloc/user_list_state.dart';
import 'package:api_call_dio/bloc/user_posts_bloc.dart';
import 'package:api_call_dio/bloc/user_posts_event.dart';
import 'package:api_call_dio/services/connectivityService.dart';
import 'package:api_call_dio/services/data_provider_service.dart';
import 'package:api_call_dio/views/user_posts_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersView extends StatefulWidget {
  @override
  _UsersViewState createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  late UserBloc userBloc;
  late GlobalKey<RefreshIndicatorState> refreshKey;

  @override
  void initState() {
    userBloc = BlocProvider.of<UserBloc>(context);
    refreshKey = GlobalKey<RefreshIndicatorState>();
  }

  @override
  void dispose() {
    super.dispose();
    userBloc.close();
  }

  Future<void> refresh() async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Page Reloaded"),
      duration: Duration(seconds: 1),
    ));

    return Future.delayed(
      Duration(seconds: 1)
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      displacement: 50,
      onRefresh: refresh,
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserInitial) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UserListProcessing) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UserNoInternetState) {
            return Center(
              child: Center(
                child: Text('Please check your internet connection and try again'),
              ),
            );
          }
          if (state is UserLoaded) {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                DataProvider _dataProvider = DataProvider();
                ConnectivityService _connectivityService = ConnectivityService();

                return ListTile(
                  title: Text('${state.users[index].name}'),
                  subtitle: Text('${state.users[index].email}'),
                  leading: CircleAvatar(
                    backgroundImage:
                    AssetImage('assets/images/default_avatar.png'),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) {
                            return BlocProvider(
                              create: (context) => PostBloc(
                                  _dataProvider,
                                  _connectivityService
                              )..add(FetchPostList()),
                              child: PostsView(userId: state.users[index].id),
                            );
                          }
                      ),
                    );
                  },
                );
              },
            );
          }

          return Center(
              child: Text('Something went wrong!'),
          );
        },
      ),
    );
  }
}