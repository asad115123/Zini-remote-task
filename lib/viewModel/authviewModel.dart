import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:remotetask/viewModel/Screens/HomeScreen.dart';
import '../Models/Model1.dart';
import '../NOTIFICATIONSERVICES.dart';
import '../repository/AuthRepo.dart';

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
      await NotificationService.showNotification(
        title: "Login Success",
        body: "You have successfully logged in.",
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => Homescreen()));
    } catch (error) {
      await NotificationService.showNotification(
        title: "Login Failed",
        body: "Error: $error",
      );
    } finally {
      setLoading(false);
    }
  }

  void _initializeConnectivityListener() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none) {
        NotificationService.showNotification(
          title: "Internet Connected",
          body: "You are now online.",
        );
        _syncPendingMessages();
      } else {
        NotificationService.showNotification(
          title: "Internet Disconnected",
          body: "No internet connection.",
        );
      }
    });
  }

  Future<void> attemptSyncSms(SmsModel sms) async {
    setSyncing(true);
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult != ConnectivityResult.none) {
        await syncSms(sms);
        await NotificationService.showNotification(
          title: "SMS Synced",
          body: "SMS synced successfully.",
        );
      } else {
        await NotificationService.showNotification(
          title: "No Network",
          body: "Message queued due to no internet.",
        );
        pendingMessages.add(sms);
      }
    } catch (error) {
      await NotificationService.showNotification(
        title: "Sync Failed",
        body: "Error syncing SMS: $error",
      );
    } finally {
      setSyncing(false);
    }
  }

  Future<void> _syncPendingMessages() async {
    if (pendingMessages.isNotEmpty) {
      for (var sms in List.from(pendingMessages)) {
        try {
          await syncSms(sms);
          await NotificationService.showNotification(
            title: "Pending SMS Synced",
            body: "SMS synced successfully.",
          );
        } catch (error) {
          await NotificationService.showNotification(
            title: "Sync Failed",
            body: "Error syncing pending SMS: $error",
          );
        }
      }
      pendingMessages.clear();
    }
  }

  Future<void> syncSms(SmsModel sms) async {
    try {
      await _myRepo.SyncSmsAPI(sms.toJson());
      await NotificationService.showNotification(
        title: "Sync Success",
        body: "SMS synced successfully.",
      );
    } catch (error) {
      await NotificationService.showNotification(
        title: "Sync Error",
        body: "Sync failed: $error",
      );
    }
  }



  List messages=[];
  Future<void> AllMessageApi(BuildContext context) async {
    try {
      var value = await _myRepo.ALlMESGS();
      messages = value['data'];
      notifyListeners();
      await NotificationService.showNotification(
        title: "Messages Fetched",
        body: "All messages fetched successfully.",
      );
    } catch (error) {
      await NotificationService.showNotification(
        title: "Fetch Error",
        body: "Error fetching messages: $error",
      );
    }
  }
  List devices=[];
  Future<void> ALLDeviceAPi(BuildContext context) async {
    try {
      var value = await _myRepo.ALlDevices();
      devices = value['data'];
      notifyListeners();
      await NotificationService.showNotification(
        title: "Devices Fetched",
        body: "All devices fetched successfully.",
      );
    } catch (error) {
      await NotificationService.showNotification(
        title: "Fetch Error",
        body: "Error fetching devices: $error",
      );
    }
  }
}
