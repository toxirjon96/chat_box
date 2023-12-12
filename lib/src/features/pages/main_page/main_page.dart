import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/style/app_colors.dart';
import '../../../common/style/app_icons.dart';
import '../contacts_page/contacts_page.dart';
import '../messaging_page/messaging_page.dart';
import '../settings_page/settings_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController controller = PageController();
  ValueNotifier<int> pageNumber = ValueNotifier(0);

  void changePage(int index) {
    pageNumber.value = index;
    controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.mainColor,
              AppColors.lightMainColor,
            ],
          ),
        ),
        child: PageView(
          controller: controller,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            MessagingPage(),
            ContactsPage(),
            SettingsPage(),
          ],
        ),
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: pageNumber,
        builder: (context, value, child) => BottomNavigationBar(
          onTap: changePage,
          currentIndex: value,
          backgroundColor: Theme.of(context).colorScheme.background,
          unselectedLabelStyle:
              Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                fontSize: 14
                  ),
          selectedLabelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontSize: 14,
                color: Theme.of(context).colorScheme.primary,
              ),
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(AppIcons.messageSvg),
              activeIcon: SvgPicture.asset(AppIcons.messageActiveSvg),
              label: 'Message',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(AppIcons.userSvg),
              activeIcon: SvgPicture.asset(AppIcons.userActiveSvg),
              label: 'Contacts',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(AppIcons.settingsSvg),
              activeIcon: SvgPicture.asset(AppIcons.settingsActiveSvg),
              label: 'Settings',
            )
          ],
        ),
      ),
    );
  }
}
