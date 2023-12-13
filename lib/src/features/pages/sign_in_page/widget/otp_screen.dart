import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

import '../../../../common/style/app_insets.dart';
import '../../main_page/main_page.dart';
import '../bloc/authorization_bloc.dart';
import 'unreceived_code.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    required this.verificationId,
    required this.phoneNumber,
    this.seconds = 120,
    super.key,
  });

  final String verificationId;
  final String phoneNumber;
  final int seconds;

  @override
  State<StatefulWidget> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late final Timer _timer;
  late ValueNotifier<int> _start;

  @override
  void initState() {
    _start = ValueNotifier(widget.seconds);
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    const period = Duration(seconds: 1);
    _timer = Timer.periodic(period, (timer) {
      if (_start.value == 0) {
        _timer.cancel();
      } else {
        _start.value -= 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Auth$SignInSuccessState) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const MainPage(),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is Auth$LoadingState) {
            return CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppInsets.leftAndRightPadding,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'SMS ',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                      children: [
                        TextSpan(
                          text: 'Verification',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'A text message with a six digit verification code has been sent to your phone number',
                    maxLines: 2,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 16),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    widget.phoneNumber,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  const SizedBox(height: 40),
                  Pinput(
                    length: 6,
                    defaultPinTheme: PinTheme(
                      width: 56,
                      height: 56,
                      textStyle: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    focusedPinTheme: PinTheme(
                      width: 56,
                      height: 56,
                      textStyle: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    submittedPinTheme: PinTheme(
                      width: 56,
                      height: 56,
                      textStyle: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.background,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                    showCursor: true,
                    onCompleted: (pin) {
                      context.read<AuthBloc>().add(
                            Auth$SignInEvent(
                                id: widget.verificationId, smsCode: pin),
                          );
                    },
                  ),
                  const SizedBox(height: 20),
                  ValueListenableBuilder(
                    valueListenable: _start,
                    builder: (ctx, value, child) {
                      if (value == 0) {
                        return UnreceivedCode(
                          onPressed: () {
                            context.read<AuthBloc>().add(
                                  Auth$SendSmsCodeEvent(widget.phoneNumber),
                                );
                          },
                        );
                      }
                      String minutes = (value ~/ 60).toString().padLeft(2, '0');
                      String seconds = (value % 60).toString().padLeft(2, '0');
                      return Center(
                        child: Text(
                          'Resend code in $minutes:$seconds sec',
                          maxLines: 2,
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 16,
                              ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
