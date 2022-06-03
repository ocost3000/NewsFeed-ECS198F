import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_feed/services/firebase_helper.dart';

class SignInStatus extends StatefulWidget {
  const SignInStatus({Key? key}) : super(key: key);

  @override
  State<SignInStatus> createState() => _SignInStatusState();
}

class _SignInStatusState extends State<SignInStatus> {
  User? _user;
  late Widget _fireIcon;
  late Function() _fireOnPressed = () => log("Uninitialied sign in button");

  Future<String?> _signOutPrompt() async {
    log("Signing out");
    return showDialog<String>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) => AlertDialog(
              title: const Text("Sign out?"),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    FirebaseHelper.signOutWithGoogle();
                    Navigator.pop(context, 'Yes');
                  },
                  child: const Text('Yes'),
                ),
              ],
            ));
  }

  void _signInPrompt() {
    log("AppBar signin prompt");
    FirebaseHelper.signInWithGoogle();
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) => setState(() {
          _user = user;
          if (_user == null) {
            _fireIcon = const Icon(Icons.person_add);
            _fireOnPressed = _signInPrompt;
          } else {
            // not sure if all users will have photo url or if only those who
            // uploaded a profile pic
            // so I will null check anywyas
            String? url = FirebaseAuth.instance.currentUser!.photoURL;
            if (url == null) {
              _fireIcon = const Icon(Icons.person);
            } else {
              _fireIcon = CircleAvatar(backgroundImage: NetworkImage(url));
            }
            _fireOnPressed = _signOutPrompt;
          }
        }));
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: _fireOnPressed, icon: _fireIcon);
  }
}
