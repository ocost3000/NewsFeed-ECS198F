import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class BookmarkFAB extends StatefulWidget {
  const BookmarkFAB({Key? key}) : super(key: key);

  @override
  State<BookmarkFAB> createState() => _BookmarkFABState();
}

class _BookmarkFABState extends State<BookmarkFAB> {
  User? _user;
  late void Function() fireOnPressFunc = () => log("Uninitialized fireFunc");
  late String fireToolTip;
  late Icon fireButtonIcon;

  void loginRequest() {
    log("Ask to login");
    signInWithGoogle();
  }

  void goToBookmarks() {
    log("Go to bookmarks");
    Navigator.pushNamed(context, '/bookmarks');
  }

  static Future<UserCredential> signInWithGoogle() async {
    if (kIsWeb) {
      // Create a new provider
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithPopup(googleProvider);
    } else {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) => setState(() {
          _user = user;
          if (_user == null) {
            // not logged in
            fireOnPressFunc = loginRequest;
            fireToolTip = "Log in here";
            fireButtonIcon = Icon(Icons.person,
                color: Theme.of(context).colorScheme.onSecondary);
          } else {
            // logged in
            fireOnPressFunc = goToBookmarks;
            fireToolTip = "Bookmarks";
            fireButtonIcon = Icon(Icons.bookmark,
                color: Theme.of(context).colorScheme.onSecondary);
          }
        }));
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: fireOnPressFunc,
      tooltip: fireToolTip,
      child: fireButtonIcon,
    );
  }
}
