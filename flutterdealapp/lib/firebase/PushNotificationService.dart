import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:googleapis/servicecontrol/v1.dart' as servicecontrol;

class PushNotificationService {
  static Future<String> getAccessToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "dealapp-363e7",
      "private_key_id": "8bfffbc57a70915df01e8192cb039af0cb241cc5",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDjqgQLOI6XrnH4\n7dzQJwoSmxXF46W8iKWrw6fcmwHHqusrI95fu5o0Sg/DFk0EJLSfivekx364/f5i\nUI+Vj7TRiWTy6vMxd1eN5nSJs6jS9hHkg4Yj0m9Aqsn0OBmYzeyqWbRV1sxplPuN\nmmkFp9bBYCjbWfoCVFx1efi/E0eTsMA1fXUaGM9GjN/4ZtKITQhwC3fDomRiqp+1\n547tHNROz8118mVIJ4ZE720JFOFAZWEDZYoKn+HZy0HmKuwvjX0U87vfK9qKDWDZ\nfbRzbFiHlIowWU8cQN6J3hvPX7lMnVnyMFTYThrclyODUyfzU1GrNP7VpGxh2eKz\nroPa3ZCZAgMBAAECggEAAngRzqhYnYsCB+vWePhvase9SvXe0oZd25jF3YXd1VNE\ndSWQsBOaBsal2J0JjUmznsZUTLhwJqP0ig7rG7lhAeO+UUcch5UOgUa2TVcCNfV+\nuK53ejR6SeaARbKFDovvLOLHqqWndl6sArtht7K8CMFY+BYH+NX+4bRGrxXPsSmU\nk4YQ3B5UA2vBrBPqG+8ZnExFIUCWl6f3f61aa2+nEz2oji820fgyLg7+3/YAtZOq\nuD407ps6Xhpi5I6K4hxTm1y3NdJvn2J0zBoP5C8W2xl4RBuS9hSda8cMFnKn2qCf\nVdyxRJBcAHUrJrdqYxBGuyxyZLc/4HXSSVQQ2z0nIQKBgQDyl5eL6vYRYA0FpQ19\nEWk8UgAA9bFPFJIm9aeC6Yw6zOLLpt+zksDduAcz/jNLcEei9mgjYu3F/fi3Lgfq\nqjog7VjzrBIyPVtGgo5C4Co+DpfNT397cQwUYHsMPG1X3WObsieAfym1Jw1sTaCo\nLc0f/Z6LbPFlmSXeAlDRx4Gl8QKBgQDwPzV2lF6TIQWgk24oOdqBr7EVjAor/6T6\nL1Rz0o3N3MmxRklZqvMqfBhr2Ayn4iuArAl+fpPF1ffSgZejAfaf5CJdZE10Iz8M\niqwXh+tgAozE9Fu86+vxMLEt1MXKDkE6+BPyyAhekkTKnGpV0Vn3Kpjbn5NjGGmN\nPP110LjNKQKBgFW24kD5v//bpD4+V0m9gSVjA8VTClcauZkyawGCa53LDsdOKvRU\nAflVMJZaVt1syqL11U3Lgp/WYK64gOuVQfyoYCmYvsUpkLqVHpbahZJvrYtJb426\nH76DaHamUywceTll9TcdtyrepYuC0iUaKcQH5KD22URAnHSY9N1qVJDBAoGBAIZo\nRofdv/9+NQC+Gp3kqAtv+Jl+bF5rOqhBfHUD8hOfFzPXh8fjrQEyxhLnn0T5cq8d\nEH61YAUJjQk3OVeYDJstbdBkAjUcVvS0TE0p3JQtOQYjU4OhVbHtNOLYLAO77+CG\n09o68Pu/xz63PYJfin6OVVBhuXpyOPMskPyt1gXpAoGAbW4fVfc1mkiQKlHkKKuR\n4wgSkqGZtBS72w3ymE4ibn/vruNH4e/hU2h7nIq5iKN1ClKJlnWjp+sOCgv8ONXK\n0PsQxzeXksZExxuqDRLeYw8ZmvbniN4yNWj8H7qp155rOM86qwYZyUN7Z9oHHlqL\nKUbf7Z2BxeyCzhWVQaEv60k=\n-----END PRIVATE KEY-----\n",
      "client_email": "flutterdealnoti@dealapp-363e7.iam.gserviceaccount.com",
      "client_id": "112785804254477751397",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/flutterdealnoti%40dealapp-363e7.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
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
