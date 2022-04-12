import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemBuilder: (BuildContext context, int index) => Container(child: Text('That works!'), padding: EdgeInsets.all(8),), itemCount: 10,),
    );
  }
}
