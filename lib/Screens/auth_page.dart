
import 'package:firebase_todo/Screens/login_page.dart';
import 'package:firebase_todo/Screens/sign_up_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  
  @override
  Widget build(BuildContext context) {
    return isLogin? LoginPage(onClickSignUP: toggle):SignUpPage(onClickSignIn: toggle,);
  }

  void toggle() => setState(() => isLogin = !isLogin);
   

}