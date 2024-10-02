import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package
import 'package:provider/provider.dart';
import 'package:remotetask/resources/res/colors.dart';
import '../authviewModel.dart';

class GetAllMesg extends StatefulWidget {
  const GetAllMesg({super.key});

  @override
  State<GetAllMesg> createState() => _GetAllMesgState();
}

class _GetAllMesgState extends State<GetAllMesg> {
  @override
  void initState() {
    super.initState();
    var provider = Provider.of<AuthviewModel>(context, listen: false);
    provider.AllMessageApi(context);
  }

  // Function to format the time in YYYY/MM/DD format
  String formatTime(String time) {
    try {
      DateTime parsedTime = DateTime.parse(time); // Parse the time string to DateTime
      return DateFormat('yyyy/MM/dd').format(parsedTime); // Format the DateTime object
    } catch (e) {
      return 'Unknown'; // Handle any parsing errors
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthviewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueColor,
        title: Text(
          'ALL Messages',
          style: TextStyle(color: WhiteColor, fontSize: 20, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 20),
            provider.loading
                ? Center(child: CircularProgressIndicator()) // Show loading indicator
                : provider.messages.isEmpty
                ? Center(child: Text('No messages found')) // Show if no messages
                : ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: provider.messages.length, // Number of messages
              itemBuilder: (context, index) {
                var messageData = provider.messages[index]; // Access each message
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
                      // Display message number
                      Text(
                        'Message #${index + 1}', // Message number starts from 1
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Message: ${messageData['message'] ?? 'No message'}', // Display message
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'From: ${messageData['from'] ?? 'Unknown'}',
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                      ), // Display 'from'
                      SizedBox(height: 5),
                      Text(
                        'Time: ${formatTime(messageData['time'])}',
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                      ), // Format and display time
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
