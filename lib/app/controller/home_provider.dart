import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehtooa/app/controller/utils/firebase.dart';
import 'package:ehtooa/app/model/utils/local/storage.dart';
import 'package:ehtooa/translations/locale_keys.g.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../model/models.dart' as models;
import '../model/models.dart';
import '../model/utils/const.dart';
import '../view/resources/consts_manager.dart';
import '../view/screens/questions/questions_view.dart';

class HomeProvider with ChangeNotifier{
  models.Users doctors=models.Users(users: []);
  models.Groups groups=models.Groups(groups: []);
  models.Sessions sessions=models.Sessions(sessions: []);
  Map<String,dynamic> cacheUser=Map<String,dynamic>();
  List<InteractiveSessions> sessionsToUser=[];
  String idUser="";
  fetchDoctors(context) async {
    var result =await FirebaseFun.fetchDoctors();
    print(result);
    (!result['status'])?Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString())):"";
    return result;
  }
  fetchGroups(context) async {
    var result =await FirebaseFun.fetchGroups();
    print(result);
    (!result['status'])?Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString())):"";
    return result;
  }
  fetchSessionsToUser(context,{required List groups,required PaySession paySession}) async {
    List idGroups=[];
    for(models.Group group in groups){
      idGroups.add(group.id);
    }
    this.idUser=idUser;
    var result =await FirebaseFun.fetchSessionsToUser(idGroups: idGroups);
    print(result);
    if(result['status']){
      sessionsToUser=[];
      await processessionsToUser(context, paySession: paySession);
    }
    (!result['status'])?Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString())):"";
    return result;
  }

  fetchNameUser(context,{required String idUser}) async {
    if(cacheUser.containsKey(idUser)) return cacheUser[idUser];
    var result =await FirebaseFun.fetchUserId(id: idUser,typeUser: AppConstants.collectionPatient);
    if(!result['status']){
       result =await FirebaseFun.fetchUserId(id: idUser,typeUser: AppConstants.collectionDoctor);
      if(!result['status']){
         result =await FirebaseFun.fetchUserId(id: idUser,typeUser: AppConstants.collectionAdmin);
      }
    }
    cacheUser[idUser]=(result['status'])?models.User.fromJson(result['body']).name:"user";
    return cacheUser[idUser];
   /* print(result);
    (!result['status'])?Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString())):"";
    return result;*/
  }
  processessionsToUser(context, {required PaySession paySession}){
    for(models.Session session in sessions.sessions){
      int indexListPaySession=fetchIndexFromListPaySession(idGroup: session.idGroup);
      bool isSold=false;
      if(paySession.listCheckSessionPay[indexListPaySession]){
        if(FirebaseFun.compareDateWithDateNowToDay(dateTime: paySession.listSessionPay[indexListPaySession])<=30){
          isSold=true;
        }
      }
      sessionsToUser.add( InteractiveSessions(
          name: session.name,
          id_link:session.sessionUrl,
          doctorName: session.listDoctor[0],
          price: "${session.price}",
          isSold: isSold
      ));
    }
  }
 int fetchIndexFromListPaySession({required String idGroup}){
    switch(idGroup){
      case "V59ILq22VmKnzXgKvxSV":
        return 0;
      case "z36yvFsn9zaAXj2uEXzL":
        return 1;
      case  "pmB1yVQEZgKYWhZZBm0f":
        return 2;
    }
    return 3;
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