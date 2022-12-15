import 'dart:ui';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todo/Screens/Utills.dart';
import 'package:firebase_todo/main.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

final emailController = TextEditingController();

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ScreenHeight = MediaQuery.of(context).size.height;
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Reset Password',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Column(children: [
          const SizedBox(
            height: 12,
          ),
          const Text(
            '''Recieve an email to
reset your Password''',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 0.05 * ScreenHeight,
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
            height: 10,
          ),
          ElevatedButton.icon(
            onPressed: () {
              formKey.currentState!.validate();
            },
            icon: const Icon(Icons.email_outlined),
            label: const Text(
              'Reset Password',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Future verifyEmail() async {
    showDialog(
      context: context,
      builder: ((context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text);
      Utills.showSnackBar('Password Reset Email Sent');
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuth catch (e) {
      Utills.showSnackBar(
        e.toString(),
      );
      Navigator.of(context).pop();
    }
  }
}
