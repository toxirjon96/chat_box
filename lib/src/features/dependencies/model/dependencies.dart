import 'package:shared_preferences/shared_preferences.dart';

import '../../pages/sign_in_page/repository/authorization_repository.dart';

base class Dependencies {
  Dependencies();

  late final SharedPreferences sharedPreferences;
  late final IAuthorizationRepository authorizationRepository;
}
