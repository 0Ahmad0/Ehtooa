import 'package:ehtooa/app/controller/utils/firebase.dart';
import 'package:ehtooa/app/controller/utils/test.dart';
import 'package:flutter/cupertino.dart';

import '../model/models.dart' as models;
import '../model/models.dart';
import '../model/utils/const.dart';
import '../view/resources/consts_manager.dart';

class CreateEnvironmentProvider with ChangeNotifier{
 late models.Group group;
 createGroups(context) async{
   for(models.Group group in TestModels.groups){
     this.group=group;
     await createGroup(context);
   }
 }
  createGroup(context) async{
    var result =await FirebaseFun.createGroup(group: group);
    print(result);
    Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }
 fetchGroup(context) async{
   var result =await FirebaseFun.fetchGroup(id: "IbflFmPwFv1rETwfbVRK");
   print(result);
   result['status']??Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
   group =models.Group.fromJson(result['body']);
   group.nameAr="اسم5";
   result =await FirebaseFun.updateGroup(group:group,id: "IbflFmPwFv1rETwfbVRK");
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
