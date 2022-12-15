import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todo/Screens/Utills.dart';
import 'package:firebase_todo/main.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  final Function() onClickSignIn;
  const SignUpPage({super.key, required this.onClickSignIn});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

final emailController = TextEditingController();
final passwordController = TextEditingController();

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    @override
    void dispose() {
      // TODO: implement dispose
      emailController.dispose();
      passwordController.dispose();
    }

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
                signUp();
              },
              icon: const Icon(
                Icons.arrow_right,
                size: 35,
                color: Colors.white,
              ),
              label: const Text(
                'Sign Up',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an Account? ',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                TextButton(
                  onPressed: widget.onClickSignIn,
                  child: const Text(
                    'LogIn',
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

  Future signUp() async {
    showDialog(
      context: context,
      builder: ((context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      Utills.showSnackBar(e.toString());
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
