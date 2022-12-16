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



class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

final emailController = TextEditingController();
   static final  formKey2 = GlobalKey<FormState>();



//  @override
//   void dispose() {
//     // TODO: implement dispose
//     emailController.dispose();
//     super.dispose();
//   }
 

  @override
  Widget build(BuildContext context) {
    final ScreenHeight = MediaQuery.of(context).size.height;
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
        child: 
     //   Form(

       //   key: formKey,
       //   child: 
          Form(
            key: formKey2,
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
                  } else if(value != null && value.isEmpty){
                    return 'Enter Email';
                  }else{
                    return null;
                  }
                }),
                decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                 onPressed:
                  // verifyEmail,
                () {
                  formKey2.currentState!.validate();
                  verifyEmail();
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
        ),
      );
  //  );
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
          .sendPasswordResetEmail(email: emailController.text.trim());
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
