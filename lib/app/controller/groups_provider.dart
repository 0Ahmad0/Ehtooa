import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehtooa/app/controller/utils/firebase.dart';
import 'package:ehtooa/app/model/utils/local/storage.dart';
import 'package:ehtooa/app/view/resources/values_manager.dart';
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

class GroupsProvider with ChangeNotifier{
  models.Groups groups=models.Groups(groups: []);
  String idUser="";

  fetchGroupsToUserOrAdmin(context,{required String idUser,required String typeUser}) async {
    if(typeUser.contains(AppConstants.collectionAdmin)){
      return await fetchGroupsToAdmin(context ,idUser: idUser);
    }else if(typeUser.contains(AppConstants.collectionPatient)){
      return await fetchGroupsToUser(context ,idUser: idUser);
    }else
      return await fetchGroupsToUser(context ,idUser: idUser);
  }
  fetchGroupsToUser(context,{required String idUser}) async {
    this.idUser=idUser;
    var result =await FirebaseFun.fetchGroupsToUser(idUser: idUser);
    print(result);
    (!result['status'])?Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString())):"";
    return result;
  }
  fetchGroupsToAdmin(context,{required String idUser}) async {
    this.idUser=idUser;
    var result =await FirebaseFun.fetchGroupsToAdmin(idUser: idUser);
    print(result);
    (!result['status'])?Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString())):"";
    return result;
  }
  getTextMessageType(models.Message message){
    switch(message.typeMessage){
      case "text":
        return Text("${message.textMessage}");
      case "image":
        return Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
        Text("photo"),
            SizedBox(width: AppSize.s4,),
            Icon(Icons.image)
        ],);
      case "video":
       return Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("video"),
            SizedBox(width: AppSize.s4,),
            Icon(Icons.video_collection)
          ],);
        break;
      case "audio":
        return Row(
         // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("voice"),
            SizedBox(width: AppSize.s4,),
            Icon(Icons.keyboard_voice_outlined)
          ],);
      case "file":
        return Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("file"),
            SizedBox(width: AppSize.s4,),
            Icon(Icons.attach_file)
          ],);
    }
    return
        Text("${message.textMessage}");
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