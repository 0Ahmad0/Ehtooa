import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehtooa/app/controller/utils/firebase.dart';
import 'package:ehtooa/app/controller/utils/test.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../model/models.dart' as models;
import '../model/models.dart';
import '../model/utils/const.dart';
import '../view/resources/consts_manager.dart';

class ChatProvider with ChangeNotifier{
 late models.Group group=models.Group(idAmin: "", nameAr: "", nameEn: "", chat: models.Chat(id: "", messages: []), photoUrl: "", listUsers: [], listBlockUsers: [], date: DateTime.now());
 String? replayMessage;
 String replayIdMessage="";
 models.Message messageReplay=models.Message(textMessage: "", replayId: "", typeMessage: "", senderId: "", deleteUserMessage: [], sendingTime: DateTime.now());
 bool isReplay = false;
 static String idGroup="";

 changeReplayMessage({required String? replayMessage}){
   this.replayMessage=replayMessage;
   isReplay = replayMessage != null;
   notifyListeners();
 }
 changeReplayMessageId({required String? replayMessage,required String replayIdMessage}){
   this.replayIdMessage=replayIdMessage;
   this.replayMessage=replayMessage;
   isReplay = replayMessage != null;
   notifyListeners();
 }
 changeReplayMessageWithOut({required String? replayMessage}){
   this.replayMessage=replayMessage;
   isReplay = replayMessage != null;
 ///  notifyListeners();
 }
 getReplayMessage(){
   group.chat.messages.forEach((element) {
     if(element.id.contains(replayIdMessage)){
       messageReplay=element;
     }
   });
 }
 findReplayMessage({required String repIdMessage}){
   models.Message repMessage=models.Message(textMessage: "", replayId: "", typeMessage: "", senderId: "", deleteUserMessage: [], sendingTime: DateTime.now());

   group.chat.messages.forEach((element) {
     if(element.id.contains(repIdMessage)){
       repMessage=element;
     }
   });
   return repMessage;
 }

