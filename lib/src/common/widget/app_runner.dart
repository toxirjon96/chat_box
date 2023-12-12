import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../firebase_options.dart';
import '../../features/dependencies/model/dependencies.dart';
import '../../features/pages/sign_in_page/data/authorization_repository.dart';
import '../../features/pages/sign_in_page/data/firebase_data_provider.dart';
import '../widget/app.dart';

class AppRunner {
  Future<void> initializeAndRun() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final dependencies = Dependencies();

    dependencies.sharedPreferences = await SharedPreferences.getInstance();

    dependencies.authorizationRepository = AuthorizationRepositoryImpl(
      FireBaseDataProviderImpl(),
    );
    App(
      dependencies: dependencies,
    ).run();
  }
}
