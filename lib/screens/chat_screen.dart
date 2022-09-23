import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../widgets/messages/messages.dart';
import '../widgets/messages/new_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  static const logout = 'logout';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    final fbm = FirebaseMessaging.instance;
    fbm.requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(message);
      return;
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(message);
      return;
    });
    fbm.subscribeToTopic('chat');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlutterChat'),
        actions: [
          DropdownButton(
            underline: Container(),
            items: [
              DropdownMenuItem(
                value: 'logout',
                child: Row(
                  children: const [
                    Icon(Icons.exit_to_app),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Logout')
                  ],
                ),
              )
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == ChatScreen.logout) {
                FirebaseAuth.instance.signOut();
              }
            },
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
          )
        ],
      ),
      body: Column(
        children: const [Expanded(child: Messages()), NewMessage()],
      ),
    );
  }
}
