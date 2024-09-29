// import 'dart:async';
// import 'dart:io'; // InternetAddress utility
// import 'package:connectivity_plus/connectivity_plus.dart';
//
// class ConnectionStatusSingleton {
//   static final ConnectionStatusSingleton _singleton = ConnectionStatusSingleton._internal();
//   ConnectionStatusSingleton._internal();
//
//   static ConnectionStatusSingleton getInstance() => _singleton;
//
//   bool hasConnection = false;
//   final StreamController<bool> connectionChangeController = StreamController<bool>.broadcast();
//   final Connectivity _connectivity = Connectivity();
//
//   void initialize() {
//     // Listen for connectivity changes
//     // _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
//     //   _connectionChange(result);
//     // });
//     checkConnection();
//   }
//
//   Stream<bool> get connectionChange => connectionChangeController.stream;
//
//   void dispose() {
//     connectionChangeController.close();
//   }
//
//   void _connectionChange(ConnectivityResult result) {
//     checkConnection();
//   }
//
//   Future<bool> checkConnection() async {
//     bool previousConnection = hasConnection;
//
//     try {
//       final result = await InternetAddress.lookup('google.com');
//       hasConnection = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
//     } on SocketException catch (_) {
//       hasConnection = false;
//     }
//
//     if (previousConnection != hasConnection) {
//       connectionChangeController.add(hasConnection);
//     }
//
//     return hasConnection;
//   }
// }
