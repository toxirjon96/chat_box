import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../features/dependencies/model/dependencies.dart';
import '../../features/dependencies/widget/dependencies_scope.dart';
import '../../features/pages/home_page/home_page.dart';
import '../../features/pages/main_page/main_page.dart';
import '../../features/pages/sign_in_page/model/user_model.dart';
import '../config/theme_config.dart';

class App extends StatelessWidget {
  const App({required this.dependencies, super.key});

  final Dependencies dependencies;

  void run() => runApp(this);

  @override
  Widget build(BuildContext context) {
    return DependenciesScope(
      dependencies: dependencies,
      child: MaterialApp(
        title: 'Chat Box',
        theme: ThemeConfig.theme,
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.userChanges(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasData) {
              UserModel user = UserModel(
                id: snapshot.data!.uid,
                displayName: snapshot.data!.displayName,
                avatarImage: snapshot.data!.photoURL,
                phoneNumber: snapshot.data!.phoneNumber,
              );
              return MainPage(
                user: user,
              );
            }
            return const HomePage();
          },
        ),
      ),
    );
  }
}
