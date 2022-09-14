
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehtooa/app/model/models.dart' as model;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ehtooa/translations/locale_keys.g.dart';
import 'package:flutter/services.dart';
import '../../../translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';



class FirebaseFun{
  static var rest;
   static signup( {required String email,required String password})  async {
    final result=await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,///"temp@gmail.com",
      password: password,///"123456"
    ).then((onValueSignup))
        .catchError(onError);
    return result;
  }
   static createUser( {required model.User user}) async {
     final result= await FirebaseFirestore.instance.collection(user.typeUser).add(
       user.toJson()
     ).then((value){
       user.id=value.id;
         //print(true);
        // print(value.id);
         return {
           'status':true,
           'message':'Account successfully created',
           'body': {
             'id':value.id
           }
      };
     }).catchError(onError);
     if(result['status'] == true){
       final result2=await updateUser(user: user);
       if(result2['status'] == true){
         return{
         'status':true,
         'message':'Account successfully created',
         'body': user.toJson()
         };
       }else{
         return{
           'status':false,
           'message':"Account Unsuccessfully created"
         };
       }
     }else{
       return result;
     }

   }
   static updateUser( {required model.User user}) async {
      final result =await FirebaseFirestore.instance.collection(user.typeUser).doc(user.id).update(
         user.toJson()
     ).then(onValueUpdateUser)
         .catchError(onError);
      if(result['status']){
        print(true);
       // print(user.id);
        print("id : ${user.id}");
        return {
          'status':true,
          'message':'ok',
          'body': user.toJson()
        };
      }
      return result;
   }
  static login( {required String email,required String password})  async {
    final result=await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,///"temp@gmail.com",
      password: password,///"123456"
    ).then((onValuelogin))
        .catchError(onError);
    return result;
  }
  static fetchUser( {required String uid,required String typeUser})  async {
    final result=await FirebaseFirestore.instance.collection(typeUser)
        .where('uid',isEqualTo: uid)
        .get()
        .then((onValueFetchUser))
        .catchError(onError);
    return result;
  }

   static Future<Map<String,dynamic>>  onError(error) async {
    print(false);
    print(error);
    return {
      'status':false,
      'message':error,
      //'body':""
    };
  }

  static Future<Map<String,dynamic>> onValueSignup(value) async{
    print(true);
    print("uid : ${value.user?.uid}");
    return {
      'status':true,
      'message':'Account successfully created',
      'body':{
        'uid':value.user?.uid
      }
    };
  }
  static Future<Map<String,dynamic>> onValueUpdateUser(value) async{
    return {
      'status':true,
      'message':'Account successfully created',
    //  'body': user.toJson()
    };
  }
  static Future<Map<String,dynamic>> onValuelogin(value) async{
    //print(true);
   // print(value.user.uid);
    return {
      'status':true,
      'message':'Account successfully logged',
      'body':{
        'uid':value.user.uid}
    };
  }
  static Future<Map<String,dynamic>> onValueFetchUser(value) async{
    print(true);
    print("user : ${(value.docs.length>0)?model.User.fromJson(value.docs[0]).toJson():null}");
    return {
      'status':true,
      'message':'Account successfully logged',
      'body':(value.docs.length>0)?model.User.fromJson(value.docs[0]).toJson():null
    };
  }

  static String findTextToast(String text){
     if(text.contains("Password should be at least 6 characters")){
       return tr(LocaleKeys.toast_short_password);
     }else if(text.contains("The email address is already in use by another account")){
       return tr(LocaleKeys.toast_email_already_use);
     }
     else if(text.contains("Account Unsuccessfully created")){
       return tr(LocaleKeys.toast_Unsuccessfully_created);
     }
     else if(text.contains("Account successfully created")){
       return tr(LocaleKeys.toast_successfully_created);
     }
     else if(text.contains("The password is invalid or the user does not have a password")){
       return tr(LocaleKeys.toast_password_invalid);
     }
     else if(text.contains("There is no user record corresponding to this identifier")){
       return tr(LocaleKeys.toast_email_invalid);
     }
     else if(text.contains("Account successfully logged")){
       return tr(LocaleKeys.toast_successfully_logged);
     }
     else if(text.contains("A network error")){
       return tr(LocaleKeys.toast_network_error);
     }
     else if(text.contains("An internal error has occurred")){
       return tr(LocaleKeys.toast_network_error);
     }else if(text.contains("Account successfully logged")){
       return tr(LocaleKeys.toast);
     }else if(text.contains("Account successfully logged")){
       return tr(LocaleKeys.toast);
     }


     return text;
  }
}