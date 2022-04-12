import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pattern_bloc/bloc/update_post_cubit.dart';
import 'package:pattern_bloc_http_service/pattern_bloc_http_service.dart';

Widget viewOfUpdate(
    bool isLoading,
    BuildContext context,
    TextEditingController titleController,
    TextEditingController bodyController,
    Post post) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Update post"),
      centerTitle: true,
      actions: [
        TextButton(
            onPressed: () {
              Post postUpdate = Post(
                  title: titleController.text.toString(),
                  body: bodyController.text.toString(),
                  userId: post.userId,
                  id: post.id);
              BlocProvider.of<UpdatePostCubit>(context)
                  .apiPostUpdate(postUpdate);
            },
            child: const Text(
              "Save",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ))
      ],
    ),
    body: Stack(
      children: [
        SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: titleController..text = post.title!,
                  maxLines: null,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 20),
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 10, top: 10),
                      hintText: "Title"),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: bodyController..text = post.body!,
                  maxLines: null,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      hintText: "Body",
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                ),
              ],
            ),
          ),
        ),
        isLoading
            ? const Center(child: CircularProgressIndicator.adaptive())
            : const SizedBox.shrink(),
      ],
    ),
  );
}
