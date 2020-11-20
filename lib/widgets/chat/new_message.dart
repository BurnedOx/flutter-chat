import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String _message = '';
  final _fireStore = FirebaseFirestore.instance;
  final _controller = new TextEditingController();
  final _user = FirebaseAuth.instance.currentUser;

  void handleSubmit() {
    FocusScope.of(context).unfocus();
    _fireStore.collection('chat').add({
      'text': _message,
      'createdAt': Timestamp.now(),
      'userId': _user.uid,
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Send a message...'),
              onChanged: (value) {
                setState(() => _message = value);
              },
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(Icons.send),
            onPressed: _message.trim().isEmpty ? null : handleSubmit,
          ),
        ],
      ),
    );
  }
}
