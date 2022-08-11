import 'package:api_call_dio/models/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:api_call_dio/http_service.dart';
import 'dart:convert';

class SingleUserScreen extends StatefulWidget {
  @override
  _SingleUserScreenState createState() => _SingleUserScreenState();
}

class _SingleUserScreenState extends State<SingleUserScreen> {
  late HttpService http;
  late User user;

  bool isLoading = false;

  Future getUser() async {
    Response response;
    try {
      isLoading = true;

      await Future.delayed(Duration(seconds: 1));
      var response = await Dio().get('https://jsonplaceholder.typicode.com/users');
      // response = await http.getRequest('users/2');
      // print(response.data);
      isLoading = false;

      if (response.statusCode == 200) {
        print("here");

        userList = response.data;

        print(userList);

        setState(() {
          userList = json.decode(response.data);
        });

      } else {
        print("There is some problem status code not 200");
      }
    } on Exception catch (e) {
      isLoading = false;
      print(e);
    }
  }

  @override
  void initState() {

    http = HttpService();

    getUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get Single user"),
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
                  title: Text(userList[index].name<String,dynamic>()),
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