import 'package:flutter/material.dart';
import 'package:idea/modules/shared/models/user.dart';
import 'package:idea/modules/shared/util/db_helper.dart';
import 'package:idea/modules/shared/util/db_util.dart';
import 'package:idea/modules/shared/view_state.dart';

class LoginProvider extends ChangeNotifier {
  AppState get appState => _appState;
  AppState _appState = AppState.initial;
  String? _message;
  String? get message => _message;
  bool isVisiblePassword = true;
  bool _isButtonEnabled = false;
  bool get isButtonEnabled => _isButtonEnabled;

  void visiblePassword() {
    isVisiblePassword = !isVisiblePassword;
    notifyListeners();
  }

  void updateButtonState(String value) {
    _isButtonEnabled = value.isNotEmpty;
    notifyListeners();
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  DatabaseProvider? databaseProvider;
  DBUtil dbHelper = DBUtil();
  User? _user;
  User? get user => _user;

  Future<bool> login(String username, String password) async {
    bool isSubmitted = false;
    _user = await dbHelper.getUserByUsername(username);
    // print(_user?.id);
    if (_user?.username != username) {
      _message = 'User not found';
    } else if (_user != null && _user!.password == password) {
      isSubmitted = true;
      _message = 'Login successful';
      _appState = AppState.loaded;
      notifyListeners();
    } else {
      _message = 'Login unsuccessful';
      _appState = AppState.error;
      notifyListeners();
      // throw Exception('Invalid username or password.');
    }

    return isSubmitted;
  }
}