 fetchChat(context) async{
   var result =await FirebaseFun.fetchChat(id: "taoId1xj5dSDNEoaYlFd");
   print(result);
   result['status']??Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
   /*group =models.Group.fromJson(result['body']);
   group.nameAr="??????5";
   result =await FirebaseFun.updateGroup(group:group,id: "IbflFmPwFv1rETwfbVRK");*/
   return result;
 }
 fetchChatStream(context,{required String idGroup}) async{
   final result=await FirebaseFirestore.instance.collection(AppConstants.collectionGroup)
       .doc(idGroup)
       .collection(AppConstants.collectionChat)
       .orderBy("sendingTime")
       .snapshots();
   return result;
   /**
   var result =await FirebaseFun.fetchChat(id: "taoId1xj5dSDNEoaYlFd");
   print(result);
   result['status']??Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
   /*group =models.Group.fromJson(result['body']);
   group.nameAr="??????5";
   result =await FirebaseFun.updateGroup(group:group,id: "IbflFmPwFv1rETwfbVRK");*/
   return result;**/
 }
 addMessage(context,{required String idGroup,required models.Message message}) async{
  /* var result =await FirebaseFun
            .addMessage(id: "taoId1xj5dSDNEoaYlFd",
              message: models.Message(
                  replayId: ""
                  ,deleteUserMessage: []
                  ,textMessage: "textMessage1t"
                  , typeMessage: models.ChatMessageType.text.name
                  , senderId: "Tytxd8ae9TRz1wF70iMC"
                  , sendingTime: DateTime.now()));*/
   message.sendingTime=DateTime.now();
   var result =await FirebaseFun
       .addMessage(id: idGroup,
       message:message);
   print(result);
   result['status']??Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
   ///if(result['status']){
   ///  await _saveLocalFile(message.localUrl,result['body']['id']);
 ///  }
   /*group =models.Group.fromJson(result['body']);
   group.nameAr="??????5";
   result =await FirebaseFun.updateGroup(group:group,id: "IbflFmPwFv1rETwfbVRK");*/
   return result;
 }
 Future<File> _saveLocalFile(String localUrl,String id) async {
   final tempDir= await getTemporaryDirectory();
   final path = "${tempDir.path}/${id}";
   final file = File('$path');
   return file.writeAsString(localUrl);
 }
 deleteMessage(context, {required models.Message message,required String idUser}) async {
   if(message.senderId.contains(idUser)){
     return await deleteAllMessage(context,message: message);
   }else{
     return await deleteUserMessage(context,message: message,idUser: idUser);
   }
 }
 deleteAllMessage(context, {required models.Message message}) async{

   var result =await FirebaseFun.deleteMessage(idGroup: group.id,idMessage: message.id);
   print(result);
   result['status']??Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
   return result;
 }
 deleteUserMessage(context,{required models.Message message,required String idUser}) async{
  if(!message.deleteUserMessage.contains(idUser)){
    message.deleteUserMessage.add(idUser);
  }
   var result =await FirebaseFun.updateMessage(
       id: group.id,
     message: message,
   );
   print(result);
   result['status']??Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
   return result;
 }
 replayMessage1(context) async{
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
 findbasename(filePath){
   return basename(filePath);
 }
 getFileImageFromVideo({required File videoFile, required String id}) async {
   final uint8list = await VideoThumbnail.thumbnailData(
     video: videoFile.path,
     imageFormat: ImageFormat.JPEG,
     maxWidth: 128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
     quality: 25,
   );

   final tempDir = await getTemporaryDirectory();
   final file = await new File('${tempDir.path}/${id}.jpg').create();
   file.writeAsBytesSync(uint8list!);
   return file;

 }




 bool checkBlockUserInGroup({required String idUser}){
   if(group.listBlockUsers.contains(idUser))
     return true;
   return false;
 }
 changeBlockStateUser(context,{required String idUser}) async {
   if(checkBlockUserInGroup(idUser: idUser)) {
     return await unBlockUserInGroup(context, idUser: idUser);
   }else {
     return await blockUserInGroup(context, idUser: idUser);
   }
 }
 blockUserInGroup(context,{required String idUser}) async {
   Const.LOADIG(context);
     group.listBlockUsers.add(idUser);
   var result =await FirebaseFun.updateGroup(group: group, id: group.id,updateGroupType: models.UpdateGroupType.block_user);
   print(result);
   Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
   notifyListeners();
   Navigator.of(context).pop();
   return result;
 }
 unBlockUserInGroup(context,{required String idUser}) async {
   Const.LOADIG(context);
   group.listBlockUsers.remove(idUser);
   var result =await FirebaseFun.updateGroup(group: group, id: group.id,updateGroupType: models.UpdateGroupType.block_user);
   print(result);
   Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
   notifyListeners();
   Navigator.of(context).pop();
   return result;
 }
 deleteUserInGroup(context,{required String idUser}) async {
   Const.LOADIG(context);
   if(checkBlockUserInGroup(idUser: idUser)) {
     group.listBlockUsers.remove(idUser);
   }
   group.listUsers.remove(idUser);
   var result =await FirebaseFun.updateGroup(group: group, id: group.id,updateGroupType: models.UpdateGroupType.delete_user);
   print(result);
   Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
   notifyListeners();
   Navigator.of(context).pop();
   return result;
 }

 Future uploadFile({required String filePath,required String typePathStorage}) async {
   try {
     String path = basename(filePath);
     print(path);
     File file =File(filePath);

//FirebaseStorage storage = FirebaseStorage.instance.ref().child(path);
     Reference storage = FirebaseStorage.instance.ref().child("${typePathStorage}${path}");
     UploadTask storageUploadTask = storage.putFile(file);
     TaskSnapshot taskSnapshot = await storageUploadTask;
     //Const.LOADIG(context);
     String url = await taskSnapshot.ref.getDownloadURL();
     //Navigator.of(context).pop();
     print('url $url');
     return url;
   } catch (ex) {
     //Const.TOAST( context,textToast:FirebaseFun.findTextToast("Please, upload the image"));
   }
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
