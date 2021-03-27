import 'package:foxbit_client/data/helpers/websocket.dart';

abstract class IHeartbeatRepository {
  Future<Map> send(FoxbitWebSocket webSocket);
}