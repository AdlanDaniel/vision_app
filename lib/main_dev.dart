import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vision_app/core/environment/environment.dart';
import 'package:vision_app/old_main.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  dotenv.load(fileName: ".env");
  final environment = DefaultEnvironment(dotenv);
    runApp(MyApp());
  
}
