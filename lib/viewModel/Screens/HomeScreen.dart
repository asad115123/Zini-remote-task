import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:provider/provider.dart';
import 'package:remotetask/NOTIFICATIONSERVICES.dart'; // Import your Notification service
import 'package:remotetask/resources/res/colors.dart';
import 'package:remotetask/viewModel/Screens/GetALL mesgs.dart';
import 'package:permission_handler/permission_handler.dart'; // Add this import for permissions
import '../../main.dart'; // Import your main file for service initialization
import '../authviewModel.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthviewModel>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          'SMS Screen',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () async {
                // Check and request SMS permission
                PermissionStatus smsPermissionStatus = await Permission.sms.status;

                if (smsPermissionStatus.isDenied || smsPermissionStatus.isPermanentlyDenied) {
                  // If permission is denied or permanently denied, navigate to app settings
                  await openAppSettings();
                  return; // Exit from this function
                }

                // Initialize the background service
                final service = FlutterBackgroundService();
                bool isRunning = await service.isRunning();

                if (!isRunning) {
                  // Show notification that the service is starting
                  await NotificationService.showNotification(
                    title: "Service",
                    body: "Starting service...",
                  );

                  await initializeService(); // Ensure this initializes the service
                  service.startService(); // Start the service
                }

                // Show notification for syncing start
                await NotificationService.showNotification(
                  title: "Syncing",
                  body: "Start Syncing SMS...",
                );
                service.invoke('startSyncing'); // Sends the event to the background service
              },
              child: const Text('Start Syncing SMS', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () async {
                final service = FlutterBackgroundService();

                // Show notification for stopping service
                await NotificationService.showNotification(
                  title: "Service",
                  body: "Stopping service...",
                );

                service.invoke('stopSyncing'); // Sends the event to stop syncing
              },
              child: const Text('Stop Syncing SMS', style: TextStyle(color: Colors.white)),
            ),
            // Go to get All messages screen
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: blueColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () async {
                Navigator.push(context, MaterialPageRoute(builder: (context) => GetAllMesg()));
              },
              child: const Text('Press and See All Mesgs', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
