import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idea/modules/auth/login.dart';
import 'package:idea/modules/shared/all_providers.dart';
import 'package:idea/modules/shared/routes_manager.dart';
import 'package:idea/modules/shared/strings.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: appProviders,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (BuildContext context, Widget? child) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appName,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.loginScreen,
        home: LoginScreen(),
      ),
    );
  }
}
