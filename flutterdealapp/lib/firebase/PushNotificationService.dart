import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:googleapis/servicecontrol/v1.dart' as servicecontrol;

class PushNotificationService {
  static Future<String> getAccessToken() async {
    final serviceAccountJson = {
    };

    List<String> scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];

    http.Client client = await auth.clientViaServiceAccount(
        auth.ServiceAccountCredentials.fromJson(serviceAccountJson), scopes);

    // get the access token
    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
            auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
            scopes,
            client);

    client.close();

    return credentials.accessToken.data;
  }


  static sendNotificationToUser(
    String deviceToken,
    String messageType,
    String messageTitle,
    String messageBody,

    // BuildContext context,
  ) async {
    // if(messageType == "dealMat")
    final String serverKey = await getAccessToken();
    print("serverKey: $serverKey");
    String endpointFirebaseCloudMessaging =
        'https://fcm.googleapis.com/v1/projects/dealapp-363e7/messages:send';

    final Map<String, dynamic> message = {
      'message': {
        'token': deviceToken,
        'notification': {'title': messageTitle, 'body': messageBody}
      }
    };
    final http.Response response = await http.post(
      Uri.parse(endpointFirebaseCloudMessaging),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $serverKey'
      },
      body: jsonEncode(message),
    );
    if (response.statusCode == 200) {
      print("Notification sent successfully");
    } else {
      print("Failed to send notification ${response.statusCode} ");
    }
  }
   static sendClickNotificationToUser(
    String deviceToken,
    String postId,
    String messageTitle,
    String messageBody,
 
    
    // BuildContext context,
  ) async {
    final String serverKey = await getAccessToken();
    String endpointFirebaseCloudMessaging =
        'https://fcm.googleapis.com/v1/projects/dealapp-363e7/messages:send';

    final Map<String, dynamic> message = {
      'message': {
        'token': deviceToken,
        'notification': {'title': messageTitle, 'body': messageBody},
        'data': {'click_action': 'clickSend', 'postId': postId, 'status': 'done', }
      }
    };
    final http.Response response = await http.post(
      Uri.parse(endpointFirebaseCloudMessaging),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $serverKey'
      },
      body: jsonEncode(message),
    );
    if (response.statusCode == 200) {
      print("Notification sent successfully");
    } else {
      print("Failed to send notification ${response.statusCode} ");
    }
  }

  static sendMessageNotificationToUser(
    String deviceToken,
    String messageId,
    String messageTitle,
    String messageBody,
    String receiverId,
    String receiverUsername,
    
    // BuildContext context,
  ) async {
    final String serverKey = await getAccessToken();
    String endpointFirebaseCloudMessaging =
        'https://fcm.googleapis.com/v1/projects/dealapp-363e7/messages:send';

    final Map<String, dynamic> message = {
      'message': {
        'token': deviceToken,
        'notification': {'title': messageTitle, 'body': messageBody},
        'data': {'click_action': 'message', 'messageId': messageId, 'status': 'done', 'receiverId': receiverId, 'receiverUsername': receiverUsername}
      }
    };
    final http.Response response = await http.post(
      Uri.parse(endpointFirebaseCloudMessaging),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $serverKey'
      },
      body: jsonEncode(message),
    );
    if (response.statusCode == 200) {
      print("Notification sent successfully");
    } else {
      print("Failed to send notification ${response.statusCode} ");
    }
  }

  static sendNotificationCreatePost(
    List<String> deviceToken,
    String postId,
    String messageType,
    String messageTitle,
    String messageBody,
    // BuildContext context,
  ) async {
    final String serverKey = await getAccessToken();
    String endpointFirebaseCloudMessaging =
        'https://fcm.googleapis.com/v1/projects/dealapp-363e7/messages:send';

    for (String token in deviceToken) {
      final Map<String, dynamic> message = {
        'message': {
          'token': token,
          'notification': {'title': messageTitle, 'body': messageBody},
          'data': {'click_action': 'test', 'postId': postId, 'status': 'done'},
        },
      };
      final http.Response response = await http.post(
        Uri.parse(endpointFirebaseCloudMessaging),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $serverKey'
        },
        body: jsonEncode(message),
      );
      if (response.statusCode == 200) {
        print("Notification sent successfully");
      } else {
        print("Failed to send notification ${response.statusCode} ");
        print("error: ${response.body}");
      }
    }
  }
}
