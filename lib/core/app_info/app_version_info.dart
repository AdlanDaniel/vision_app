class AppVersionInfo {
  String appName;
  String packageName;
  String version;
  String buildNumber;

  AppVersionInfo({
    required this.appName,
    required this.packageName,
    required this.version,
    required this.buildNumber,
  });

  @override
  String toString() {
    return 'AppVersionInfo(appName: $appName,'
        'packageName: $packageName, version: $version,'
        ' buildNumber: $buildNumber)';
  }
}