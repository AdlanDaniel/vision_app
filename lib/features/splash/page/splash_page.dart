import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:vision_app/core/injection/injection.dart';
import 'package:vision_app/core/utils/constants/assets.dart';
import 'package:vision_app/core/utils/constants/routes/vision_routes.dart';
import 'package:vision_app/features/auth/pages/login/controller/login_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _loginController = InjectionManager.i.get<LoginController>();
  Future<void> _checkIsLoggedIn() async {
    final isLoggedInResult = await _loginController.isLoggedIn();
    isLoggedInResult.fold(
      (error) {
        Navigator.pushReplacementNamed(context, VisionRoutes.registerUser);
      },
      (isLoggedIn) {
        if (isLoggedIn) {
          Navigator.pushReplacementNamed(context, VisionRoutes.home);
        } else {
          Navigator.pushReplacementNamed(context, VisionRoutes.registerUser);
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((value) {
      _checkIsLoggedIn();
      // WidgetsBinding.instance.addPostFrameCallback((_) async {

      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(VisionAssets.logo, width: 100, height: 100),
          ],
        ),
      ),
    );
  }
}
