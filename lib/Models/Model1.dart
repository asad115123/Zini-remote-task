class SmsModel {
  final String message;
  final String from;
  final String timestamp;

  SmsModel({required this.message, required this.from, required this.timestamp});

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'from': from,
      'timestamp': timestamp,
    };
  }

  // Method to create an instance from JSON
  factory SmsModel.fromJson(Map<String, dynamic> json) {
    return SmsModel(
      message: json['message'],
      from: json['from'],
      timestamp: json['timestamp'],
    );
  }
}
