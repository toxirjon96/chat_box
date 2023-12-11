import 'package:flutter/material.dart';

import '../../features/dependencies/model/dependencies.dart';
import '../../features/dependencies/widget/dependencies_scope.dart';
import '../config/theme_config.dart';
import '../../features/pages/home_page/home_page.dart';

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
        home: const HomePage(),
      ),
    );
  }
}
