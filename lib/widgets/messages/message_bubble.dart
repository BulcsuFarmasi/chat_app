import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(this.message, this.userName, this.userImage, this.isMe,
      {super.key});

  final String userName;
  final String userImage;
  final String message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: isMe
                        ? Colors.grey.shade300
                        : Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(12),
                      topRight: const Radius.circular(12),
                      bottomLeft: !isMe
                          ? const Radius.circular(0)
                          : const Radius.circular(12),
                      bottomRight: !isMe
                          ? const Radius.circular(12)
                          : const Radius.circular(0),
                    )),
                width: 140,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                child: Column(
                  crossAxisAlignment:
                      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Text(userName,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: isMe
                                ? Colors.grey
                                : Theme.of(context).colorScheme.onSecondary,
                            fontWeight: FontWeight.bold)),
                    Text(message,
                        textAlign: isMe ? TextAlign.end : TextAlign.start,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: isMe
                                ? Colors.grey
                                : Theme.of(context).colorScheme.onSecondary)),
                  ],
                ),
              ),
            ]),
        Positioned(
          top: 0,
          left: isMe ? null : 120,
          right: isMe ? 120 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(userImage),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
