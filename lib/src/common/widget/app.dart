import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/dependencies/model/dependencies.dart';
import '../../features/dependencies/widget/dependencies_scope.dart';
import '../../features/pages/sign_in_page/bloc/authorization_bloc.dart';
import '../../features/pages/home_page/home_page.dart';
import '../config/theme_config.dart';

class App extends StatelessWidget {
  const App({required this.dependencies, super.key});

  final Dependencies dependencies;

  void run() => runApp(this);

  @override
  Widget build(BuildContext context) {
    return DependenciesScope(
      dependencies: dependencies,
      child: BlocProvider(
        create: (_) => AuthBloc(
          repository: dependencies.authorizationRepository,
        ),
        child: MaterialApp(
          title: 'Chat Box',
          theme: ThemeConfig.theme,
          debugShowCheckedModeBanner: false,
          home: const HomePage(),
        ),
      ),
    );
  }
}
