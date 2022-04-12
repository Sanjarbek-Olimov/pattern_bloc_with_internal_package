import 'package:equatable/equatable.dart';
import 'package:pattern_bloc_http_service/pattern_bloc_http_service.dart';

abstract class UpdatePostState extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdatePostInit extends UpdatePostState {}

class UpdatePostLoading extends UpdatePostState {}

class UpdatePostLoaded extends UpdatePostState {
  final Post post;
  UpdatePostLoaded({required this.post});
}

class UpdatePostError extends UpdatePostState {
  final error;

  UpdatePostError({this.error});
}
