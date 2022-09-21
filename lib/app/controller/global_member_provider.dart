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
import 'chat_provider.dart';
import 'package:provider/provider.dart';
class GlobalMemberProvider with ChangeNotifier{
  models.Users users=models.Users(users: []);
  fetchUsers(context) async {
    var result =await FirebaseFun.fetchUsers();
    print(result);
    (!result['status'])?Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString())):"";
    return result;
  }
  bool checkAddUserToGroup(context,{required String idUser}){
    final chatProvider = Provider.of<ChatProvider>(context,listen: false);
    if(chatProvider.group.listUsers.contains(idUser))
      return true;
    return false;
  }

  addUserToGroup(context,{required String idUser}) async {
    final chatProvider = Provider.of<ChatProvider>(context,listen: false);
    Const.LOADIG(context);
    if(!checkAddUserToGroup(context,idUser: idUser)) {
      chatProvider.group.listUsers.add(idUser);
    }
    var result =await FirebaseFun.updateGroup(group: chatProvider.group, id: chatProvider.group.id,updateGroupType: models.UpdateGroupType.add_user);
    print(result);
    Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    notifyListeners();
    Navigator.of(context).pop();
    return result;
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