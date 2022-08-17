import 'package:api_call_dio/bloc/user_posts_bloc.dart';
import 'package:api_call_dio/bloc/user_posts_state.dart';
import 'package:api_call_dio/models/post.dart';
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
      onRefresh: refresh,
      child: Scaffold(
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
                      color: Colors.lightBlueAccent,
                    ),
                    margin: const EdgeInsets.only(bottom: 10.0),
                    child: ListTile(
                      title: Text('${filteredPosts[index].title}', style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white, fontSize: 20),),
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
      ),
    );
  }
}