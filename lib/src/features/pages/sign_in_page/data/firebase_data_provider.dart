import 'package:firebase_auth/firebase_auth.dart';

abstract interface class IFirebaseRepository {
  Future<String?> signInWithPhoneNumber(String phoneNumber);

  Future<void> otpSignIn({
    required String id,
    required String smsCode,
  });
}

class FireBaseDataProviderImpl implements IFirebaseRepository {
  FireBaseDataProviderImpl() : _firebaseAuth = FirebaseAuth.instance;
  final FirebaseAuth _firebaseAuth;

  @override
  Future<void> otpSignIn({
    required String id,
    required String smsCode,
  }) {
    // TODO: implement otpSignIn
    throw UnimplementedError();
  }

  @override
  Future<String?> signInWithPhoneNumber(String phoneNumber) {
    // TODO: implement signInWithPhoneNumber
    throw UnimplementedError();
  }
}
