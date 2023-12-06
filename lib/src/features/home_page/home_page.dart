import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../common/style/app_colors.dart';
import '../../common/style/app_insets.dart';

import '../home_page/widget/custom_divider.dart';
import '../home_page/widget/svg_container.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> signIn() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
      phoneNumber: '+998946133644',
      codeSent: (String verificationId, int? resendToken) async {
        // Update the UI - wait for the user to enter the SMS code
        String smsCode = 'xxxx';

        // Create a PhoneAuthCredential with the code
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: smsCode);

        // Sign the user in (or link) with the credential
        await auth.signInWithCredential(credential);
      },
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
      verificationFailed: (FirebaseAuthException error) {},
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
              AppColors.mainColor,
              AppColors.lightMainColor,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppInsets.leftAndRightPadding,
              ),
              child: Text(
                "Connect friends easily & quickly",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 62,
                      color: Theme.of(context).colorScheme.background,
                    ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppInsets.leftAndRightPadding,
              ),
              child: Text(
                "Our chat app is the perfect way to stay connected with friends and family.",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgContainer(
                  svgPath: "assets/icons/facebook.svg",
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                const SizedBox(width: 20),
                SvgContainer(
                  svgPath: "assets/icons/google.svg",
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                const SizedBox(width: 15),
                SvgContainer(
                  svgPath: "assets/icons/apple.svg",
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
              ],
            ),
            const SizedBox(height: 30),
            CustomDivider(
              horizontalPadding: AppInsets.leftAndRightPadding,
              color: Theme.of(context).colorScheme.secondary,
              centerWidget: Text(
                "OR",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.background,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
