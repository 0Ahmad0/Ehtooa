import 'package:ehtooa/app/model/models.dart';
import 'package:ehtooa/app/view/resources/consts_manager.dart';

class TestModels{
  static Chat chat =Chat(id: "", date: DateTime.now(), messages: []);
  static List<Group> groups=[
    Group(idAmin: "V59ILq22VmKnzXgKvxSV", nameEn: "name1",nameAr: "اسم1", chat: chat, photoUrl: AppConstants.photoGroup, listUsers: [], listBlockUsers: [], date: DateTime.now()),
    Group(idAmin: "z36yvFsn9zaAXj2uEXzL", nameEn: "name2",nameAr: "اسم2", chat: chat, photoUrl: AppConstants.photoGroup, listUsers: [], listBlockUsers: [], date: DateTime.now()),
    Group(idAmin: "pmB1yVQEZgKYWhZZBm0f", nameEn: "name3",nameAr: "اسم3", chat: chat, photoUrl: AppConstants.photoGroup, listUsers: [], listBlockUsers: [], date: DateTime.now()),
    Group(idAmin: "EIqe6v2sdugMsByiGhcX", nameEn: "name4",nameAr: "اسم4", chat: chat, photoUrl: AppConstants.photoGroup, listUsers: [], listBlockUsers: [], date: DateTime.now()),
  ];

}
///Admin
/**
id : "EIqe6v2sdugMsByiGhcX"
  description: ""
  email: "admin4@gmail.com"
  id: "EIqe6v2sdugMsByiGhcX"
  name: "Admin hiba"
  password: "123456"
  phoneNumber: "0999888774"
  photoUrl: "gs://ehtooa-266e1.appspot.com/const/images/photoProfileAdmin.png"
  typeUser: "Admin"
  uid: "W9L7iM3EkkO2q4o4KjbgK5uSbV53"
----------------------------------------------------------------------------------
id : "V59ILq22VmKnzXgKvxSV"
    description: ""
    email: "admin1@gmail.com"
    id: "V59ILq22VmKnzXgKvxSV"
    name: "Admin Ahmad"
    password: "123456"
    phoneNumber: "0999888771"
    photoUrl: "gs://ehtooa-266e1.appspot.com/const/images/photoProfileAdmin.png"
    typeUser: "Admin"
    uid: "bX8kqn1wMPg25nPh7KBqqpQewSB3"
---------------------------------------------------------------------------
id : "pmB1yVQEZgKYWhZZBm0f"
    description: ""
    email: "admin3@gmail.com"
    id: "pmB1yVQEZgKYWhZZBm0f"
    name: "Admin leen"
    password: "123456"
    phoneNumber: "0999888773"
    photoUrl: "gs://ehtooa-266e1.appspot.com/const/images/photoProfileAdmin.png"
    typeUser: "Admin"
    uid: "94gpCt04Qodqwjl3rUT5P7kWbGn2"
-----------------------------------------------------------------------
id: "z36yvFsn9zaAXj2uEXzL"
    description: ""
    email: "admin2@gmail.com"
    id: "z36yvFsn9zaAXj2uEXzL"
    name: "Admin Mohammad"
    password: "123456"
    phoneNumber: "0999888772"
    photoUrl: "gs://ehtooa-266e1.appspot.com/const/images/photoProfileAdmin.png"
    typeUser: "Admin"
    uid: "lU8YzSQAuwMX4ujkaWc7quXpeQb2"
**/

