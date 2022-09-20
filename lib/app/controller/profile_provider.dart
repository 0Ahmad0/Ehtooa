

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:ehtooa/app/controller/utils/firebase.dart';
import 'package:ehtooa/app/model/models.dart';
import 'package:ehtooa/app/model/utils/local/storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';

import '../model/utils/const.dart';

class ProfileProvider with ChangeNotifier{
   var name = TextEditingController(text: "أحمد الحريري");
  var email = TextEditingController(text: "Ahmad2001@gmail.com");
  bool nameIgnor = true;
  bool emailIgnor = true;
  User user= User(id: "id",uid: "uid", name: "name", email: "email", phoneNumber: "phoneNumber", password: "password",photoUrl: "photoUrl",typeUser: "typeUser",listUsedQuizzes: [false,false,false,false]);
  PaySession paySession=PaySession(idUser: "", listSessionPay: [DateTime.now(),DateTime.now(),DateTime.now(),DateTime.now()]);
  updateUser({ required User user}){

    this.user=user;
     name = TextEditingController(text: user.name);
     email = TextEditingController(text: user.email);
     notifyListeners();
  }
  fetchPaySession(context) async {
    var result =await FirebaseFun.fetchPaySession(idUser: user.id);
    print(result);
    (!result['status'])?Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString())):"";
    return result;
  }
   editUser(context) async {
     User tempUser= User.fromJson(user.toJson());
     tempUser.email =email.text;
     tempUser.name=name.text;
     var result =await FirebaseFun.updateUser(user: tempUser);
     if(result['status']){
       updateUser(user:User.fromJson(result['body']));
     }
     print(result);
     Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
     return result;
   }
   logout(context)async{
     var result =await FirebaseFun.logout();
     if(result['status']){
       user= User(id: "id",uid: "uid", name: "name", email: "email", phoneNumber: "phoneNumber", password: "password",photoUrl: "photoUrl",typeUser: "typeUser",listUsedQuizzes: [false,false,false,false]);
       AppStorage.depose();
     }
     print(result);
     Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
     return result;
   }
   Future uploadImage(context,XFile image) async {
     Const.LOADIG(context);
     var url=await FirebaseFun.uploadImage(image: image,folder: "profileImage");
     print('url $url');
     if(url==null)
       Const.TOAST( context,textToast:FirebaseFun.findTextToast("Please, upload the image"));
     else{
       user.photoUrl=url;
     }
     Navigator.of(context).pop();
   }
}