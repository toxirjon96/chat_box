import 'package:chat_box/src/common/config/theme_config.dart';
import 'package:chat_box/src/features/home_page/home_page.dart';
import 'package:flutter/material.dart';

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