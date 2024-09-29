import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:remotetask/viewModel/Screens/HomeScreen.dart';
import '../Models/Model1.dart';
import '../repository/AuthRepo.dart';
import '../utils/utilss.dart';

class AuthviewModel with ChangeNotifier {
  final _myRepo = AuthRepository();
  bool _loading = false;
  bool get loading => _loading;

  bool _isSyncing = false;
  bool get isSyncing => _isSyncing;

  List<SmsModel> pendingMessages = [];  // Queue for offline messages

  AuthviewModel() {
    _initializeConnectivityListener();
  }

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void setSyncing(bool value) {
    _isSyncing = value;
    notifyListeners();
  }

  Future<void> LoginApi(dynamic data, BuildContext context) async {
    setLoading(true);
    try {
      await _myRepo.LoginAPi(data);
      Future.delayed(Duration(seconds: 3));
      Navigator.push(context, MaterialPageRoute(builder: (context) => Homescreen()));
    } catch (error) {
      Utils.flushbarErrormesg1(error.toString(), context);
    } finally {
      setLoading(false);
    }
  }

  // Initialize connectivity listener
  void _initializeConnectivityListener() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none) {
        print("Internet connection restored");
        _syncPendingMessages();
      } else {
        print("Internet connection disconnected");
      }
    });
  }

  /// Attempt to sync an SMS message
  Future<void> attemptSyncSms(SmsModel sms) async {
    setSyncing(true);
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult != ConnectivityResult.none) {
        // If connected, sync immediately
        await syncSms(sms);
        print("SMS synced successfully");
      } else {
        // If offline, queue the message
        print("No network, queuing message");
        pendingMessages.add(sms);
       // Utils.flushbarErrormesg("No internet connection. SMS queued.");
      }
    } catch (error) {
      print("Error syncing SMS: $error");
    //  Utils.flushbarErrormesg("Error syncing SMS: $error");
    } finally {
      setSyncing(false);
    }
  }

  /// Sync all pending messages
  Future<void> _syncPendingMessages() async {
    if (pendingMessages.isNotEmpty) {
      print("Syncing pending messages");
      for (var sms in List.from(pendingMessages)) { // Iterate over a copy to avoid mutation issues
        try {
          await syncSms(sms);
          print("Pending SMS synced successfully");
        } catch (error) {
          print("Error syncing pending SMS: $error");
         // Utils.flushbarErrormesg("Error syncing pending SMS: $error");
        }
      }
      pendingMessages.clear();  // Clear the queue after syncing
    }
  }

  /// Actual SMS Sync API call
  Future<void> syncSms(SmsModel sms) async {
    try {
      await _myRepo.SyncSmsAPI(sms.toJson());
    } catch (error) {
      print("Sync Error: $error");
    //  Utils.flushbarErrormesg("Sync Error: $error");
    }
  }

  /// Get All Messages API
  List<dynamic> messages = []; // Store list of messages
  Future<void> AllMessageApi(BuildContext context) async {
    try {
      var value = await _myRepo.ALlMESGS(); // Call the function without arguments
      messages = value['data']; // Assuming the API returns a map with a 'data' key
      notifyListeners();
      print(messages); // This should print the list of message objects
    } catch (error) {
      print("Error fetching messages: $error");
      Utils.flushbarErrormesg1("Error fetching messages: $error", context); // Handle error gracefully
    }
  }

  /// Get All Devices API
  List<dynamic> devices = []; // Store list of devices
  Future<void> ALLDeviceAPi(BuildContext context) async {
    try {
      var value = await _myRepo.ALlDevices(); // Call the function without arguments
      devices = value['data']; // Assuming the API returns a map with a 'data' key
      notifyListeners();
      print(devices); // This should print the list of device objects
    } catch (error) {
      print("Error fetching devices: $error");
      Utils.flushbarErrormesg1("Error fetching devices: $error", context); // Handle error gracefully
    }
  }
}
