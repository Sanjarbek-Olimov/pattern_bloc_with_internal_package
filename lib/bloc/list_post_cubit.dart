import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pattern_bloc/bloc/list_post_state.dart';
import 'package:pattern_bloc/pages/create_page.dart';
import 'package:pattern_bloc/pages/update_page.dart';
import 'package:pattern_bloc_http_service/pattern_bloc_http_service.dart';

class ListPostCubit extends Cubit<ListPostState> {
  ListPostCubit() : super(ListPostInit());

  void apiPostList() async {
    emit(ListPostLoading());
    final response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
    print(response);
    if (response != null) {
      emit(ListPostLoaded(
          posts: List<Post>.from(
              jsonDecode(response).map((x) => Post.fromJson(x)))));
    } else {
      emit(ListPostError(error: "Could not fetch posts"));
    }
  }

  void apiPostDelete(Post post) async {
    emit(ListPostLoading());
    final response =
        await Network.DELETE(Network.API_DELETE, Network.paramsEmpty());
    print(response);
    if (response != null) {
      apiPostList();
    } else {
      emit(ListPostError(error: "Could not delete post"));
    }
  }

  void callCreatePage(BuildContext context) async {
    var results = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => CreatePage()));
    if (results != null) {
      BlocProvider.of<ListPostCubit>(context).apiPostList();
    }
  }

  void callUpdatePage(BuildContext context, Post post) async {
    var results = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => UpdatePage(post: post)));
    if (results != null) {
      BlocProvider.of<ListPostCubit>(context).apiPostList();
    }
  }
}
