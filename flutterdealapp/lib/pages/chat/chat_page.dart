import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutterdealapp/pages/chat/chat_service.dart';
import 'package:flutterdealapp/pages/postDetail/postDetail_page.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserId;
  final String receiverUsername;
  final String pid;
  const ChatPage(
      {super.key,
      required this.receiverUserId,
      required this.receiverUsername,
      required this.pid});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.pid, widget.receiverUserId, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // BlocProvider.of<PostBloc>(context).add(getPostData());
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => postDetailPage(
              //               pid: widget.pid,
              //             )));
              Navigator.of(context).pop();
            },
          ),
          title: Text(widget.receiverUsername),
        ),
        // appBar: AppBar(
        //   backgroundColor: Colors.blue,
        //   title: Text(widget.receiverUsername),
        // ),
        body: Column(
          children: [
            Expanded(
              child: _buildmessageList(),
            ),
            _buildMessageInput(),
          ],
        ));
  }

  Widget _buildmessageList() {
    return StreamBuilder(
        stream: _chatService.getMessages(
            widget.pid, widget.receiverUserId, _firebaseAuth.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('loading');
          }

          // return Text("data loaded");
          // return ListView(children: [
          //   Text(widget.receiverUserEmail),
          //   Text(widget.receiverUserId),
          //   Text(_firebaseAuth.currentUser!.uid),

          // ],);
          // if(snapshot.hasData){
          //   return Text("ta");
          // }
          return ListView(
              children: snapshot.data!.docs
                  .map((DocumentSnapshot document) =>
                      _buildMessageItem(document))
                  .toList());
        });
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment:
                (data['senderId'] == _firebaseAuth.currentUser!.uid)
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
            mainAxisAlignment:
                (data['setnderId'] == _firebaseAuth.currentUser!.uid)
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
            children: [
              Text(data['senderEmail']),
              Text(data['message']),
            ]),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _messageController,
            decoration: InputDecoration(hintText: 'Enter your message'),
          ),
        ),
        IconButton(
          icon: Icon(Icons.send),
          onPressed: sendMessage,
        )
      ],
    );
  }
}
