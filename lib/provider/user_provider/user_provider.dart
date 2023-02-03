import 'package:flutter/widgets.dart';
import 'package:rondyarticleapp/controller/auth_controller.dart';

import '../../base/models/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  User get getUser => _user!;
  final AuthController _authController = AuthController();

  Future<void> refresh() async {
    User user = await _authController.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
