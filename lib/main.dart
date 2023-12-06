import 'package:chat_box/firebase_options.dart';
import 'package:chat_box/src/common/config/theme_config.dart';
import 'package:chat_box/src/features/home_page/home_page.dart';
import 'package:firebase_core/firebase_core.dart';

import './src/features/sign_in_page/sign_in_page.dart';
import 'package:flutter/material.dart';

//https://www.figma.com/file/LZ5E4NMAlBzb38GKifzupK/TEXTit-Chatting-App---Chatbox-(Community)?node-id=22%3A2795&mode=dev
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ChatBoxApp());
}

class ChatBoxApp extends StatelessWidget {
  const ChatBoxApp({super.key});

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
