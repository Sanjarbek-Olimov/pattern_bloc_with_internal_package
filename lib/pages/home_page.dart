import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pattern_bloc/bloc/list_post_cubit.dart';
import 'package:pattern_bloc/bloc/list_post_state.dart';
import 'package:pattern_bloc/views/view_of_home.dart';
import 'package:pattern_bloc_http_service/pattern_bloc_http_service.dart';

class HomePage extends StatefulWidget {
  static const String id = "home_page";

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> posts = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ListPostCubit>(context).apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pattern - BloC"),
        centerTitle: true,
      ),
      body: BlocBuilder<ListPostCubit, ListPostState>(
        builder: (context, state) {
          if (state is ListPostError) {
            return viewOfHome(posts, true);
          }
          if (state is ListPostLoaded) {
            posts = state.posts!;
            return viewOfHome(posts, false);
          }
          return viewOfHome(posts, true);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<ListPostCubit>(context).callCreatePage(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
