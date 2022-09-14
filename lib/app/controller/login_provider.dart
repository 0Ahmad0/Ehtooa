import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehtooa/app/controller/utils/firebase.dart';
import 'package:ehtooa/app/model/utils/local/storage.dart';
import 'package:ehtooa/translations/locale_keys.g.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import '../model/models.dart' as models;
import '../model/models.dart';
import '../model/utils/const.dart';
import '../view/resources/consts_manager.dart';

class LoginProvider with ChangeNotifier{
  final email = TextEditingController();
  final password = TextEditingController();
  final keyForm = GlobalKey<FormState>();
  models.User user= models.User(id: "id",uid: "uid", name: "name", email: "email", phoneNumber: "phoneNumber", password: "password",photoUrl: "photoUrl",typeUser: "typeUser");
   login(context) async{
   var resultUser =await FirebaseFun.login(email: email.text, password: password.text);
   var result;
   if(resultUser['status']){
      result = await FirebaseFun.fetchUser(uid: resultUser['body']['uid'], typeUser: AppConstants.collectionPatient);
     if(result['status']&&result['body']!=null){
       result = await FirebaseFun.fetchUser(uid: resultUser['body']['uid'], typeUser: AppConstants.collectionDoctor);
       if(result['status']&&result['body']==null){
         print(result);
         result = await FirebaseFun.fetchUser(uid: resultUser['body']['uid'], typeUser: AppConstants.collectionAdmin);
         if(result['status']&&result['body']==null){
           result={
             'status':false,
             'message':LocaleKeys.toast_account_invalid,
           };
         }
       }
     }
     if(result['status']){
       await AppStorage.storageWrite(key: AppConstants.isLoginedKEY, value: true);
       Advance.isLogined = true;
       user= models.User.fromJson(result['body']);
     }
      // print(result);
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