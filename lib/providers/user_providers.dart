import 'package:flutter/foundation.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/models/models.dart';

class UserProvider with ChangeNotifier {
  UserModels? _user;
  final _authMehtods = AuthMehtods();

  UserModels get user => _user!;

  Future<void> refreshUser() async {
    UserModels userModels = await _authMehtods.getUserDetails();
    _user = userModels;

    notifyListeners();
  }
}
