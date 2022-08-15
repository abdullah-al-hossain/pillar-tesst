// @dart=2.9
import 'package:api_call_dio/services/connectivityService.dart';
import 'package:api_call_dio/services/data_provider_service.dart';
import 'package:api_call_dio/views/users_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/user_list_bloc.dart';
import 'bloc/user_list_event.dart';
import 'services/connectivityService.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  DataProvider _dataProvider = DataProvider();
  ConnectivityService _connectivityService = ConnectivityService();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Pillar Test'),
        ),
        body: BlocProvider(
          create: (context) =>
          UserBloc(_dataProvider, _connectivityService)..add(FetchUserList()),
          child: UsersView(),
        ),
      ),
    );
  }
}
