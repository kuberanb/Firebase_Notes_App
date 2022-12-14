import 'dart:ui';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todo/Screens/forgot_password_page.dart';
import 'package:firebase_todo/main.dart';
import 'package:flutter/material.dart';

import 'Utills.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onClickSignUP;
  const LoginPage({super.key, required this.onClickSignUP});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;

    final formKey = GlobalKey<FormState>();

    return SafeArea(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(
              height: 0.1 * screenHeight,
            ),
            TextFormField(
              controller: emailController,
              validator: ((value) {
                if (value != null && !EmailValidator.validate(value)) {
                  return 'Enter Valid Email';
                } else {
                  return null;
                }
              }),
              decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: passwordController,
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return 'Enter Password';
                } else if (value != null && value.length < 6) {
                  return 'Enter min 6 Characters';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton.icon(
              onPressed: () {
                formKey.currentState!.validate();
                SignIn();
              },
              icon: const Icon(
                Icons.lock,
                color: Colors.white,
              ),
              label: const Text(
                'Sign In',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: ((context) => const ForgotPasswordPage()),),);
              },
              child: const Text(
                'Forgot Password',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'No Account',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                TextButton(
                  onPressed: widget.onClickSignUP,
                  child: const Text(
                    'SignUp',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future SignIn() async {
    showDialog(
      context: context,
      builder: ((context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuth catch (e) {
      print(e);
      Utills.showSnackBar(e.toString());
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
