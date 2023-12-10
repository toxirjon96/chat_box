import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../main_page/main_page.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    required this.verificationId,
    super.key,
  });

  final String verificationId;

  @override
  State<StatefulWidget> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String smsCode = '';

  void otpVerification() async {
    print('\n' * 5);
    print('otpVerification');
    print('\n' * 5);

    final auth = FirebaseAuth.instance;

    final credential = PhoneAuthProvider.credential(
      verificationId: widget.verificationId,
      smsCode: smsCode,
    );
    try {
      final result = await auth.signInWithCredential(credential);
      print('\n' * 5);
      print('signInWithCredential');
      print(result);
      print('\n' * 5);

      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MainPage(),
          ),
        );
      }
    } catch (e) {
      print('\n' * 5);
      print(e);
      print('\n' * 5);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Pinput(
                length: 6,
                defaultPinTheme: PinTheme(
                  width: 56,
                  height: 56,
                  textStyle: const TextStyle(
                    fontSize: 20,
                    color: Color.fromRGBO(30, 60, 87, 1),
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromRGBO(234, 239, 243, 1)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                focusedPinTheme: PinTheme(
                  width: 56,
                  height: 56,
                  textStyle: const TextStyle(
                    fontSize: 20,
                    color: Color.fromRGBO(30, 60, 87, 1),
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromRGBO(114, 178, 238, 1)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                submittedPinTheme: PinTheme(
                  width: 56,
                  height: 56,
                  textStyle: const TextStyle(
                    fontSize: 20,
                    color: Color.fromRGBO(30, 60, 87, 1),
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromRGBO(234, 239, 243, 1)),
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromRGBO(234, 239, 243, 1),
                  ),
                ),
                showCursor: true,
                onCompleted: (pin) {
                  smsCode = pin;
                },
              ),
              FilledButton(
                onPressed: otpVerification,
                child: const Text('Verify SMS'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
