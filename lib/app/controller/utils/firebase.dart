
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehtooa/app/model/models.dart' as model;
import 'package:ehtooa/app/view/resources/consts_manager.dart';
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
          'message':'User successfully update',
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
  static logout()  async {
    final result=await FirebaseAuth.instance.signOut()
        .then((onValuelogout))
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
  static createGroup( {required model.Group group}) async {
    final result= await FirebaseFirestore.instance.collection(AppConstants.collectionGroup).add(
        group.toJsonFire()
    ).then((value){
      group.chat.id=value.id;
      //print(true);
      // print(value.id);
      return {
        'status':true,
        'message':'Group successfully created',
        'body': {
          'id':value.id
        }
      };
    }).catchError(onError);
    if(result['status'] == true){
      final result2=await createChat(chat: group.chat);
      if(result2['status'] == true){
        return{
          'status':true,
          'message':'Group successfully created',
          'body': group.toJson()
        };
      }else{
        return{
          'status':false,
          'message':"Group Unsuccessfully created"
        };
      }
    }else{
      return result;
    }

  }
  static createChat( {required model.Chat chat}) async {
    final result =await FirebaseFirestore.instance
        .collection(AppConstants.collectionGroup)
        .doc(chat.id)
        .collection(AppConstants.collectionChat)
        .add(
        model.Message(
            replayId: "",
            textMessage: "",
            deleteUserMessage: [],
            typeMessage: model.ChatMessageType.text.name,
            senderId: "",
            sendingTime:DateTime.now()).toJson(),
    ).then(onValueCreateChat)
        .catchError(onError);
    if(result['status']){
      print(true);
      // print(user.id);
      print("id : ${chat.id}");
      return {
        'status':true,
        'message':'Chat successfully created',
        'body': chat.toJson()
      };
    }
    return result;
  }
  static fetchGroup( {required String id})  async {
    final result=await FirebaseFirestore.instance.collection(AppConstants.collectionGroup)
        .doc(id)
        .get()
        .then((onValueFetchGroup))
        .catchError(onError);
    return result;
  }
  static fetchGroupsToUser( {required String idUser})  async {
    final result=await FirebaseFirestore.instance.collection(AppConstants.collectionGroup)
        .where('listUsers',arrayContains: idUser)
        .get()
        .then((onValueFetchGroupToUser))
        .catchError(onError);
    return result;
  }
  static updateGroup( {required model.Group group,required String id,model.UpdateGroupType updateGroupType=model.UpdateGroupType.update}) async {
    var result =await FirebaseFirestore.instance
        .collection(AppConstants.collectionGroup)
        .doc(id).update(
        group.toJsonFire()
    ).then(onValueUpdateGroup)
        .catchError(onError);
    result['status']?result['message']="group successfully ${updateGroupType.name}":"";
    return result;
  }
  static fetchChat( {required String id})  async {
    final result=await FirebaseFirestore.instance.collection(AppConstants.collectionGroup)
        .doc(id)
        .collection(AppConstants.collectionChat)
        .orderBy("sendingTime")
        .get()
        .then((onValueFetchChat))
        .catchError(onError);
    return result;
  }
  static addMessage( {required model.Message message,required String id}) async {
    final result =await FirebaseFirestore.instance
        .collection(AppConstants.collectionGroup)
        .doc(id)
        .collection(AppConstants.collectionChat).add(
        message.toJson()
    ).then(onValueAddMessage)
        .catchError(onError);
    return result;
  }
  static updateMessage( {required model.Message message,required String id}) async {
    final result =await FirebaseFirestore.instance
        .collection(AppConstants.collectionGroup)
        .doc(id)
        .collection(AppConstants.collectionChat)
        .doc(message.id)
        .update(
        message.toJson()
    ).then(onValueUpdateMessage)
        .catchError(onError);
    return result;
  }
  static deleteMessage( {required String idGroup,required String idMessage}) async {
    final result =await FirebaseFirestore.instance
        .collection(AppConstants.collectionGroup)
        .doc(idGroup)
        .collection(AppConstants.collectionChat)
        .doc(idMessage).delete().then(onValueDeleteMessage)
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
  static Future<Map<String,dynamic>> onValuelogout(value) async{
     print(true);
     print("logout");
    return {
      'status':true,
      'message':'Account successfully logout',
      'body':{}
    };
  }
  static Future<Map<String,dynamic>> onValueFetchUser(value) async{
    print(true);
    print(await value.docs[0]['uid']);
    print("user : ${(value.docs.length>0)?model.User.fromJson(value.docs[0]).toJson():null}");
    return {
      'status':true,
      'message':'Account successfully logged',
      'body':(value.docs.length>0)?model.User.fromJson(value.docs[0]).toJson():null
    };
  }
  static Future<Map<String,dynamic>> onValueCreateChat(value) async{
    return {
      'status':true,
      'message':'Chat successfully created',
      //  'body': user.toJson()
    };
  }
  static Future<Map<String,dynamic>> onValueFetchGroup(value) async{
    print(true);
    //print(await value.docs[0]);
    print("Group : ${(value.data()!=null)?model.Group.fromJsonFire(value.data()).toJson():null}");
    return {
      'status':true,
      'message':'group successfully fetch',
      'body':(value.data()!=null)?model.Group.fromJsonFire(value.data()).toJson():null
    };
  }
  static Future<Map<String,dynamic>> onValueFetchGroupToUser(value) async{
    print(true);
    //print(await value.docs[0]);
    print("Groups count : ${value.docs.length}");

    return {
      'status':true,
      'message':'groups successfully fetch',
      'body':value.docs
    };
  }
  static Future<Map<String,dynamic>> onValueUpdateGroup(value) async{
    return {
      'status':true,
      'message':'group successfully update',
      //  'body': user.toJson()
    };
  }
  static Future<Map<String,dynamic>> onValueFetchChat(value) async{
    print(true);
    //print(await value.docs[0]);
    print("Cont Messages : ${value.docs.length}");
    model.Chat chat = model.Chat.fromJson({
      'id':"",
      'messages':value.docs,
    });
    return {
      'status':true,
      'message':'Chat successfully fetch',
      'body':chat.toJson(),
    };
  }
  static Future<Map<String,dynamic>> onValueAddMessage(value) async{
    return {
      'status':true,
      'message':'Message successfully add',
      //  'body': user.toJson()
    };
  }
  static Future<Map<String,dynamic>> onValueUpdateMessage(value) async{
    return {
      'status':true,
      'message':'Message successfully update',
      //  'body': user.toJson()
    };
  }
  static Future<Map<String,dynamic>> onValueDeleteMessage(value) async{
    return {
      'status':true,
      'message':'Message successfully delete',
      //  'body': user.toJson()
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
     }else if(text.contains("field does not exist within the DocumentSnapshotPlatform")){
       return tr(LocaleKeys.toast_Bad_data_fetch);
     }else if(text.contains("Account successfully logged")){
       return tr(LocaleKeys.toast);
     }


     return text;
  }
}