import 'package:flutter/material.dart';
import 'package:vision_app/core/flavor/flavor_config.dart';
import 'package:vision_app/core/ui/theme/vision_theme.dart';
import 'package:vision_app/core/utils/constants/routes/vision_routes.dart';
import 'package:vision_app/features/splash/page/splash_page.dart';
import 'package:vision_app/init_depedencies.dart';

void initializeApp(FlavorConfig flavor) {
  InitDepedencies.init(flavor);
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
      routes: {VisionRoutes.initial: (context) => SplashPage()},
    );
  }
}
