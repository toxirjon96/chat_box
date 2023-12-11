import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../firebase_options.dart';
import '../../features/dependencies/model/dependencies.dart';
import '../widget/app.dart';

class AppRunner {
  Future<void> initializeAndRun() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final dependencies = Dependencies();
    dependencies.sharedPreferences = await SharedPreferences.getInstance();
    App(
      dependencies: dependencies,
    ).run();
  }
}
