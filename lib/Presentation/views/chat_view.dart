import 'package:chatapp/core/services/user_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/chat_model.dart';
import 'chat_widget.dart';

class ChatView extends StatelessWidget {
  final String room;
  ChatView({super.key, required this.room});

  final TextEditingController messageController = TextEditingController();
  final UserInfoService userInfoService = UserInfoService();

  @override
  Widget build(BuildContext context) {
    final DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref('chat_rooms/$room');

    Stream getMessages() {
      return databaseReference.onValue;
    }

    Future<void> sendMessage(String sender, String text) async {
      await databaseReference.child('messages').push().set({
        'sender': sender, // Replace with your user authentication logic
        'text': text,
        'timeStamp': ServerValue.timestamp,
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(room),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
          onPressed: context.pop,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: getMessages(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    List<ChatMessage> messages = [];
                    var messageMap = (snapshot.data).snapshot.value;
                    // debugPrint((snapshot.data).snapshot.value.toString());
                    if (messageMap != null) {
                      messageMap["messages"].forEach((key, value) {
                        messages.add(ChatMessage(
                            sender: value['sender'],
                            text: value['text'],
                            timestamp: value['timeStamp']));
                        messages
                            .sort((a, b) => a.timestamp.compareTo(b.timestamp));
                      });
                    }

                    return ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        ChatMessage message = messages[index];
                        return Align(
                          alignment:
                              (message.sender == userInfoService.currentUser!)
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                          child:
                              (message.sender == userInfoService.currentUser!)
                                  ? RightChat(msg: message)
                                  : LeftChat(msg: message),
                        );
                      },
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: const InputDecoration(
                        fillColor: Colors.grey,
                        filled: true,
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      sendMessage(
                        userInfoService.currentUser!,
                        messageController.text,
                      );
                      messageController.clear();
                    },
                    icon: const Icon(Icons.send),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
