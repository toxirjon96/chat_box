import 'firebase_data_provider.dart';

abstract interface class IAuthorizationRepository {
  Future<String?> signInWithPhoneNumber(String phoneNumber);

  Future<void> otpSignIn({
    required String id,
    required String smsCode,
  });
}

class AuthorizationRepositoryImpl implements IAuthorizationRepository {
  const AuthorizationRepositoryImpl(this.firebaseDataProvider);

  final IFirebaseDataProvider firebaseDataProvider;

  @override
  Future<void> otpSignIn({required String id, required String smsCode}) =>
      firebaseDataProvider.otpSignIn(
        id: id,
        smsCode: smsCode,
      );

  @override
  Future<String?> signInWithPhoneNumber(String phoneNumber) =>
      firebaseDataProvider.signInWithPhoneNumber(phoneNumber);
}
