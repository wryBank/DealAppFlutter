import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../firebase/PushNotificationService.dart';
import '../../model/message.dart';

class ChatService extends ChangeNotifier{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  Future<void> sendMessage(String chatIDbyPostId,String receiverId , String message)async{
    final userRef = FirebaseFirestore.instance.collection('users').doc(receiverId);
    final usernapshot = await userRef.get();
    
      final userdata = usernapshot.data() as Map<String, dynamic>;

    
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentEmail = _firebaseAuth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();


    Message newMessage = Message(
      Mid: chatIDbyPostId,
      senderId: currentUserId,
      senderEmail: currentEmail,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp
    );

    List<String> ids = [currentUserId,receiverId];
    ids.sort();
    String chatId = ids.join('_');

    await _firestore.collection('chat_rooms').doc(chatIDbyPostId).collection('messages').add(newMessage.toMap());
          PushNotificationService.sendMessageNotificationToUser(userdata['userToken'],
              chatIDbyPostId,"messagge","message",receiverId,"users");
  }

  Stream<QuerySnapshot> getMessages(String pid,String uid,String otherUid){
    List<String> ids = [uid,otherUid];
    ids.sort();
    String chatId = ids.join('_');
    print(chatId);
    return _firestore.collection('chat_rooms').doc(pid).collection('messages').orderBy('timestamp',descending: false).snapshots();
  }
}