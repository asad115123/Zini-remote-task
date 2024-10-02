import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:provider/provider.dart';
import 'package:remotetask/HomeScreen2.dart';
import 'package:remotetask/NOTIFICATIONSERVICES.dart';
import 'package:remotetask/viewModel/Screens/ALL_Devices.dart';
import 'package:remotetask/viewModel/Screens/GetALL mesgs.dart';
import 'package:remotetask/viewModel/Screens/HomeScreen.dart';
import 'package:remotetask/viewModel/Screens/LoginScreen.dart';
import 'package:remotetask/viewModel/authviewModel.dart';
import 'Models/Model1.dart';

// Global keys
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>(); // Global navigatorKey

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initializeNotification();
  await initializeService(); // Initialize the service
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
      notificationChannelId: 'com.example.remotetask',
      initialNotificationTitle: "Background Service Running",
      initialNotificationContent: "SMS syncing is running in the background",
      foregroundServiceNotificationId: 888,
    ),
    iosConfiguration: IosConfiguration(
      onForeground: onStart,
      autoStart: true,
    ),
  );

  await startServiceIfNeeded(service);
}

// Service start handler
void onStart(ServiceInstance service) async {
  if (service is AndroidServiceInstance) {
    service.setForegroundNotificationInfo(
      title: "SMS Syncing",
      content: "SMS syncing is running in the background",
    );
  }

  // Notify that the service has started
  await NotificationService.showNotification(
    title: "Service Started",
    body: "Background service is running.",
  );

  service.on('startSyncing').listen((event) async {
    SmsModel sms = SmsModel(
      message: "Test message now",
      from: "+1234567890",
      timestamp: "2024-07-31T10:00:00Z",
    );

    final authViewModel = AuthviewModel();
    await authViewModel.attemptSyncSms(sms);
  });

  service.on('stopSyncing').listen((event) {
    service.stopSelf();
  });
}

// Check if service is running and start it if not
Future<void> startServiceIfNeeded(FlutterBackgroundService service) async {
  bool isRunning = await service.isRunning();

  if (!isRunning) {
    await NotificationService.showNotification(
      title: "Service",
      body: "Starting service...",
    );
    await service.startService(); // Ensure this starts the service correctly
  } else {
    await NotificationService.showNotification(
      title: "Service",
      body: "The service is already running.",
    );
  }
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
        navigatorKey: navigatorKey, // Assign global navigatorKey here
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: LOGINSCREEN(), // Initial screen
      ),
    );
  }
}
