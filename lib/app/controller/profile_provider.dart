import 'package:ehtooa/app/controller/utils/firebase.dart';
import 'package:ehtooa/app/model/models.dart';
import 'package:flutter/cupertino.dart';

import '../model/utils/const.dart';

class ProfileProvider with ChangeNotifier{
   var name = TextEditingController(text: "أحمد الحريري");
  var email = TextEditingController(text: "Ahmad2001@gmail.com");
  bool nameIgnor = true;
  bool emailIgnor = true;
  User user= User(id: "id",uid: "uid", name: "name", email: "email", phoneNumber: "phoneNumber", password: "password",photoUrl: "photoUrl",typeUser: "typeUser");
  updateUser({ required User user}){
    this.user=user;
     name = TextEditingController(text: user.name);
     email = TextEditingController(text: user.email);
     notifyListeners();
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
}