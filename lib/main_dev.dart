import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vision_app/application.dart';
import 'package:vision_app/core/environment/environment.dart';
import 'package:vision_app/core/flavor/flavor_config.dart';
import 'package:vision_app/core/injection/injection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  await dotenv.load(fileName: ".env");
  final environment = DefaultEnvironment(dotenv);
  InjectionManager.init(InjectionGetIt());
  InjectionManager.i.registerSingleton<Environment>(environment);
  final flavorConfig = FlavorConfig(
    baseUrl: environment.baseUrlDev,
    connectTimeOut: environment.connectTimeOut,
    receiveTimeOut: environment.receiveTimeOut,
    flavor: AppFlavor.dev,
  );

  await initializeApp(flavorConfig);
}
