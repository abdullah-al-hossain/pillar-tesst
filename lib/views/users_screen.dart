import 'package:api_call_dio/bloc/user_list_bloc.dart';
import 'package:api_call_dio/bloc/user_list_state.dart';
import 'package:api_call_dio/views/user_posts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersView extends StatefulWidget {
  @override
  _UsersViewState createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  late UserBloc userBloc;

  @override
  void initState() {
    userBloc = BlocProvider.of<UserBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
    userBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserNoInternetState) {
          return Center(
            child: Center(
              child: Text('Please check your internet connection and try again'),
            ),
          );
        }
        if (state is UserInitial) {
          return Center(
            child: Text('No user found yet.'),
          );
        }
        if (state is UserListProcessing) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is UserLoaded) {
          return ListView.builder(
            itemCount: state.users.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${state.users[index].name}'),
                subtitle: Text('${state.users[index].username}'),
                leading: CircleAvatar(
                  backgroundImage:
                  AssetImage('assets/images/default_avatar.png'),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PostsView(userId: state.users[index].id)),
                  );
                },
              );
            },
          );
        }

        return Text('Something went wrong!');
      },
    );
  }
}