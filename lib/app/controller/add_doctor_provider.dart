import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehtooa/app/controller/utils/firebase.dart';
import 'package:ehtooa/app/model/utils/local/storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import '../model/models.dart' as models;
import '../model/models.dart';
import '../model/utils/const.dart';
import '../view/resources/consts_manager.dart';

class AddDoctorProvider with ChangeNotifier{
  final formKey = GlobalKey<FormState>();
  final emailDoctor = TextEditingController();
  final passWord = TextEditingController();
  final name = TextEditingController();
  final description = TextEditingController();

  models.User user= models.User(id: "id",uid: "uid", name: "name", email: "email", phoneNumber: "phoneNumber", password: "password",photoUrl: "photoUrl",typeUser: "typeUser",listUsedQuizzes: [false,false,false,false]);
   addDoctor(context) async{
   var result =await FirebaseFun.signup(email: emailDoctor.text, password: passWord.text);
   if(result['status']){
     user= models.User(id: "",uid:result['body']['uid'], name: name.text, email: emailDoctor.text, phoneNumber: "0000000000", password: passWord.text,photoUrl: AppConstants.photoProfileDoctor,typeUser: AppConstants.collectionDoctor,description: description.text,listUsedQuizzes: [false,false,false,false]);
     result = await FirebaseFun.createUser(user: user);
     if(result['status']){
       user= models.User.fromJson(result['body']);
        emailDoctor.clear();
        passWord.clear();
        name.clear();
        description.clear();

      // print(result);
     }else{
      // print(result);
     }
   }else{
     //print(result);
   }
   print(result);
   Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
   return result;
    /*if(result['status']){
    }else{
    }*/
   // user.uid=result['body']['uid'];
  }

  onError(error){
    print(false);
    print(error);
    return {
      'status':false,
      'message':error,
      //'body':""
    };
  }
}