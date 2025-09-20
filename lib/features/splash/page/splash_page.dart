import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:vision_app/core/utils/constants/assets.dart';
import 'package:vision_app/core/utils/constants/routes/vision_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2)).then(
      (value) =>
          Navigator.pushReplacementNamed(context, VisionRoutes.registerUser),
    );
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
