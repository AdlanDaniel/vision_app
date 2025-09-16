class FlavorConfig {
  final String baseUrl;

  final int connectTimeOut;

  final int receiveTimeOut;

  final AppFlavor flavor;

  FlavorConfig({
    required this.baseUrl,
    required this.connectTimeOut,
    required this.receiveTimeOut,
    required this.flavor,
  });
}

enum AppFlavor { dev, prod }