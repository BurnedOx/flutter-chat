import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: firestore
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final docs = snapshot.data.docs;
        return ListView.builder(
          reverse: true,
          itemCount: docs.length,
          itemBuilder: (ctx, index) => Container(
            padding: EdgeInsets.all(10),
            child: FutureBuilder<DocumentSnapshot>(
                future: firestore
                    .collection('users')
                    .doc(docs[index]['userId'])
                    .get(),
                builder: (ctx, user) {
                  return MessageBubble(
                    docs[index]['text'],
                    user.connectionState == ConnectionState.waiting
                        ? 'Loading...'
                        : user.data['username'],
                    user.connectionState == ConnectionState.waiting
                        ? null
                        : user.data['image_url'],
                    docs[index]['userId'] == _user.uid,
                    key: ValueKey(docs[index].id),
                  );
                }),
          ),
        );
      },
    );
  }
}
