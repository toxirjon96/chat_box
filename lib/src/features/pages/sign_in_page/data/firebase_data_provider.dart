import 'package:firebase_auth/firebase_auth.dart';

abstract interface class IFirebaseDataProvider {
  Future<String?> signInWithPhoneNumber(String phoneNumber);

  Future<void> otpSignIn({
    required String id,
    required String smsCode,
  });
}

class FireBaseDataProviderImpl implements IFirebaseDataProvider {
  FireBaseDataProviderImpl() : _firebaseAuth = FirebaseAuth.instance;
  final FirebaseAuth _firebaseAuth;

  @override
  Future<void> otpSignIn({
    required String id,
    required String smsCode,
  }) async{
    final credential = PhoneAuthProvider.credential(
      verificationId: id,
      smsCode: smsCode,
    );
    await _firebaseAuth.signInWithCredential(credential);
  }

  @override
  Future<String?> signInWithPhoneNumber(String phoneNumber) async{
    String? id;
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 120),
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        print('------------------------1$verificationId-------------------------------');
        id = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print('------------------------2$verificationId-------------------------------');
        id = verificationId;
      },
    );
    print('------------------------3$id-------------------------------');

    return id;
  }
}
