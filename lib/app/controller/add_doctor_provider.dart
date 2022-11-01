import 'package:ehtooa/app/controller/utils/firebase.dart';
import 'package:flutter/cupertino.dart';
import '../model/models.dart' as models;
import '../model/utils/const.dart';
import '../view/resources/consts_manager.dart';

class AddDoctorProvider with ChangeNotifier{
  final formKey = GlobalKey<FormState>();
  final emailDoctor = TextEditingController();
  final passWord = TextEditingController();
  final name = TextEditingController();
  final description = TextEditingController();
  final serialNumber = TextEditingController();
  final phoneNumber = TextEditingController();
  var setState2;
  models.User user= models.User(id: "id",uid: "uid", name: "name", email: "email", phoneNumber: "phoneNumber", password: "password",photoUrl: "photoUrl",typeUser: "typeUser",listUsedQuizzes: [false,false,false,false]);
   addDoctor(context) async{
   var result =await FirebaseFun.signup(email: emailDoctor.text, password: passWord.text);
   if(result['status']){
     user= models.User(id: "",uid:result['body']['uid'], name: name.text, email: emailDoctor.text, phoneNumber: phoneNumber.text, password: passWord.text,photoUrl: AppConstants.photoProfileDoctor,typeUser: AppConstants.collectionDoctor,description: description.text,listUsedQuizzes: [false,false,false,false],serialNumber: serialNumber.text);
     result = await FirebaseFun.createUser(user: user);
     if(result['status']){
       user= models.User.fromJson(result['body']);
        emailDoctor.clear();
        passWord.clear();
        name.clear();
        serialNumber.clear();
        description.clear();

      // print(result);
     }else{
      // print(result);
     }
   }else{
     //print(result);
   }
   print(result);
   Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
   return result;
    /*if(result['status']){
    }else{
    }*/
   // user.uid=result['body']['uid'];
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