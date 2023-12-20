import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../firebase_options.dart';
import '../../features/dependencies/model/dependencies.dart';
import '../../features/pages/main_page/data/main_repository.dart';
import '../../features/pages/sign_in_page/repository/authorization_repository.dart';
import '../data_provider/database_data_provider.dart';
import '../data_provider/fire_store_data_provider.dart';
import '../data_provider/firebase_data_provider.dart';
import '../data_provider/firebase_storage_data_provider.dart';
import 'app.dart';

class AppRunner {
  Future<void> initializeAndRun() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.playIntegrity,
      // appleProvider: AppleProvider.appAttest,
    );

    final sharedPreferences = await SharedPreferences.getInstance();
    final dependencies = MutableDependencies(
      sharedPreferences: sharedPreferences,
      authorizationRepository: AuthorizationRepositoryImpl(
        firebaseDataProvider: FireBaseDataProviderImpl(),
        firebaseStorageDataProvider: FirebaseStorageDataProviderImpl(),
        fireStoreDataProvider: FireStoreDataProviderImpl(),
        databaseDataProvider: DatabaseDataProviderImpl(
          sharedPreferences: sharedPreferences,
        ),
      ),
      mainRepository: const MainRepositoryImpl(),
    );

    App(
      dependencies: dependencies,
    ).run();
  }
}
