import 'package:api_call_dio/models/post.dart';
import 'package:api_call_dio/services/data_provider_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PostsView extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();

  final int userId;

  const PostsView({
    required this.userId
  });
}

class _UsersScreenState extends State<PostsView> {
  late DataProvider _dataProvider;
  late Post post;
  late List<Post> postList;
  late List<Post> filteredPost;

  bool isLoading = false;

  Future getPost() async {
    Response response;
    try {

      isLoading = true;
      await Future.delayed(Duration(seconds: 1));
      final List<Post> posts = await _dataProvider.getPost('posts');
      isLoading = false;
      final filteredPost = posts.where((post) {
        return post.userId == widget.userId;
      }).toList();

      setState(() {
        postList = filteredPost;
      });

    } on Exception catch (e) {
      isLoading = false;
      print(e);
    }
  }

  @override
  void initState() {
    _dataProvider = DataProvider();
    getPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : postList != null ? ListView.builder(
          itemCount: postList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
              child: Card(
                child: ListTile(
                  onTap: () {},
                  title: Text(postList[index].title),
                  subtitle: Text(postList[index].description),
                ),
              ),
            );
          }
      ): Center(child : Text("No Post Object")),
    );
  }
}