import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vision_app/application.dart';
import 'package:vision_app/core/environment/environment.dart';
import 'package:vision_app/core/flavor/flavor_config.dart';
import 'package:vision_app/core/injection/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

  initializeApp(flavorConfig);
}
