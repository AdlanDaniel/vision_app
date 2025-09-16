import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vision_app/application.dart';
import 'package:vision_app/core/environment/environment.dart';
import 'package:vision_app/core/flavor/flavor_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  dotenv.load(fileName: ".env");
  final environment = DefaultEnvironment(dotenv);
  final flavorConfig = FlavorConfig(
    baseUrl: environment.baseUrl,
    connectTimeOut: environment.connectTimeOut,
    receiveTimeOut: environment.receiveTimeOut,
    flavor: AppFlavor.prod,
  );

  initializeApp(flavorConfig);
}
