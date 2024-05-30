import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityCheckerHelper {
  static bool _handleResult(List<ConnectivityResult> connectivityResult) {
    final bool connected;
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      connected = true;
    } else {
      connected = false;
    }
    return connected;
  }

  Future<bool> checkConnectivity() async {
    final Connectivity connectivity = Connectivity();
    late List<ConnectivityResult> result;

    result = await connectivity.checkConnectivity();
    return _handleResult(result);
  }
}
