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
  String search="";
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
      sessions=models.Sessions.fromJson(result['body']);
      if(search!=""){
        sessions.sessions =await searchListSession(context, search: search, sessions: sessions.sessions);
      }
      sessionsToUser=[];
      await processessionsToUser(context, paySession: paySession);
    }
    (!result['status'])?Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString())):"";
    return result;
  }

  fetchNameUser(context,{required String idUser}) async{
  //  print("id ${idUser} user ${cacheUser[idUser]}");
    if(cacheUser.containsKey(idUser)) return cacheUser[idUser];
    var result =await FirebaseFun.fetchUserId(id: idUser,typeUser: AppConstants.collectionPatient);
    if(result['status']&&result['body']==null){
       result =await FirebaseFun.fetchUserId(id: idUser,typeUser: AppConstants.collectionDoctor);
       print("result ${result}");
       print("id ${idUser} user ${cacheUser[idUser]}");
      if(result['status']&&result['body']==null){
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
  addUserToGroup(context,{required String idUser,required String idGroup}) async {
    if(!groups.groups[fetchIndexGroup(idGroup: idGroup)].listUsers.contains(idUser)){
      groups.groups[fetchIndexGroup(idGroup: idGroup)].listUsers.add(idUser);
    }
    var result =await FirebaseFun.updateGroup(group: groups.groups[fetchIndexGroup(idGroup: idGroup)], id: idGroup,updateGroupType:models.UpdateGroupType.add_user);
    print(result);
    (!result['status'])?Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString())):"";
    return result;
  }


 int fetchIndexFromListPaySession({required String idGroup}){
    switch(idGroup){
      case "YMfMrXosR8VF1xmbw1uU":
        return 3;
      case "eGcR8N9qBycAH6Y9xupV":
        return 1;
      case  "eK8OgCTMRTeIx3OWZz4Z":
        return 0;
    }
    return 2;
 }

  int fetchIndexGroup({required String idGroup}){
    switch(idGroup){
      case "YMfMrXosR8VF1xmbw1uU":
        return 0;
      case "eGcR8N9qBycAH6Y9xupV":
        return 1;
      case  "eK8OgCTMRTeIx3OWZz4Z":
        return 2;
    }
    return 3;
  }
  int fetchIndexGroupFromIndexList({required int index}){
    switch(index){
      case 3:
        return 0;
      case 1:
        return 1;
      case  0:
        return 2;
    }
    return 3;
  }

Future<List<models.Session>> searchListSession(context,
    {required String search, required List<models.Session> sessions}) async {
    List<models.Session> tempSessions=[];
    for(models.Session session in sessions){
      String tempNameDoctor=await fetchNameUser(context, idUser: session.listDoctor[0]);
      if(tempNameDoctor.contains(search)){
        tempSessions.add(session);
      }
    }
    return tempSessions;
}
  List<models.User> searchListDoctors(context,
      {required String search, required List<models.User> users})  {
    List<models.User> tempUsers=[];
    for(models.User user in users){
      if(user.name.contains(search)){
        tempUsers.add(user);
      }
    }
    return tempUsers;
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