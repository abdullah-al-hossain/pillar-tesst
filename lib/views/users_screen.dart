import 'package:api_call_dio/models/user.dart';
import 'package:api_call_dio/views/user_posts.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:api_call_dio/services/http_service.dart';
import 'dart:convert';

class UsersView extends StatefulWidget {
  @override
  _UsersViewState createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  late HttpService _httpService;
  late User user;
  late List<User> userList;

  bool isLoading = false;

  Future getUser() async {
    Response response;
    try {
      isLoading = true;
      await Future.delayed(Duration(seconds: 1));
      final List<User> users = await _httpService.getUser('users');
      isLoading = false;

      setState(() {
        userList = users;
      });

    } on Exception catch (e) {
      isLoading = false;
      print(e);
    }
  }

  @override
  void initState() {

    _httpService = HttpService();
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : userList != null ? ListView.builder(
          itemCount: userList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
              child: Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PostsView(userId: userList[index].id)),
                    );
                  },
                  title: Text(userList[index].name),
                  leading: CircleAvatar(
                    backgroundImage:
                    AssetImage('assets/images/default_avatar.png'),
                  ),
                ),
              ),
            );
          }
      ): Center(child : Text("No User Object")),
    );
  }
}