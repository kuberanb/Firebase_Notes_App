import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todo/Screens/auth_page.dart';
import 'package:firebase_todo/Screens/notes_List.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Something Went Wrong',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            );
          } else if (snapshot.hasData) {
            return const NotesList();
          } else {
            return const AuthPage();
          }
        }),
      ),
    );
  }
}
