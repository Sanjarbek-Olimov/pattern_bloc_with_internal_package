import 'package:flutter/material.dart';
import 'package:pattern_bloc_http_service/model/post_model.dart';

import 'item_of_posts.dart';

Widget viewOfHome(List<Post> posts, bool isLoading){
  return Stack(
    children: [
      ListView.builder(
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int index) {
          return itemOfPosts(context, posts[index]);
        },
      ),
      isLoading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : Container(),
    ],
  );
}