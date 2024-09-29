import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:provider/provider.dart';
import 'package:remotetask/utils/utilss.dart';
import '../../main.dart';
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
        title: const Text('SMS Screen', style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.w500)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(

              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),),minimumSize: Size(double.infinity, 50)),

              onPressed: () async {

                final service = FlutterBackgroundService();
                bool isRunning = await service.isRunning();
                print("Service is running: $isRunning");
                if (!isRunning) {
                 // print("Starting service...");
                  Utils.flushbarErrormesg('Starting service...', context);
                  await initializeService();
                  service.startService();
                }

                print("Invoking startSyncing event...");
                service.invoke('startSyncing'); // This sends the event to the background service
              },
              child: const Text('Start Syncing SMS',style: TextStyle(color: Colors.white),),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),),minimumSize: Size(double.infinity, 50)),
              onPressed: () async {
                final service = FlutterBackgroundService();
              //  print("Stopping service...");
                Utils.flushbarErrormesg1('Stopping service...', context);
                service.invoke('stopSyncing'); // Sends event to stop syncing
              },
              child: const Text('Stop Syncing SMS',style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
