import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehtooa/app/controller/utils/firebase.dart';
import 'package:ehtooa/app/controller/utils/test.dart';
import 'package:flutter/cupertino.dart';

import '../../model/models.dart' as models;
import '../../model/models.dart';
import '../../model/utils/const.dart';
import '../../view/resources/consts_manager.dart';

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
   var result =await FirebaseFun.fetchGroup(id: "taoId1xj5dSDNEoaYlFd");
   print(result);
   result['status']??Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
  /* group =models.Group.fromJson(result['body']);
   group.nameAr="اسم5";
   result =await FirebaseFun.updateGroup(group:group,id: "IbflFmPwFv1rETwfbVRK");*/
   return result;
 }
 fetchChat(context) async{
   var result =await FirebaseFun.fetchChat(id: "taoId1xj5dSDNEoaYlFd");
   print(result);
   result['status']??Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
   /*group =models.Group.fromJson(result['body']);
   group.nameAr="اسم5";
   result =await FirebaseFun.updateGroup(group:group,id: "IbflFmPwFv1rETwfbVRK");*/
   return result;
 }
 addUserToGroup(context) async{
   final resultGroup =await fetchGroup(context);
   group=models.Group.fromJson(resultGroup['body']);
   var result;
   if(!group.listUsers.contains("Tytxd8ae9TRz1wF70iMC")){group.listUsers.add("Tytxd8ae9TRz1wF70iMC");
    result=await FirebaseFun
       .updateGroup(
     id: "taoId1xj5dSDNEoaYlFd",
     group: group,
     updateGroupType: models.UpdateGroupType.add_user
   );}
   result=await FirebaseFun.onError("this user already found");
   print(result);
   Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
   return result;
 }
 
 addMessage(context) async{
   var result =await FirebaseFun
            .addMessage(id: "taoId1xj5dSDNEoaYlFd",
              message: models.Message(
                  replayId: ""
                  ,deleteUserMessage: []
                  ,textMessage: "textMessage"
                  , typeMessage: models.ChatMessageType.text.name
                  , senderId: "Tytxd8ae9TRz1wF70iMC"
                  , sendingTime: DateTime.now()));
   print(result);
   result['status']??Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
   /*group =models.Group.fromJson(result['body']);
   group.nameAr="اسم5";
   result =await FirebaseFun.updateGroup(group:group,id: "IbflFmPwFv1rETwfbVRK");*/
   return result;
 }
 deleteMessage(context) async{
   var result =await FirebaseFun
       .deleteMessage(
       idGroup: "taoId1xj5dSDNEoaYlFd",
       idMessage: "tYf25KbhnHaL79uof0UD"
   );
   print(result);
   result['status']??Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
   return result;
 }
 deleteUserMessage(context) async{
   models.Message
        message=models.Message(textMessage: "textMessage",
       replayId: "",
       typeMessage: "typeMessage",
       senderId: "pmB1yVQEZgKYWhZZBm0f",
       deleteUserMessage: ["pmB1yVQEZgKYWhZZBm0f"],
       id: "p6Sv2ggXIZEPwF5Lpr2i",
       sendingTime: DateTime.now());
   var result =await FirebaseFun
       .updateMessage(
       id: "taoId1xj5dSDNEoaYlFd",
     message: message,
   );
   print(result);
   result['status']??Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
   return result;
 }
 replayMessage(context) async{
   models.Message
   message=models.Message(textMessage: "textMessage",
       replayId: "jQAc3thjiTNsnajYzikG",
       typeMessage: "typeMessage",
       senderId: "pmB1yVQEZgKYWhZZBm0f",
       deleteUserMessage: ["pmB1yVQEZgKYWhZZBm0f"],
       id: "p6Sv2ggXIZEPwF5Lpr2i",
       sendingTime: DateTime.now());
   var result =await FirebaseFun
       .updateMessage(
     id: "taoId1xj5dSDNEoaYlFd",
     message: message,
   );
   print(result);
   result['status']??Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
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
