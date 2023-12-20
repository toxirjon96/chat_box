import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'painter/user_container_painter.dart';

class UsersContainer extends StatelessWidget {
  const UsersContainer({
    this.userName = '',
    this.strokeWidth = 3.0,
    this.selfContainer = false,
    this.borderColor = Colors.white,
    this.selfTopColor = Colors.white,
    this.imageUrl = '',
    super.key,
  });

  final bool selfContainer;
  final double strokeWidth;
  final Color borderColor;
  final Color selfTopColor;
  final String imageUrl;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                shape: BoxShape.circle,
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    right: 0,
                    height: 70,
                    child: CustomPaint(
                      painter: UserContainerPainter(
                        selfContainer: selfContainer,
                        strokeWidth: strokeWidth,
                        borderColor: borderColor,
                        selfTopColor: selfTopColor,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 3,
                    top: 3,
                    right: 3,
                    height: 65,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(
                          color: borderColor,
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          userName,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.background,
              ),
        )
      ],
    );
  }
}
