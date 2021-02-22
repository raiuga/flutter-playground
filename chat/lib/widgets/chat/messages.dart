import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return StreamBuilder(
          stream: Firestore.instance
              .collection('chat')
              .orderBy(
                'createdAt',
                descending: true,
              )
              .snapshots(),
          builder: (ctx, chatSnapshot) {
            if (chatSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            final chatDocuments = chatSnapshot.data.documents;
            return ListView.builder(
              reverse: true,
              itemCount: chatDocuments.length,
              itemBuilder: (ctx, index) => MessageBubble(
                chatDocuments[index]['text'],
                chatDocuments[index]['username'],
                chatDocuments[index]['userId'] == futureSnapshot.data.uid,
                key: ValueKey(chatDocuments[index].documentID),
              ),
            );
          },
        );
      },
    );
  }
}
