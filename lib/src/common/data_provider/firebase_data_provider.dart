import 'package:firebase_auth/firebase_auth.dart';

import '../../features/pages/sign_in_page/model/user_model.dart';

abstract interface class IFirebaseDataProvider {
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
}

class FireBaseDataProviderImpl implements IFirebaseDataProvider {
  FireBaseDataProviderImpl() : _firebaseAuth = FirebaseAuth.instance;
  final FirebaseAuth _firebaseAuth;

  @override
  Future<void> otpSignIn({
    required String id,
    required String smsCode,
  }) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: id,
      smsCode: smsCode,
    );
    await _firebaseAuth.signInWithCredential(credential);
  }

  @override
  Future<String> signInWithPhoneNumber(String phoneNumber) async {
    String? id;
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 120),
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        id = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    while (id == null) {
      await Future.delayed(const Duration(milliseconds: 100));
    }

    return id!;
  }

  @override
  Future<UserModel?> getUser() async {
    final firebaseUser = _firebaseAuth.currentUser;

    if (firebaseUser != null) {
      final user = UserModel(
        id: firebaseUser.uid,
        displayName: firebaseUser.displayName,
        avatarImage: firebaseUser.photoURL,
        phoneNumber: firebaseUser.phoneNumber,
      );

      return user;
    }

    return null;
  }

  @override
  Future<void> updateUser({
    required String displayName,
    required String avatarImageUrl,
  }) async {
    final firebaseUser = _firebaseAuth.currentUser;

    if (firebaseUser != null) {
      await firebaseUser.updateDisplayName(displayName);
      await firebaseUser.updatePhotoURL(avatarImageUrl);
    }
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
