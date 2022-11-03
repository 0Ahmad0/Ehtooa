

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:ehtooa/app/controller/utils/firebase.dart';
import 'package:ehtooa/app/model/models.dart' as model;
import 'package:ehtooa/app/model/models.dart';
import 'package:ehtooa/app/model/utils/local/storage.dart';
import 'package:ehtooa/app/view/emailUserVerified/email_user_verified_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import '../model/utils/const.dart';

class ProfileProvider with ChangeNotifier{
  final serial_number = TextEditingController(text: "000-252-1456-6222");
   var name = TextEditingController(text: "أحمد الحريري");
  var email = TextEditingController(text: "Ahmad2001@gmail.com");
  bool nameIgnor = true;
  bool emailIgnor = true;
  model.User user= model.User(id: "id",uid: "uid", name: "name", email: "email", phoneNumber: "phoneNumber", password: "password",photoUrl: "photoUrl",typeUser: "typeUser",listUsedQuizzes: [false,false,false,false]);
  PaySession paySession=PaySession(idUser: "", listSessionPay: [DateTime.now(),DateTime.now(),DateTime.now(),DateTime.now()]);
  updateUser({ required model.User user}){

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
     model.User tempUser= model.User.fromJson(user.toJson());
     tempUser.email =email.text;
     tempUser.name=name.text;
     tempUser.serialNumber=name.text;
     var result =await FirebaseFun.updateUser(user: tempUser);
     if(result['status']){
       updateUser(user:model.User.fromJson(result['body']));
     }
     print(result);
     Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
     return result;
   }
   logout(context)async{
     var result =await FirebaseFun.logout();
     if(result['status']){
       user= model.User(id: "id",uid: "uid", name: "name", email: "email", phoneNumber: "phoneNumber", password: "password",photoUrl: "photoUrl",typeUser: "typeUser",listUsedQuizzes: [false,false,false,false]);
       AppStorage.depose();
     }
     print(result);
     Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
     return result;
   }
  ///To check is User is logged in
  Future<bool> isEmailUserVerified()  async {
    final user=  await FirebaseAuth.instance.currentUser;
    //print('emailVerified : ${user?.emailVerified}');
    if (user == null) {
      return false;
    }
    return user.emailVerified;
  }
  Future<bool> emailUserVerified(BuildContext context) async {
    if(!await isEmailUserVerified()){
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (ctx) => EmailUserVerifiedView()));
      return false;
    }
    return true;
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