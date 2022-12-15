import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

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
          ],
        ),
      ),
    );
  }

  Future SignIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
  }
}
