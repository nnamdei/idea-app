import 'package:flutter/material.dart';
import 'package:idea/modules/auth/login.dart';
import 'package:idea/modules/auth/register.dart';
import 'package:idea/modules/idea/add_idea.dart';
import 'package:idea/modules/idea/idea_detail.dart';
import 'package:idea/modules/idea/idea_home.dart';
import 'package:idea/modules/shared/strings.dart';

class Routes {
  static const loginScreen = "/login_screen";
  static const registerScreen = "/register_screen";
  static const addIdeaScreen = "/create_idea_screen";
  static const allIdeasScreen = "/ideas_list_screen";
  static const viewIdeaScreen = "/view_idea_screen";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.registerScreen:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case Routes.addIdeaScreen:
        return MaterialPageRoute(builder: (_) => const AddIdea());
      case Routes.allIdeasScreen:
        return MaterialPageRoute(builder: (_) => const IdeaHome());
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => const Scaffold(
              body: Center(
                child: Text(noRouteFound),
              ),
            ));
  }
}
