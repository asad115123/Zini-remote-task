# ZINI PAY - SMS Sync Mobile Application

## Overview
My name is **Asad Bangash**, and I am a Flutter developer with 2 years of experience. This project was developed as a task for a remote position at ZINI PAY. The application allows users to log in and sync incoming SMS messages in the background.

## Features
- **User Authentication**:
    - Users can log in using the following credentials:
        - **Email**: `user1@example.com`
        - **API Key**: `apikey1`
- **Home Screen**:
    - Displays two buttons:
        - **Start Syncing SMS**: Begins syncing SMS messages in the background.
        - **Stop Syncing SMS**: Halts the SMS syncing process.

## Functionality
1. **Login**:
    - Upon launching the app, users log in using the specified email and API key.
2. **Home Screen**:
    - The **Start** button initiates SMS syncing, and the app runs in the background, displaying a notification.
    - The **Stop** button stops SMS syncing and ends background operations.
    - Users can view all synced messages and devices within the app.
3. **Internet Connection Handling**:
    - If the internet connection is off when the **Start** button is pressed, the messages will be saved in a queue.
    - Once the internet connection is restored, the queued messages will be sent automatically.
4. **Error Handling**:
    - All responses, including errors, are displayed in the console for monitoring.

## API Endpoints
### Authentication
- **Login API**: `POST https://sfs-app-test-server.vercel.app/app/auth`
    - **Request Body**:
      ```json
      {
        "email": "user1@example.com",
        "apiKey": "apikey1"
      }
      ```
    - **Success Response**:
      ```json
      {
        "success": true,
        "message": "Authentication successful"
      }
      ```

### SMS Sync
- **Sync API**: `POST https://sfs-app-test-server.vercel.app/sms/sync`
    - **Request Body**:
      ```json
      {
        "message": "Test message now",
        "from": "+1234567890",
        "timestamp": "2024-07-31T10:00:00Z"
      }
      ```
    - **Success Response**:
      ```json
      {
        "success": true,
        "message": "SMS synced successfully."
      }
      ```

### Additional Endpoints
- **View All Messages**: `GET https://sfs-app-test-server.vercel.app/sms`
- **View All Devices/Login Credentials**: `GET https://sfs-app-test-server.vercel.app/devices`

## Installation

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Dart](https://dart.dev/get-dart)

### Setup Instructions
1. **Clone the repository**:
   ```bash
   git clone https://github.com/yourusername/zini_pay.git
   cd zini_pay
