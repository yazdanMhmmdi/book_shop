import 'dart:async';

import 'package:data_connection_checker_tv/data_connection_checker.dart';

abstract class NetworkInfo {
  Stream<bool> get isConnected;
  void dispose();
}

class NetworkInfoImpl implements NetworkInfo {
  final DataConnectionChecker connectionChecker;
  StreamController<bool> streamController = StreamController<bool>();
  Stream<bool> networkStatus = Stream.value(true);

  NetworkInfoImpl(this.connectionChecker);
  @override
  Stream<bool> get isConnected {
    networkStatus = streamController.stream;
    connectionChecker.onStatusChange.listen((event) {
      switch (event) {
        case DataConnectionStatus.connected:
          streamController.add(true);
          break;
        case DataConnectionStatus.disconnected:
          streamController.add(false);
          break;
      }
    });
    return networkStatus;
  }

  @override
  void dispose() {
    streamController.close();
  }

  // connectivity.onConnectivityChanged.listen((connectivityResult) {
  //   if (connectivityResult == ConnectivityResult.mobile ||
  //       connectivityResult == ConnectivityResult.wifi) {
  //     emitInternetConnected();
  //   } else {
  //     emitInternetDisconnected();
  //   }
  // });
}
