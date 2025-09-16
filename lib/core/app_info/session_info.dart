

import 'package:uuid/uuid.dart';

class SessionInfo {
  final sessionId = const Uuid().v4();
  final traceId = const Uuid().v4().replaceAll('-', '');
  final parentId = const Uuid().v4().replaceAll('-', '').substring(0, 16);
  bool debugTracing = false;

  SessionInfo();

  String get errorCode => debugTracing ? traceId : traceId.substring(0, 8);
}