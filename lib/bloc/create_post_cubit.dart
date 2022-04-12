import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pattern_bloc/bloc/create_post_state.dart';
import 'package:pattern_bloc_http_service/pattern_bloc_http_service.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  CreatePostCubit() : super(CreatePostInit());

  void apiPostCreate(Post post) async {
    emit(CreatePostLoading());
    final response = await Network.POST(Network.API_CREATE, Network.paramsCreate(post));
    print(response);
    if (response != null) {
      emit(CreatePostLoaded(isCreated: true));
    } else {
      emit(CreatePostError(error: "Could not create post"));
    }
  }

}
