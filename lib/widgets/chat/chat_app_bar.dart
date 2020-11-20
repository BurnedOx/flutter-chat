import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  final _auth = FirebaseAuth.instance;

  ChatAppBar({Key key})
      : preferredSize = Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Chaty'),
      actions: [
        DropdownButton(
          icon: Icon(
            Icons.more_vert,
            color: Theme.of(context).primaryIconTheme.color,
          ),
          items: [
            DropdownMenuItem(
              value: 'logout',
              child: Container(
                child: Row(
                  children: [
                    Icon(Icons.exit_to_app),
                    SizedBox(width: 8),
                    Text('Logout'),
                  ],
                ),
              ),
            ),
          ],
          onChanged: (itemIdentifier) {
            if (itemIdentifier == 'logout') {
              _auth.signOut();
            }
          },
        ),
      ],
    );
  }
}
