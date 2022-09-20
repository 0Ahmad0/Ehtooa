import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehtooa/app/controller/home_provider.dart';
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

class NotificationProvider with ChangeNotifier{
  models.Sessions sessions=models.Sessions(sessions: []);
  List<InteractiveSessions> sessionsToUser=[];
  String idUser="";
  fetchSessionsToUser(context,{required List groups,required PaySession paySession,required idUser}) async {
    List idGroups=[];
    for(models.Group group in groups){
      idGroups.add(group.id);
    }
    this.idUser=idUser;
    var result =await FirebaseFun.fetchSessionsToUser(idGroups: idGroups);
    print(result);
    if(result['status']){
      sessions=models.Sessions.fromJson(result['body']);
      sessionsToUser=[];
      await processessionsToUser(context,groupsUser:  groups, paySession: paySession);
    }
    (!result['status'])?Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString())):"";
    return result;
  }
  
  processessionsToUser(context, {required PaySession paySession,required List groupsUser}){
    for(models.Session session in sessions.sessions){
      int indexListPaySession=fetchIndexFromListPaySession(idGroup: session.idGroup);
      bool isSold=false;
      ///if(paySession.listCheckSessionPay[indexListPaySession]){
        if(HomeProvider().checkUserPay(groupsUser, session.idGroup, idUser)){
          isSold=true;
        }
     /// }
      if(session.date.compareTo(DateTime.now())<=0){
        sessionsToUser.add( InteractiveSessions(
          idGroup: session.idGroup,
            name: session.name,
            id_link:session.sessionUrl,
            doctorName: session.listDoctor[0],
            price: "${session.price}",
            isSold: isSold
        ));
      }
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