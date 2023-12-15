import 'dart:typed_data';

import '../model/user_model.dart';
import 'firebase_data_provider.dart';
import 'firebase_storage_data_provider.dart';

abstract interface class IAuthorizationRepository {
  Future<String> signInWithPhoneNumber(String phoneNumber);

  Future<void> otpSignIn({
    required String id,
    required String smsCode,
  });

  Future<UserModel?> getUser();

  Future<void> updateUser({
    required String displayName,
    required String avatarImageUrl,
  });

  Future<String> uploadImage({
    required String fileName,
    required Uint8List imageByteData,
  });

  Future<String> uploadVideo({
    required String fileName,
    required Uint8List videoByteData,
  });
}

class AuthorizationRepositoryImpl implements IAuthorizationRepository {
  const AuthorizationRepositoryImpl({
    required this.firebaseDataProvider,
    required this.firebaseStorageDataProvider,
  });

  final IFirebaseDataProvider firebaseDataProvider;
  final IFirebaseStorageDataProvider firebaseStorageDataProvider;

  @override
  Future<void> otpSignIn({required String id, required String smsCode}) =>
      firebaseDataProvider.otpSignIn(
        id: id,
        smsCode: smsCode,
      );

  @override
  Future<String> signInWithPhoneNumber(String phoneNumber) =>
      firebaseDataProvider.signInWithPhoneNumber(phoneNumber);

  @override
  Future<UserModel?> getUser() => firebaseDataProvider.getUser();

  @override
  Future<void> updateUser({
    required String displayName,
    required String avatarImageUrl,
  }) =>
      firebaseDataProvider.updateUser(
        displayName: displayName,
        avatarImageUrl: avatarImageUrl,
      );

  @override
  Future<String> uploadImage({
    required String fileName,
    required Uint8List imageByteData,
  }) =>
      firebaseStorageDataProvider.storeImage(
        fileName,
        imageByteData,
      );

  @override
  Future<String> uploadVideo({
    required String fileName,
    required Uint8List videoByteData,
  }) =>
      firebaseStorageDataProvider.storeVideo(
        fileName,
        videoByteData,
      );
}
