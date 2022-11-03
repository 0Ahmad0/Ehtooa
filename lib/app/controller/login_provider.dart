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
  models.User user= models.User(id: "id",uid: "uid", name: "name", email: "email", phoneNumber: "phoneNumber", password: "password",photoUrl: "photoUrl",typeUser: "typeUser",listUsedQuizzes: [false,false,false,false]);
   login(context) async{
   var resultUser =await FirebaseFun.login(email: email.text, password: password.text);
   var result;
   if(resultUser['status']){
      result = await fetchUser(uid: resultUser['body']['uid']);
     if(result['status']){
       await AppStorage.storageWrite(key: AppConstants.isLoginedKEY, value: true);
       Advance.isLogined = true;
       user= models.User.fromJson(result['body']);
       await AppStorage.storageWrite(key: AppConstants.idKEY, value: user.uid);
       await AppStorage.storageWrite(key: AppConstants.uidKEY, value: user.uid);
       await AppStorage.storageWrite(key: AppConstants.tokenKEY, value: "resultUser['token']");
       Advance.token = user.uid;
        email.clear();
        password.clear();
     }
      // print(result);
   }else{
     result=resultUser;
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
  loginUid(String uid) async{
      var result = await fetchUser(uid: uid);
      if(result['status']){
        await AppStorage.storageWrite(key: AppConstants.isLoginedKEY, value: true);
        Advance.isLogined = true;
        user= models.User.fromJson(result['body']);
        await AppStorage.storageWrite(key: AppConstants.idKEY, value: user.uid);
        Advance.token = user.uid;
        email.clear();
        password.clear();
      // print(result);
    }
    print(result);
    //Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
    /*if(result['status']){
    }else{
    }*/
    // user.uid=result['body']['uid'];
  }
  fetchUser({required String uid}) async {
    var result= await FirebaseFun.fetchUser(uid: uid, typeUser: AppConstants.collectionPatient);
    // print(result);
    if(result['status']&&result['body']==null){
      result = await FirebaseFun.fetchUser(uid: uid, typeUser: AppConstants.collectionDoctor);
      if(result['status']&&result['body']==null){

        result = await FirebaseFun.fetchUser(uid: uid, typeUser: AppConstants.collectionAdmin);
        if(result['status']&&result['body']==null){
          result={
            'status':false,
            'message':LocaleKeys.toast_account_invalid,
          };
        }
      }
    }
    return result;
  }

  sendPasswordResetEmail(context,{required String resetEmail}) async{
    var result =await FirebaseFun.sendPasswordResetEmail(email: resetEmail);
    print(result);
    Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }
  confirmPasswordReset(context,{required String newPassword,required String code}) async{
    var result =await FirebaseFun.confirmPasswordReset(newPassword: newPassword,code: code);
    print(result);
    Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }
  ///To check is User is logged in
  bool isEmailUserVerified()  {
     final user=  FirebaseAuth.instance.currentUser;
    if (user == null) {
      return false;
    }
    return user.emailVerified;
  }
  emailUserVerified() async {
     print('isEmailVerified  ${isEmailUserVerified()}');
     print('emdil  ${FirebaseAuth.instance.currentUser!.email}');
     await FirebaseAuth.instance.currentUser!.sendEmailVerification();
     print("code is send");
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