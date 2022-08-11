import 'package:api_call_dio/models/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:api_call_dio/http_service.dart';
import 'dart:convert';

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  late HttpService _httpService;
  late User user;
  late List<User> userList;

  bool isLoading = false;

  Future getUser() async {
    Response response;
    try {
      isLoading = true;
      await Future.delayed(Duration(seconds: 1));
      final List<User> users = await _httpService.getRequest('users');
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
                  onTap: () {},
                  title: Text(userList[index].name),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/something.jpg'),
                  ),
                ),
              ),
            );
          }
      ): Center(child : Text("No User Object")),
    );
  }
}