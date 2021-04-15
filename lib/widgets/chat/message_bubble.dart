import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String username;
  final String imageUrl;
  final bool isMe;
  final Key key;

  MessageBubble(this.message, this.username, this.imageUrl, this.isMe,
      {this.key});

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
                color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
                  bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
                ),
              ),
              width: 140,
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              child: MessageBubbleText(isMe: isMe, username: username, message: message),
            ),
          ],
        ),
        Positioned(
          child: CircleAvatar(
            backgroundImage: imageUrl != null ? NetworkImage(imageUrl) : null,
          ),
          top: -20,
          left: !isMe ? 120 : null,
          right: !isMe ? null : 120,
        ),
      ],
      overflow: Overflow.visible,
    );
  }
}

class MessageBubbleText extends StatelessWidget {
  const MessageBubbleText({
    Key key,
    @required this.isMe,
    @required this.username,
    @required this.message,
  }) : super(key: key);

  final bool isMe;
  final String username;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          username,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isMe
                ? Colors.black
                : Theme.of(context).accentTextTheme.bodyText1.color,
          ),
        ),
        Text(
          message,
          style: TextStyle(
            color: isMe
                ? Colors.black
                : Theme.of(context).accentTextTheme.bodyText1.color,
          ),
        ),
      ],
    );
  }
}
