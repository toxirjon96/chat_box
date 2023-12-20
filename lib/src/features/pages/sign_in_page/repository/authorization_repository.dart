import 'dart:typed_data';

import '../../../../common/data_provider/database_data_provider.dart';
import '../../../../common/data_provider/fire_store_data_provider.dart';
import '../model/user_model.dart';
import '../../../../common/data_provider/firebase_data_provider.dart';
import '../../../../common/data_provider/firebase_storage_data_provider.dart';

abstract interface class IAuthorizationRepository {
  Future<String> signInWithPhoneNumber(String phoneNumber);

  Future<void> otpSignIn({
    required String id,
    required String smsCode,
  });

  Future<void> logout();

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
  Future<List<UserModel>> getUsers();
}

class AuthorizationRepositoryImpl implements IAuthorizationRepository {
  const AuthorizationRepositoryImpl({
    required this.firebaseDataProvider,
    required this.firebaseStorageDataProvider,
    required this.fireStoreDataProvider,
    required this.databaseDataProvider,
  });

  final IFirebaseDataProvider firebaseDataProvider;
  final IFirebaseStorageDataProvider firebaseStorageDataProvider;
  final IFireStoreDataProvider fireStoreDataProvider;
  final IDatabaseDataProvider databaseDataProvider;

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
  }) async {
    await firebaseDataProvider.updateUser(
      displayName: displayName,
      avatarImageUrl: avatarImageUrl,
    );

    final user = await firebaseDataProvider.getUser();

    if (user != null){
      await fireStoreDataProvider.storeUserData(user);
      await databaseDataProvider.saveUser(user);
    }
  }

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

  @override
  Future<void> logout() async {
    firebaseDataProvider.logout();
  }

  @override
  Future<List<UserModel>> getUsers() => fireStoreDataProvider.getUsers();
}
