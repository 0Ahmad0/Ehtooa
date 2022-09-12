import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import '../model/models.dart' as model;

class SignupProvider with ChangeNotifier{
  final name = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final keyForm = GlobalKey<FormState>();
  model.User user= model.User(id: "id", name: "name", email: "email", phoneNumber: "phoneNumber", password: "password",photoUrl: "photoUrl",typeUser: "typeUser");
  void signup(){
    temp();
  }
  void temp(){
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
          email: "temp@gmail.com",///email.text,
          password: "12345678",///password.text
        ).then((value){
          print(true);
        });
  }
}