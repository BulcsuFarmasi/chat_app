import 'package:firebase_auth/firebase_auth.dart';

import './message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (BuildContext ctx, AsyncSnapshot<FirebaseUser> userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return StreamBuilder(
              stream: Firestore.instance.collection('chat').orderBy('createdAt', descending: true).snapshots(),
              builder: (BuildContext ctx, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
                if (chatSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                final chatDocuments = chatSnapshot.data.documents;

                return ListView.builder(
                  itemBuilder: (BuildContext ctx, int index) => MessageBubble(
                    chatDocuments[index]['text'],
                    chatDocuments[index]['userName'],
                    chatDocuments[index]['userId'] == userSnapshot.data.uid,
                    key: ValueKey(chatDocuments[index].documentID),
                  ),
                  itemCount: chatDocuments.length,
                  reverse: true,
                );
              });
        });
  }
}
