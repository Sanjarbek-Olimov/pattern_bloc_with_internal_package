import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pattern_bloc/bloc/update_post_cubit.dart';
import 'package:pattern_bloc/bloc/update_post_state.dart';
import 'package:pattern_bloc/views/view_of_update.dart';
import 'package:pattern_bloc_http_service/pattern_bloc_http_service.dart';

class UpdatePage extends StatefulWidget {
  static const String id = "update_page";

  Post post;

  UpdatePage({Key? key, required this.post}) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  _finish(BuildContext context) {
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      Navigator.pop(context, 'result');
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdatePostCubit(),
      child: Scaffold(body: BlocBuilder<UpdatePostCubit, UpdatePostState>(
        builder: (BuildContext context, UpdatePostState state) {
          if (state is UpdatePostLoading) {
            return viewOfUpdate(
                true, context, titleController, bodyController, widget.post);
          }
          if (state is UpdatePostLoaded) {
            _finish(context);
          }
          if (state is UpdatePostError) {}
          return viewOfUpdate(
              false, context, titleController, bodyController, widget.post);
        },
      )),
    );
  }
}
