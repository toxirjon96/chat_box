import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../common/style/app_icons.dart';
import '../../../common/style/app_insets.dart';
import '../home_page/widget/custom_divider.dart';
import '../home_page/widget/svg_container.dart';
import '../main_page/main_page.dart';
import 'widget/custom_button.dart';
import 'widget/otp_screen.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late final TextEditingController phoneController;
  final _formKey = GlobalKey<FormState>();

  ValueNotifier<bool> loading = ValueNotifier(false);
  ValueNotifier<bool> isError = ValueNotifier(false);
  ValueNotifier<String> errorMessage = ValueNotifier('');

  Future<void> signIn() async {
    final isValidPhoneNumber = _formKey.currentState!.validate();
    if (isValidPhoneNumber) {
      loading.value = true;
      final auth = FirebaseAuth.instance;
      final phone = phoneController.text;
      await auth.verifyPhoneNumber(
        phoneNumber: phone.trim().replaceAll(' ', ''),
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          print('\n' * 5);
          print('verificationCompleted');
          print(credential.smsCode);
          print('\n' * 5);
        },
        verificationFailed: (FirebaseAuthException e) {
          isError.value = true;
          errorMessage.value = 'Authentication failed!';
        },
        codeSent: (String verificationId, int? resendToken) async {
          final result = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => OtpScreen(
                verificationId: verificationId,
                phoneNumber: phone,
              ),
            ),
          );
          if (result != null) {
            if (context.mounted) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const MainPage(),
                ),
              );
            }
          }else{
            isError.value = true;
            errorMessage.value = 'Verification failed';
          }
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
                  'Log in to ChatBox',
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
                  svgPath: AppIcons.facebookSvg,
                  size: 60,
                  backgroundColor: Theme.of(context).colorScheme.background,
                ),
                const SizedBox(width: 20),
                SvgContainer(
                  svgPath: AppIcons.googleSvg,
                  size: 60,
                  backgroundColor: Theme.of(context).colorScheme.background,
                ),
                const SizedBox(width: 15),
                SvgContainer(
                  svgPath: AppIcons.appleBlackSvg,
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
            CustomButton(
              horizontalPadding: AppInsets.leftAndRightPadding,
              text: 'Sign in',
              onPressed: signIn,
            ),
          ],
        ),
      ),
    );
  }
}
