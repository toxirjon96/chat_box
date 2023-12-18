import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../common/style/app_colors.dart';

class UserMessageContainer extends StatelessWidget {
  const UserMessageContainer({
    required this.imageUrl,
    required this.userName,
    required this.lastMessageText,
    required this.messageCount,
    required this.isSeen,
    required this.sentTime,
    super.key,
  });

  final String imageUrl;
  final String userName;
  final String lastMessageText;
  final int messageCount;
  final bool isSeen;
  final DateTime sentTime;

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Column(
      children: [
        ListTile(
          leading: SizedBox(
            height: 60,
            width: 60,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => const CircularProgressIndicator(
                  color: AppColors.white,
                ),
                errorWidget: (context, url, error) => const Icon(Icons.person),
              ),
            ),
          ),
          title: Text(
            userName,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
          ),
          subtitle: Text(
            lastMessageText,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.w400,
                ),
          ),
          trailing: Column(
            children: [
              Text(
                '${sentTime.minute} min ago',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 5),
              isSeen
                  ? const Icon(
                      Icons.done_all,
                      color: Colors.green,
                    )
                  : Container(
                      height: 25,
                      width: 25,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.red,
                      ),
                      child: Center(
                        child: Text(
                          '$messageCount',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.background,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
        const SizedBox(height: 10)
      ],
    );
  }
}
