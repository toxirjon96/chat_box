import 'package:chat_box/firebase_options.dart';
import 'package:chat_box/src/common/widget/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AppRunner{
  Future<void> initializeAndRun() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    const App().run();
  }
}