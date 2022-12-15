
import 'package:flutter/material.dart';

  

class Utills{

static final messengerKey = GlobalKey<ScaffoldMessengerState>();

static showSnackBar(String? text){
  if(text == null){
    return;
  }

  final snackBar = SnackBar(content: Text(text),backgroundColor: Colors.red,);

  messengerKey.currentState!.showSnackBar(snackBar);


}

}