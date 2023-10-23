import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:idea/modules/shared/models/user.dart';
import 'package:idea/modules/shared/util/db_helper.dart';
import 'package:idea/modules/shared/util/db_util.dart';
import 'package:idea/modules/shared/view_state.dart';

class RegisterProvider extends ChangeNotifier {
  AppState get appState => _appState;
  AppState _appState = AppState.initial;
  String? _message;
  String? get message => _message;
  bool isVisiblePassword = true;
  bool _isCreated = false;
  bool get isCreated => _isCreated;

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
  RegisterProvider();
  User? _user, _newUser;

  User? get user => _user;
  User? get newUser => _newUser;

  Future<bool> register(User user) async {
    bool isSubmitted = false;
    await databaseProvider?.createUser(user);
    _user = user;
    if (kDebugMode) {
      print(_user?.username);
    }
    notifyListeners();
    return isSubmitted;
  }

  void saveUserToDb(String username, String password) async {
    // _user = await dbHelper.getUserByUsername(username);
    // if (_user?.username == username) {
    //   _message = "User exist";
    //   _appState = AppState.loaded;
    //   notifyListeners();
    // } else {
  await  dbHelper
        .insert(
      User(username: username, password: password),
    )
        .then((value) {
      _isCreated = true;
      notifyListeners();
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
        _message = "An error occurred";
      }
      _isCreated = false;
      _appState = AppState.error;
      notifyListeners();
    });
    // }
  }
}
