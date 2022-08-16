import 'package:api_call_dio/bloc/user_posts_bloc.dart';
import 'package:api_call_dio/bloc/user_posts_state.dart';
import 'package:api_call_dio/models/post.dart';
import 'package:api_call_dio/services/data_provider_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsView extends StatefulWidget {
  @override
  _PostViewState createState() => _PostViewState();
  final int userId;

  const PostsView({
    required this.userId
  });
}

class _PostViewState extends State<PostsView> {
  late PostBloc postBloc;

  @override
  void initState() {
    super.initState();
    postBloc = BlocProvider.of<PostBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
    postBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostInitial) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is PostListProcessing) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is PostLoaded) {
            List <Post> filteredPosts = state.posts.where((post) => post.userId == widget.userId).toList();
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: filteredPosts.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.amber[300],
                  ),
                  margin: const EdgeInsets.only(bottom: 10.0),
                  child: ListTile(
                    title: Text('${filteredPosts[index].title}'),
                    subtitle: Text('${filteredPosts[index].description}'),
                  )
                );
              },

            );
          }
          if (state is PostNoInternetState) {
            return Center(
              child: Text('Kindly connect to the internet to get this service'),
            );
          }
          return Center(
            child: Text('Something is wrong. Please try again or contact support.')
          );
        },
      ),
    );
  }
}