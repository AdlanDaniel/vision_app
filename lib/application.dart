import 'package:flutter/material.dart';
import 'package:vision_app/core/flavor/flavor_config.dart';
import 'package:vision_app/core/ui/theme/vision_theme.dart';
import 'package:vision_app/core/utils/constants/routes/vision_routes.dart';
import 'package:vision_app/features/auth/pages/login/page/login_page.dart';
import 'package:vision_app/features/auth/pages/on_board/page/on_board_page.dart';
import 'package:vision_app/features/auth/pages/register/page/register_page.dart';
import 'package:vision_app/features/home/page/home_page.dart';
import 'package:vision_app/features/splash/page/splash_page.dart';
import 'package:vision_app/init_depedencies.dart';

Future<void> initializeApp(FlavorConfig flavor) async {
  await InitDepedencies.init(flavor);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vision App',
      debugShowCheckedModeBanner: false,
      theme: VisionTheme.darkTheme,
      // initialRoute: VisionRoutes.initial,
      routes: {
        VisionRoutes.initial: (context) => HomePage(),
        VisionRoutes.registerUser: (context) => RegisterPage(),
        VisionRoutes.login: (context) => LoginPage(),
        VisionRoutes.home: (context) => HomePage(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case VisionRoutes.onBoardUser:
            final args = settings.arguments as Map<String, String>;
            return MaterialPageRoute(
              builder: (_) => OnBoardUserPage(
                email: args["email"]!,
                password: args["password"]!,
              ),
            );
        }
        return null;
      },
    );
  }
}
