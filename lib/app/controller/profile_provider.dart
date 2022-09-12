import 'package:ehtooa/app/model/models.dart';
import 'package:flutter/cupertino.dart';

class ProfileProvider with ChangeNotifier{
  User user= User(id: "id", name: "name", email: "email", phoneNumber: "phoneNumber", password: "password",photoUrl: "photoUrl",typeUser: "typeUser");
}