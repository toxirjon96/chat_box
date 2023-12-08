import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../common/style/app_colors.dart';
import '../../../common/style/app_insets.dart';
import '../home_page/widget/custom_divider.dart';
import '../home_page/widget/svg_container.dart';
import '../main_page/main_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late final TextEditingController phoneController;
  final _formKey = GlobalKey<FormState>();

  Future<void> signIn() async {
    final isValidPhoneNumber = _formKey.currentState!.validate();
    if (isValidPhoneNumber) {
      final auth = FirebaseAuth.instance;

      await auth.verifyPhoneNumber(
        phoneNumber: phoneController.text.trim().replaceAll(' ', ''),
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          print('\n' * 5);
          print('verificationCompleted');
          print(credential.smsCode);
          print('\n' * 5);

          await auth.signInWithCredential(credential).then((value) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const MainPage(),
              ),
            );
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print('\n' * 5);
          print(e);
          print('\n' * 5);
        },
        codeSent: (String verificationId, int? resendToken) async {
          print('\n' * 5);
          print('codeSent');
          print('\n' * 5);

          const smscode = '123123';

          final credential = PhoneAuthProvider.credential(
            verificationId: verificationId,
            smsCode: smscode,
          );

          auth.signInWithCredential(credential).then((result) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const MainPage(),
              ),
            );
          }).catchError((e) {
            print(e);
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print('\n' * 5);
          print(verificationId);
          print('\n' * 5);
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
  }

  @override
  void dispose() {
    FocusScope.of(context).unfocus();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppInsets.leftAndRightPadding,
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Log in to Chatbox',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppInsets.leftAndRightPadding,
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Welcome back! Sign in using your social account or email to continue us',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgContainer(
                  svgPath: 'assets/icons/facebook.svg',
                  size: 60,
                  backgroundColor: Theme.of(context).colorScheme.background,
                ),
                const SizedBox(width: 20),
                SvgContainer(
                  svgPath: 'assets/icons/google.svg',
                  size: 60,
                  backgroundColor: Theme.of(context).colorScheme.background,
                ),
                const SizedBox(width: 15),
                SvgContainer(
                  svgPath: 'assets/icons/apple-black.svg',
                  size: 60,
                  backgroundColor: Theme.of(context).colorScheme.background,
                ),
              ],
            ),
            const SizedBox(height: 30),
            CustomDivider(
              horizontalPadding: AppInsets.leftAndRightPadding,
              color: Theme.of(context).colorScheme.secondary,
              centerWidget: Text(
                'OR',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
            ),
            const SizedBox(height: 25),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppInsets.leftAndRightPadding,
                ),
                child: TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Phone number'),
                  validator: (value) {
                    if (value == null || value.length != 17) {
                      return 'Please enter valid phone number';
                    }
                    return null;
                  },
                  inputFormatters: [
                    MaskTextInputFormatter(
                      mask: '+### ## ### ## ##',
                      filter: {'#': RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppInsets.leftAndRightPadding,
              ),
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      AppColors.mainColor,
                      AppColors.lightMainColor,
                    ],
                  ),
                ),
                child: SizedBox.expand(
                  child: TextButton(
                    onPressed: signIn,
                    child: Text(
                      'Sign in',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context).colorScheme.background,
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
