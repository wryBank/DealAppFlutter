import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
  final String Mid;
  final String senderId;
  final String senderUsername;
  final String receiverId;
  final String message;
  final Timestamp timestamp;
  
  Message({
    required this.Mid,
    required this.senderId,
    required this.senderUsername,
    required this.receiverId,
    required this.message,
    required this.timestamp
  });

  Map<String,dynamic> toMap(){
    return {
      'Mid':Mid,
      'senderId' : senderId,
      'senderUsername' : senderUsername,
      'receiverId':receiverId,
      'message': message,
      'timestamp':timestamp,

    };
    
  }
}
