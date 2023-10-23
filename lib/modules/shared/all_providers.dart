import 'package:idea/modules/auth/provider/login_provider.dart';
import 'package:idea/modules/auth/provider/register_provider.dart';
import 'package:idea/modules/idea/provider/idea_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider<LoginProvider>(
    create: (context) => LoginProvider(),
  ),
  ChangeNotifierProvider<RegisterProvider>(
    create: (context) => RegisterProvider(),
  ),
  ChangeNotifierProvider<IdeaProvider>(
    create: (context) => IdeaProvider(),
  ),
];
