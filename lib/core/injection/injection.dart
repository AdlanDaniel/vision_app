import 'package:get_it/get_it.dart';

abstract class Injection {
  void registerSingleton<T extends Object>(
    T instance, {
    String? instanceName,
    bool? signalsReady,
    DisposingFunc<T>? dispose,
  });
  void registerLazySingleton<T extends Object>(
    T Function() factoryFunc, {
    String? instanceName,
    DisposingFunc<T>? dispose,
  });
  void registerFactory<T extends Object>(
    T Function() factoryFunc, {
    String? instanceName,
  });
  T get<T extends Object>();

  bool isRegistered<T extends Object>({Object? instance, String? instanceName});

  Future<void> reset({bool dispose = true});
}

class InjectionManager {
  static late Injection _injection;

  static void init(Injection injectionImpl) {
    _injection = injectionImpl;
  }

  static Injection get i => _injection;
}

class InjectionGetIt implements Injection {
  static final GetIt _getIt = GetIt.instance;

  @override
  T get<T extends Object>() => _getIt<T>();

  @override
  void registerFactory<T extends Object>(
    T Function() factoryFunc, {
    String? instanceName,
  }) {
    _getIt.registerFactory<T>(factoryFunc, instanceName: instanceName);
  }

  @override
  void registerLazySingleton<T extends Object>(
    T Function() factoryFunc, {
    String? instanceName,
    DisposingFunc<T>? dispose,
  }) {
    _getIt.registerLazySingleton<T>(
      factoryFunc,
      instanceName: instanceName,
      dispose: dispose,
    );
  }

  @override
  void registerSingleton<T extends Object>(
    T instance, {
    String? instanceName,
    bool? signalsReady,
    DisposingFunc<T>? dispose,
  }) {
    _getIt.registerSingleton<T>(
      instance,
      instanceName: instanceName,
      signalsReady: signalsReady ?? false,
      dispose: dispose,
    );
  }

  @override
  bool isRegistered<T extends Object>({
    Object? instance,
    String? instanceName,
  }) {
    return _getIt.isRegistered<T>(
      instance: instance,
      instanceName: instanceName,
    );
  }

  @override
  Future<void> reset({bool dispose = true}) => _getIt.reset(dispose: dispose);
}

// class InjectionModular implements Injection {
//   final List<Bind> _binds = [];

//   @override
//   T get<T extends Object>() => Modular.get<T>();

//   @override
//   void registerFactory<T extends Object>(
//     T Function() factoryFunc, {
//     String? instanceName,
//   }) {
//     _binds.add(Bind.factory<T>((i) => factoryFunc()));
//   }

//   @override
//   void registerLazySingleton<T extends Object>(
//     T Function() factoryFunc, {
//     String? instanceName,
//     DisposingFunc<T>? dispose,
//   }) {
//     _binds.add(Bind.lazySingleton<T>((i) => factoryFunc()));
//   }

//   @override
//   void registerSingleton<T extends Object>(
//     T instance, {
//     String? instanceName,
//     bool? signalsReady,
//     DisposingFunc<T>? dispose,
//   }) {
//     _binds.add(Bind.singleton<T>((i) => instance));
//   }

//   @override
//   bool isRegistered<T extends Object>({
//     Object? instance,
//     String? instanceName,
//   }) {
//     // Modular não tem equivalente direto
//     throw UnimplementedError('isRegistered não suportado no Modular');
//   }

//   @override
//   Future<void> reset({bool dispose = true}) async {
//     // Modular também não expõe reset global
//     throw UnimplementedError('reset não suportado no Modular');
//   }

//   List<Bind> get binds => _binds;
// }
