import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remotetask/resources/res/colors.dart';
import 'package:intl/intl.dart'; // Import the intl package

import '../authviewModel.dart';

class AllDevicesScreen extends StatefulWidget {
  const AllDevicesScreen({super.key});

  @override
  State<AllDevicesScreen> createState() => _AllDevicesScreenState();
}

class _AllDevicesScreenState extends State<AllDevicesScreen> {
  @override
  void initState() {
    super.initState();
    var provider = Provider.of<AuthviewModel>(context, listen: false);
    provider.ALLDeviceAPi(context); // Fetch devices on init
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthviewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueColor,
        title: Text(
          "Get ALL Device",
          style: TextStyle(color: WhiteColor, fontSize: 20,fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body:
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [

        provider.loading
            ? Center(child: CircularProgressIndicator()) // Show loading indicator
            : provider.devices.isEmpty
            ? Center(child: Text('No Device found')) // Show if no devices
            : ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: provider.devices.length, // Number of devices
          itemBuilder: (context, index) {
            var deviceData = provider.devices[index]; // Access each device

            // Format the 'registeredAt' date
            String formattedDate = formatDate(deviceData['registeredAt']);

            return Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff333333).withOpacity(0.1),
                    offset: Offset(0, 4),
                    blurRadius: 24,
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email: ${deviceData['email'] ?? 'No email'}', // Display email
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5),
                  Text('API Key: ${deviceData['apiKey'] ?? 'No API Key'}', style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),), // Display API key
                  SizedBox(height: 5),
                  Text('Device Name: ${deviceData['deviceName'] ?? 'No Device Name'}', style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),), // Display device name
                  SizedBox(height: 5),
                  Text('Device Model: ${deviceData['deviceModel'] ?? 'No Model'}', style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),), // Display device model
                  SizedBox(height: 5),
                  Text('Registered At: $formattedDate', style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),), // Display formatted time
                ],
              ),
            );
          },
        ),

          ],
        ),
      )
    );
  }

  // Helper function to format the date
  String formatDate(String dateStr) {
    try {
      DateTime dateTime = DateTime.parse(dateStr); // Parse the date string
      return DateFormat('yyyy/MM/dd').format(dateTime); // Format to 'yyyy/MM/dd'
    } catch (e) {
      return 'Invalid date'; // Handle parsing errors
    }
  }
}
