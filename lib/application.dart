import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vision_app/core/flavor/flavor_config.dart';
import 'package:vision_app/core/ui/theme/vision_theme.dart';
import 'package:vision_app/core/utils/constants/routes/vision_routes.dart';
import 'package:vision_app/features/auth/pages/forgot_password/pages/forgot_password_page.dart';
import 'package:vision_app/features/auth/pages/forgot_password/pages/forgot_password_sucess_page.dart';
import 'package:vision_app/features/auth/pages/login/page/login_page.dart';
import 'package:vision_app/features/auth/pages/on_board/page/on_board_page.dart';
import 'package:vision_app/features/auth/pages/register/page/register_page.dart';
import 'package:vision_app/features/auth/repository/model/user_model.dart';
import 'package:vision_app/features/home/page/home_page.dart';
import 'package:vision_app/features/profile/pages/change_password/page/change_password_page.dart';
import 'package:vision_app/features/profile/pages/detail_plan/page/detail_plan_page.dart';
import 'package:vision_app/features/profile/pages/edit_profile/page/edit_profile_page.dart';
import 'package:vision_app/features/profile/pages/profile_details/page/profile_detail_page.dart';
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
      initialRoute: VisionRoutes.initial,
      routes: {
        VisionRoutes.initial: (context) => SplashPage(),
        VisionRoutes.registerUser: (context) => RegisterPage(),
        VisionRoutes.login: (context) => LoginPage(),
        VisionRoutes.home: (context) => HomePage(),
        VisionRoutes.detailProfile: (context) => ProfileDetailPage(),
        VisionRoutes.detailPlan: (context) => DetailPlanPage(),
        VisionRoutes.changePassword: (context) => ChangePasswordPage(),
        VisionRoutes.forgotPassword: (context) => ForgoutPasswordPage(),
        VisionRoutes.successForgotPassword: (context) =>
            ForgoutPasswordSucessPage(),
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
          case VisionRoutes.editProfile:
            final args = settings.arguments as UserModel;
            return MaterialPageRoute(
              builder: (_) => EditProfilePage(user: args),
            );
        }
        return null;
      },
    );
  }
}
