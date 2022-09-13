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

class SignupProvider with ChangeNotifier{
  final name = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final keyForm = GlobalKey<FormState>();
  models.User user= models.User(id: "id",uid: "uid", name: "name", email: "email", phoneNumber: "phoneNumber", password: "password",photoUrl: "photoUrl",typeUser: "typeUser");
   signup(context) async{
   var result =await FirebaseFun.signup(email: email.text, password: password.text);
   if(result['status']){
     user= models.User(id: "",uid:result['body']['uid'], name: name.text, email: email.text, phoneNumber: phoneNumber.text, password: password.text,photoUrl: AppConstants.photoProfilePatient,typeUser: AppConstants.collectionPatient);
     result = await FirebaseFun.createUser(user: user);
     if(result['status']){

       await AppStorage.storageWrite(key: AppConstants.isLoginedKEY, value: true);
       Advance.isLogined = true;
       user= models.User.fromJson(result['body']);
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