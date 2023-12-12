import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/style/app_icons.dart';
import '../../../common/style/app_insets.dart';

class MessagingPage extends StatelessWidget {
  const MessagingPage({
    this.userImage,
    super.key,
  });

  final Image? userImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: AppInsets.leftAndRightPadding,
          right: AppInsets.leftAndRightPadding,
          top: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 45,
                width: 45,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(AppIcons.searchSvg),
              ),
              Text(
                'Home',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.background,
                    ),
              ),
              CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                child: userImage ??
                    Icon(
                      Icons.person,
                      color: Theme.of(context).colorScheme.background,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
