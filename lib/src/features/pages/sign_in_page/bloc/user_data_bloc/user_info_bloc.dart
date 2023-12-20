import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/util/logger.dart';
import '../../model/user_model.dart';
import '../../repository/authorization_repository.dart';

part 'user_info_event.dart';

part 'user_info_state.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  UserInfoBloc({required IAuthorizationRepository repository})
      : _repository = repository,
        super(const InitialUserState()) {
    on<UserInfoEvent>(
      (event, emit) => switch (event) {
        UploadImageEvent event => _uploadImage(event, emit),
        SaveUserDataEvent event => _save(event, emit),
      },
    );
  }

  final IAuthorizationRepository _repository;

  Future<void> _uploadImage(
      UploadImageEvent event, Emitter<UserInfoState> emit) async {
    try {
      emit(const UserInfoState.loading());

      final avatarImageUrl = await _repository.uploadImage(
        fileName: event.fileName,
        imageByteData: event.imageByteData,
      );

      emit(UserInfoState.imageUploaded(avatarImageUrl));
    } catch (error, stackTrace) {
      fatal(error, stackTrace);
      emit(const UserInfoState.error('Something went wrong'));
    }
  }

  Future<void> _save(
      SaveUserDataEvent event, Emitter<UserInfoState> emit) async {
    try {
      emit(const UserInfoState.loading());

      await _repository.updateUser(
        displayName: event.displayName,
        avatarImageUrl: event.avatarImageUrl,
      );
      UserModel? user = await _repository.getUser();
      while (user == null) {
        Future.delayed(const Duration(milliseconds: 100));
      }
      emit(UserInfoState.saved(user));
    } catch (error, stackTrace) {
      fatal(error, stackTrace);
      emit(const UserInfoState.error('Something went wrong'));
    }
  }
}
