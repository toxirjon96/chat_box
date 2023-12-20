import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/style/app_colors.dart';
import '../../../common/style/app_icons.dart';
import '../../../common/style/app_insets.dart';
import '../../dependencies/widget/dependencies_scope.dart';
import '../main_page/bloc/main_bloc.dart';
import '../sign_in_page/bloc/authorization_bloc.dart';
import '../sign_in_page/model/user_model.dart';
import 'widget/user_container.dart';
import 'widget/user_message_container.dart';

class MessagingPage extends StatefulWidget {
  const MessagingPage({
    super.key,
    required this.user,
  });

  final UserModel? user;

  @override
  State<MessagingPage> createState() => _MessagingPageState();
}

class _MessagingPageState extends State<MessagingPage> {
  late final AuthBloc authBloc;
  late final MainBloc bloc;

  @override
  void initState() {
    authBloc = AuthBloc(
      repository: DependenciesScope.of(context).authorizationRepository,
    );
    bloc = MainBloc(
      repository: DependenciesScope.of(context).mainRepository,
      authorizationRepository:
          DependenciesScope.of(context).authorizationRepository,
    )..add(const MainEvent.getUsers());
    super.initState();
  }

  @override
  void dispose() {
    authBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainBloc>.value(
      value: bloc,
      child: Stack(
        children: [
          Positioned(
            left: AppInsets.leftAndRightPadding,
            right: AppInsets.leftAndRightPadding,
            top: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50,
                  width: 50,
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
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Theme.of(context).colorScheme.tertiary)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(45),
                        child: CachedNetworkImage(
                          imageUrl: widget.user?.avatarImage ?? '',
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(
                            color: AppColors.white,
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.person),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    IconButton(
                      onPressed: () {
                        authBloc.add(const Auth$LogOutEvent());
                      },
                      icon: Icon(
                        Icons.logout,
                        color: Theme.of(context).colorScheme.background,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          BlocConsumer<MainBloc, MainState>(
            bloc: bloc,
            builder: (BuildContext context, MainState state) => state.maybeMap(
              orElse: () => const SizedBox.shrink(),
              loading: (value) => const Center(
                child: CircularProgressIndicator(),
              ),
              usersData: (value) => RefreshIndicator(
                child: Positioned(
                  left: AppInsets.leftAndRightPadding,
                  right: 0,
                  top: 90,
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      UsersContainer(
                        imageUrl: widget.user?.avatarImage ?? '',
                        selfContainer: true,
                        selfTopColor: AppColors.white,
                        borderColor: Colors.white38,
                      ),
                      ...value.users.map<Widget>((user) {
                        if (user.id != widget.user!.id) {
                          return UsersContainer(
                            imageUrl: user.avatarImage ?? '',
                            selfContainer: false,
                            selfTopColor: AppColors.white,
                            borderColor: Colors.white38,
                          );
                        }
                        return const SizedBox.shrink();
                      }),
                    ],
                  ),
                ),
                onRefresh: () async => bloc.add(const MainEvent.getUsers()),
              ),
            ),
            listener: (BuildContext context, MainState state) {},
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
              child: ListView(
                children: [
                  UserMessageContainer(
                    imageUrl: widget.user?.avatarImage ?? '',
                    userName: widget.user?.displayName ?? '',
                    lastMessageText: 'How are you today',
                    messageCount: 3,
                    isSeen: true,
                    sentTime: DateTime.now(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
