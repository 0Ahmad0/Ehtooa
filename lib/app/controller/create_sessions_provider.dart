import 'package:ehtooa/app/controller/utils/firebase.dart';
import 'package:ehtooa/app/controller/utils/test.dart';
import 'package:ehtooa/app/model/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/models.dart' as models;
import '../model/utils/const.dart';

class CreateSessionsProvider with ChangeNotifier{
  models.Session session = Session(idAmin: "", name: "name", sessionUrl: "", idGroup: "", price: 0, listDoctor: [], listUserPay: [], date: DateTime.now());
 final formKey = GlobalKey<FormState>();
 final link = TextEditingController();
 final sessionName = TextEditingController();
 final sessionDate = TextEditingController();
 final sessionTime = TextEditingController();
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
 final sessionGroup = TextEditingController();
 final sessionDoctor = TextEditingController();
 final price = TextEditingController();
  createSession(context,{required String idAmin,required String idDoctor,required String idGroup}) async{
    session=Session(idAmin: idAmin,
        name: sessionName.text,
        sessionUrl: link.text,
        idGroup: idGroup,
        price: int.parse( price.text),
        listDoctor: [idDoctor],
        listUserPay: [],
        date: DateTime(date.year, date.month, date.day, time.hour, time.minute));
   // return session.toJson();
    var result =await FirebaseFun.createSession(session: session);
    print(result);
    Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }
  clean(){
     link.clear();
     sessionName.clear();
     sessionDate.clear();
     sessionTime.clear();
     sessionGroup.clear();
     sessionDoctor.clear();
     price.clear();
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
