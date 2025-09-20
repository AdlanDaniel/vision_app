import 'package:dio/dio.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vision_app/core/app_info/app_version_info.dart';
import 'package:vision_app/core/app_info/session_info.dart';
import 'package:vision_app/core/flavor/flavor_config.dart';
import 'package:vision_app/core/interceptors/interceptors.dart';
import 'package:vision_app/core/rest_client/dio_factory.dart';
import 'package:vision_app/core/rest_client/dio_rest_client.dart';
import 'package:vision_app/core/rest_client/rest_client.dart';
import 'package:vision_app/core/injection/injection.dart';
import 'package:vision_app/features/auth/di/auth_di.dart';
import 'package:vision_app/features/home/di/home_di.dart';
import 'package:vision_app/features/profile/di/profile_di.dart';

class InitDepedencies {
  static Future<void> init(FlavorConfig config) async {
    await _initLocalStorage();
    _initAppSession();
    await _initAppVersion();
    _initRestClient(config);

    AuthDi.init();
    HomeDI.init();
    ProfileDI.config();
  }

  static void _initRestClient(FlavorConfig config) {
    Dio dio = DioFactory.create(
      baseUrl: config.baseUrl,
      connectTimeout: config.connectTimeOut,
      receiveTimeout: config.receiveTimeOut,
    );

    dio.interceptors.addAll([
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        request: true,
        responseBody: true,
        responseHeader: true,
        maxWidth: 80,
      ),
      // AuthInterceptor(firebaseAuth: FirebaseClient.firebaseAuth()),
      AuthInterceptor(),
    ]);

    InjectionManager.i.registerSingleton<Dio>(dio);
    InjectionManager.i.registerSingleton<RestClient>(DioRestClient(dio));
  }

  static Future<void> _initLocalStorage() async {
    final localStorage = await SharedPreferences.getInstance();
    InjectionManager.i.registerSingleton<SharedPreferences>(localStorage);
  }

  static Future<void> _initAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final appVersion = AppVersionInfo(
      appName: packageInfo.appName,
      packageName: packageInfo.packageName,
      version: packageInfo.version,
      buildNumber: packageInfo.buildNumber,
    );
    InjectionManager.i.registerFactory<AppVersionInfo>(() => appVersion);
  }

  static void _initAppSession() {
    InjectionManager.i.registerSingleton<SessionInfo>(SessionInfo());
  }
}
