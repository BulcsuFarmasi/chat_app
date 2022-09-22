import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(this.message, this.userName, this.userImage, this.isMe,
      {this.key});

  final String userName;
  final String userImage;
  final String message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: isMe
                        ? Colors.grey.shade300
                        : Theme.of(context).accentColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                      bottomLeft:
                          !isMe ? Radius.circular(0) : Radius.circular(12),
                      bottomRight:
                          !isMe ? Radius.circular(12) : Radius.circular(0),
                    )),
                width: 140,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                child: Column(
                  crossAxisAlignment:
                      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Text(userName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isMe
                                ? Colors.grey
                                : Theme.of(context)
                                    .accentTextTheme
                                    .headline1
                                    .color)),
                    Text(
                      message,
                      textAlign: isMe ? TextAlign.end : TextAlign.start,
                      style: TextStyle(
                          color: isMe
                              ? Colors.grey
                              : Theme.of(context)
                                  .accentTextTheme
                                  .headline1
                                  .color),
                    ),
                  ],
                ),
              ),
            ]),
        Positioned(
          child: CircleAvatar(
            backgroundImage: NetworkImage(userImage),
          ),
          top: 0,
          left: isMe ? null : 120,
          right: isMe ? 120 : null,
        ),
      ],
      clipBehavior: Clip.none,
    );
  }

  final Key key;
}
