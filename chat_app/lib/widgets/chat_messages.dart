import 'package:chat_app/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    final userAuthenticated = FirebaseAuth.instance.currentUser!;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('create_at', descending: true)
          .snapshots(),
      builder: (ctx, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!chatSnapshot.hasData || chatSnapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No messages'),
          );
        }
        if (chatSnapshot.hasError) {
          return const Center(
            child: Text('Something went wrong'),
          );
        }

        final loadedMessages = chatSnapshot.data!.docs;
        return ListView.builder(
            padding: const EdgeInsets.only(bottom: 40, left: 16, right: 16),
            reverse: true,
            itemCount: loadedMessages.length,
            itemBuilder: (ctx, index) {
              final chatMessage = loadedMessages[index].data();
              final nextChatMessage = index + 1 < loadedMessages.length
                  ? loadedMessages[index + 1]
                  : null;

              final currentMessageUserId = chatMessage["user_id"];
              final nextMessageUserId =
                  nextChatMessage != null ? nextChatMessage["user_id"] : null;
              final nextUserIsSame = nextMessageUserId == currentMessageUserId;
              if (nextUserIsSame) {
                return MessageBubble.next(
                  message: chatMessage["text"],
                  isMe: userAuthenticated.uid == currentMessageUserId,
                );
              } else {
                return MessageBubble.first(
                  message: chatMessage["text"],
                  isMe: userAuthenticated.uid == currentMessageUserId,
                  userImage: chatMessage['user_image'],
                  username: chatMessage['username'],
                );
              }
            });
      },
    );
  }
}
