import 'package:flutter/material.dart';

import 'painter/user_container_painter.dart';

class UsersContainer extends StatelessWidget {
  const UsersContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            shape: BoxShape.circle,
          ),
          child: CustomPaint(
            painter: UserContainerPainter(),
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
