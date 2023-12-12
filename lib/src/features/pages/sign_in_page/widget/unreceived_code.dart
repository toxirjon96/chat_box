import 'package:flutter/material.dart';

class UnreceivedCode extends StatelessWidget {
  const UnreceivedCode({
    required this.onPressed,
    super.key,
  });

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Didn\'t receive code?',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: onPressed,
          child: Text(
            'Resend',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ),
      ],
    );
  }
}
