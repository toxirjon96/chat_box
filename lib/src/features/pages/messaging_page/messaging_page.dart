import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/style/app_icons.dart';
import '../../../common/style/app_insets.dart';
import 'widget/user_container.dart';

class MessagingPage extends StatelessWidget {
  const MessagingPage({
    this.userImage,
    super.key,
  });

  final Image? userImage;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
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
        Positioned(
          left: AppInsets.leftAndRightPadding,
          right: 0,
          top: 90,
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              UsersContainer(),
              UsersContainer(),
              UsersContainer(),
              UsersContainer(),
              UsersContainer(),
              UsersContainer(),
              UsersContainer(),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: 200,
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
