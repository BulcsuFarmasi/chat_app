import 'package:firebase_auth/firebase_auth.dart';

import './message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (BuildContext ctx, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final chatDocuments = chatSnapshot.data!.docs;

          return ListView.builder(
            itemBuilder: (BuildContext ctx, int index) => MessageBubble(
              chatDocuments[index]['text'],
              chatDocuments[index]['userName'],
              chatDocuments[index]['userImage'],
              chatDocuments[index]['userId'] == user!.uid,
              key: ValueKey(chatDocuments[index].id),
            ),
            itemCount: chatDocuments.length,
            reverse: true,
          );
        });
  }
}
