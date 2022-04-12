import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pattern_bloc/bloc/update_post_state.dart';
import 'package:pattern_bloc_http_service/pattern_bloc_http_service.dart';

class UpdatePostCubit extends Cubit<UpdatePostState> {
  UpdatePostCubit() : super(UpdatePostInit());

  void apiPostUpdate(Post post) async {
    emit(UpdatePostLoading());
    final response = await Network.POST(Network.API_UPDATE, Network.paramsUpdate(post));
    print(response);
    if (response != null) {
      emit(UpdatePostLoaded(post: post));
    } else {
      emit(UpdatePostError(error: "Could not Update post"));
    }
  }

}
