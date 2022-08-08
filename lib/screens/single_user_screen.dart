import 'package:api_call_dio/models/single_user_response.dart';
import 'package:api_call_dio/models/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:api_call_dio/http_service.dart';

class SingleUserScreen extends StatefulWidget {
  @override
  _SingleUserScreenState createState() => _SingleUserScreenState();
}

class _SingleUserScreenState extends State<SingleUserScreen> {
  late HttpService http;
  late SingleUserResponse singleUserResponse;
  late User user;

  bool isLoading = false;

  Future getUser() async {
    Response response;
    try {
      isLoading = true;

      await Future.delayed(Duration(seconds: 1));
      var response = await Dio().get('https://jsonplaceholder.typicode.com/users/1');
      // response = await http.getRequest('users/2');
      // print(response.data);
      isLoading = false;

      if (response.statusCode == 200) {
        print("here");
        print(response.data);
        setState(() {
          user = User.fromJson(response.data);
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
          : user != null ? Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(height: 16,),
            Text("Hello, ${user.name} ${user.email}")
          ],
        ),
      ): Center(child : Text("No User Object")),
    );
  }
}