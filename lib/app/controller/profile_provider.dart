import 'package:ehtooa/app/model/models.dart';
import 'package:flutter/cupertino.dart';

class ProfileProvider with ChangeNotifier{
  User user= User(id: 0, name: "name", email: "email", phoneNumber: "phoneNumber", password: "password");
}