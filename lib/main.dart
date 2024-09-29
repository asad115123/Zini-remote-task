import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
 // Add the background service package

import 'package:provider/provider.dart';
import 'package:remotetask/viewModel/Screens/HomeScreen.dart';
import 'package:remotetask/viewModel/Screens/LoginScreen.dart';
import 'package:remotetask/viewModel/authviewModel.dart';
import 'Models/Model1.dart';
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Make sure Flutter binding is initialized
  await initializeService();
  // Initialize background service here
  runApp(const MyApp());
}

// Initialize background service
Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: true,
      notificationChannelId: 'com.example.remotetask', // Use a unique ID
      initialNotificationTitle: "Background Service Running",
      initialNotificationContent: "SMS syncing is running in the background",
      foregroundServiceNotificationId: 888, // Unique notification ID
    ),
    iosConfiguration: IosConfiguration(
      onForeground: onStart,
      autoStart: true,
    ),
  );

  service.startService(); // Start the background service
}

void onStart(ServiceInstance service) async {
  if (service is AndroidServiceInstance) {
    service.setForegroundNotificationInfo(
      title: "SMS Syncing",
      content: "SMS syncing is running in the background",
    );
  }

  print("Service started");

  // Listen for "startSyncing" event to trigger SMS syncing
  service.on('startSyncing').listen((event) async {
    print("Received startSyncing event");

    SmsModel sms = SmsModel(
      message: "Test message now",
      from: "+1234567890",
      timestamp: "2024-07-31T10:00:00Z",
    );

    final authViewModel = AuthviewModel();
    await authViewModel.attemptSyncSms(sms,);
  });

  service.on('stopSyncing').listen((event) {
    service.stopSelf();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthviewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
         scaffoldMessengerKey: scaffoldMessengerKey,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:LOGINSCREEN(),
      ),
    );
  }
}
