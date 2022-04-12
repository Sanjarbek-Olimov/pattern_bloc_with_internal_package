import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pattern_bloc/bloc/create_post_cubit.dart';
import 'package:pattern_bloc_http_service/model/post_model.dart';


Widget viewOfCreate(
    bool isLoading,
    BuildContext context,
    TextEditingController titleController,
    TextEditingController bodyController) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Create post"),
      centerTitle: true,
      actions: [
        TextButton(
            onPressed: () {
              Post post = Post(
                  title: titleController.text.toString(),
                  body: bodyController.text.toString(),
                  userId: 1);
              BlocProvider.of<CreatePostCubit>(context).apiPostCreate(post);
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
                  controller: titleController,
                  maxLines: null,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 20),
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 10, top: 10),
                      hintText: "Title"),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: bodyController,
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
