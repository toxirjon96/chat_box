import 'package:flutter/material.dart';

import '../config/theme_config.dart';
import '../../features/pages/home_page/home_page.dart';

class App extends StatelessWidget{
  const App({super.key});

  void run()=> runApp(this);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Talk",
      theme: ThemeConfig.theme,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }

}