import 'package:flutter/material.dart';
import 'package:idea/modules/shared/routes_manager.dart';


void openLoginScreen(BuildContext context) async {
  Navigator.pushNamed(context, Routes.loginScreen);
}

void openRegisterScreen(BuildContext context) async {
  Navigator.pushNamed(context, Routes.registerScreen);
}

void openIdeaHomeScreen(BuildContext context) async {
  Navigator.pushReplacementNamed(context, Routes.allIdeasScreen);
}

void addIdeaScreen(BuildContext context) async {
  Navigator.pushNamed(context, Routes.addIdeaScreen);
}

