import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../firebase_options.dart';
import '../../features/dependencies/model/dependencies.dart';
import '../../features/pages/sign_in_page/repository/authorization_repository.dart';
import '../data_provider/fire_store_data_provider.dart';
import '../data_provider/firebase_data_provider.dart';
import '../data_provider/firebase_storage_data_provider.dart';
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
      firebaseDataProvider: FireBaseDataProviderImpl(),
      firebaseStorageDataProvider: FirebaseStorageDataProviderImpl(),
      fireStoreDataProvider: FireStoreDataProviderImpl(),
    );

    App(
      dependencies: dependencies,
    ).run();
  }
}
