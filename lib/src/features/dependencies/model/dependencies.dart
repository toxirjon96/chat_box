import 'package:shared_preferences/shared_preferences.dart';

import '../../pages/main_page/data/main_repository.dart';
import '../../pages/sign_in_page/repository/authorization_repository.dart';

base class Dependencies {
  Dependencies();

  late final SharedPreferences sharedPreferences;
  late final IAuthorizationRepository authorizationRepository;
  late final IMainRepository mainRepository;
}

final class MutableDependencies implements Dependencies {
  MutableDependencies({
    required this.sharedPreferences,
    required this.authorizationRepository,
    required this.mainRepository,
  });

  @override
  IMainRepository mainRepository;

  @override
  SharedPreferences sharedPreferences;

  @override
  IAuthorizationRepository authorizationRepository;
}
