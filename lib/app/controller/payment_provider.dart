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
import 'package:url_launcher/url_launcher.dart';
import '../model/models.dart' as models;
import '../model/models.dart';
import '../model/utils/const.dart';
import '../view/resources/consts_manager.dart';
import 'package:easy_localization/easy_localization.dart';
class PaymentProvider with ChangeNotifier{
  final formKey = GlobalKey<FormState>();
  final cardNumber = TextEditingController();
  final dateCard = TextEditingController(text: "${ DateFormat.yM().format(DateTime.now())
  }");
  final cvv = TextEditingController();
  final name = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String idGroup="";
  var setStat3;
  payUser(context,Group group) async {
    var result =await FirebaseFun.updateGroup(group: group, id: idGroup,updateGroupType: models.UpdateGroupType.PaySessions);
    print(result);
    Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
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