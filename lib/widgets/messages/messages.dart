import './message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance.collection('chat').orderBy('createdAt', descending: true).snapshots(),
        builder: (BuildContext ctx, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final chatDocuments = chatSnapshot.data.documents;
          return ListView.builder(
            itemBuilder: (BuildContext ctx, int index) => MessageBubble(chatDocuments[index]['text']),
            itemCount: chatDocuments.length,
            reverse: true,
          );
        });
  }
}
