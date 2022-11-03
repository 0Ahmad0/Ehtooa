import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'models.dart';

class Advance {
  static bool theme = false;
  static bool language = false;
  static bool isRegisterKEY = false;
  static bool isLogined = false;
  static String token = "";
  static String uid = "";
  static String avatarImage = "";
}

//onBoarding Model
class OnBoarding {
  String image;
  String text;

  OnBoarding({required this.image, required this.text});
}

//user
class User {
  String id;
  String uid;
  String name;
  String photoUrl;
  String email;
  String phoneNumber;
  String password;
  String typeUser;
  String description;
  String serialNumber;
  List listUsedQuizzes;
  User(
      {required this.id,
      required this.uid,
      required this.name,
      required this.email,
      required this.phoneNumber,
      required this.password,
        required this.typeUser,
        required this.photoUrl,
         required this.listUsedQuizzes,
        this.description="",
        this.serialNumber=""});
  factory User.fromJson( json){
    String tempSerialNumber="";
    return User(id: json['id'],
                uid: json["uid"],
                name: json["name"],
                email: json["email"],
                phoneNumber: json["phoneNumber"],
                password: json["password"],
                typeUser: json["typeUser"],
              photoUrl: json["photoUrl"],
              serialNumber: json["serialNumber"],
               listUsedQuizzes:json["listUsedQuizzes"],
               description: (json["description"]!=null)?json["description"]:"");
  }
  Map<String,dynamic> toJson()=>{
    'id':id,
    'uid':uid,
    'name':name,
    'email':email,
    'phoneNumber':phoneNumber,
    'password':password,
    'typeUser':typeUser,
    'serialNumber':serialNumber,
    'photoUrl':photoUrl,
    'listUsedQuizzes':listUsedQuizzes,
    'description':description,
  };
}
//Users
class Users {
  List<User> users;
  //DateTime date;

  Users({
    required this.users
  });
  factory Users.fromJson( json){
    List<User> tempUsers = [];
    for(int i=0;i<json.length;i++){
      User tempUser=User.fromJson(json[i]);
      tempUser.id=json[i].id;
      tempUsers.add(tempUser);
    }
    return Users(
        users: tempUsers
    );
  }
  Map<String,dynamic> toJson(){
    List<Map<String,dynamic>> tempUsers = [];
    for(User user in users){
      tempUsers.add(user.toJson());
    }
    return {
      'users':tempUsers,
    };
  }
}

//Question
class Question {
  String questionText;
  List<Answer> answer;

  Question({required this.questionText, required this.answer});
}

//Answer
class Answer {
  String answerText;
  double proportion;

  Answer({required this.answerText, required this.proportion});
}

//InteractiveSessions
class InteractiveSessions {
  String name;
  String id_link;
  String idGroup;
  String doctorName;
  String price;
  bool isSold;

  InteractiveSessions({
    required this.name,
    required this.idGroup,
    required this.id_link,
    required this.isSold,
    required this.doctorName,
    required this.price,
  });
}

//Doctor
class Doctor {
  String id;
  String name;
  String carer;
  String description;

  Doctor(
      {required this.id,
      required this.name,
      required this.carer,
      required this.description});
  factory Doctor.fromUser(User user){
    return Doctor(id: user.id, name: user.name, carer: user.photoUrl, description: user.description);
  }
}

//Message
class Message {
  String id;
  bool checkSend;
  int index;
  String textMessage;
  int sizeFile;
  String url;
  String urlTempPhoto;
  String localUrl;
  String typeMessage;
  String senderId;
  String replayId;
  DateTime sendingTime;
  List deleteUserMessage;
  Message(
      {this.id="",
      this.index=-1,
      this.sizeFile=0,
      this.checkSend=true,
      required this.textMessage,
       this.url="",
       this.urlTempPhoto="",
       this.localUrl="",
        required this.replayId,
      required this.typeMessage,
      required this.senderId,
      required this.deleteUserMessage,
      required this.sendingTime});
  factory Message.fromJson( json){
    List<String> tempDeleteUserMessage = [];
    for(String user in json["deleteUserMessage"]){
      tempDeleteUserMessage.add(user);
    }
    String tempUrl="";
    if(!json["typeMessage"].contains(ChatMessageType.text.name)){
      tempUrl=json["url"];
    }
    String tempLocalUrl="";
    if(json.data().containsKey("localUrl")){
      tempLocalUrl=json["localUrl"];
    }
    int tempSizeFile=0;
    if(json.data().containsKey("sizeFile")){
      tempSizeFile=json["sizeFile"];
    }
    String tempUrlTempPhoto="";
    if(json.data().containsKey("urlTempPhoto")){
      tempUrlTempPhoto=json["urlTempPhoto"];
    }
    return Message(
      url: tempUrl,
        localUrl: tempLocalUrl,
        textMessage: json["textMessage"],
        typeMessage: json["typeMessage"],
        sendingTime: json["sendingTime"].toDate(),
        senderId: json["senderId"],
        deleteUserMessage: tempDeleteUserMessage,
        urlTempPhoto: tempUrlTempPhoto,
        sizeFile: tempSizeFile,
    replayId: json["replayId"]);
  }
  Map<String,dynamic> toJson() {
    List tempDeleteUserMessage = [];
    for(String user in deleteUserMessage){
      tempDeleteUserMessage.add(user);
    }
    return {
      'textMessage': textMessage,
      'typeMessage': typeMessage,
      'senderId': senderId,
      'sendingTime': sendingTime,
      'deleteUserMessage': tempDeleteUserMessage,
      'urlTempPhoto': urlTempPhoto,
      'sizeFile': sizeFile,
      'replayId': replayId,
      'url': url,
      'localUrl': localUrl,
    };
  }
}

//Admin
class Admin {
  String id;
  String name;

  Admin({required this.id, required this.name});
}

//Chat
class Chat {
  String id;
  List<Message> messages;
  //DateTime date;

  Chat({
    required this.id,
    //required this.date,
    required this.messages,
  });
  factory Chat.fromJson( json){
    List<Message> tempMessages = [];
    for(int i=1;i<json['messages'].length;i++){

      Message tempMessage=Message.fromJson(json['messages'][i]);
      tempMessage.id=json['messages'][i].id;
      tempMessages.add(tempMessage);
    }
    return Chat(
        id: json['id'],
        messages: tempMessages//json["messages"],
      //  date: json["date"]
          );
  }
  factory Chat.fromJsonWithFilterIdUser( json,{required String idUser}){
    List<Message> tempMessages = [];
    for(int i=1;i<json['messages'].length;i++){
      Message tempMessage=Message.fromJson(json['messages'][i]);
      tempMessage.id=json['messages'][i].id;
      if(!tempMessage.deleteUserMessage.contains(idUser))
         tempMessages.add(tempMessage);
    }
    return Chat(
        id: json['id'],
        messages: tempMessages//json["messages"],
      //  date: json["date"]
    );
  }
  Map<String,dynamic> toJson(){
    List<Map<String,dynamic>> tempMessages = [];
    for(Message message in messages){
      tempMessages.add(message.toJson());
    }
    return {
    'id':id,
    //'date':date,
    'messages':tempMessages,
  };
  }
}


//Group
class Group {
  String id;
  String idAmin;
  int sort;
  String nameAr;
  String nameEn;
  Chat chat;
  List<String> listUsers;
  List<String> listBlockUsers;
  String photoUrl;
  DateTime date;
  Map<String,dynamic> listUserPay;

  Group(
      {this.id="",
        this.sort=0,
      required this.idAmin,
        required this.nameAr,
        required this.nameEn,
        required this.chat,
        required this.photoUrl,
        required this.listUsers,
        required this.listBlockUsers,
         this.listUserPay=const {},
        required this.date});
  factory Group.fromJson( json){
    List<String> tempUsers = [];
    List<String> tempBlockUsers = [];
    for(String user in json["listUsers"]){
      tempUsers.add(user);
    }
    for(String user in json["listBlockUsers"]){
      tempBlockUsers.add(user);
      Timestamp t;
    }
    return Group(
        idAmin: json["idAmin"],
        sort: json["sort"],
        nameAr: json["nameAr"],
        nameEn: json["nameEn"],
        listUserPay: json["listUserPay"],
        chat: Chat.fromJson(json["chat"]),
        photoUrl: json["photoUrl"],
        listUsers: tempUsers,//json["listUsers"],
        listBlockUsers: tempBlockUsers,//json["listBlockUsers"],
        date: json["date"]);
  }
  factory Group.fromJsonFire( json){
    List<String> tempUsers = [];
    List<String> tempBlockUsers = [];
    for(String user in json["listUsers"]){
      tempUsers.add(user);
    }
    for(String user in json["listBlockUsers"]){
      tempBlockUsers.add(user);
    }
    Map tempMap=json["listUserPay"];
    return Group(
        idAmin: json["idAmin"],
        sort: json["sort"],
        nameAr: json["nameAr"],
        nameEn: json["nameEn"],
        chat: Chat(id: "", messages: []), //Chat.fromJson(json["chat"]),
        photoUrl: json["photoUrl"],
        listUserPay: json["listUserPay"],
        listUsers: tempUsers,//json["listUsers"],
        listBlockUsers: tempBlockUsers,//json["listBlockUsers"],
        date: json["date"].toDate());
  }
  Map<String,dynamic> toJson(){
    List tempUsers = [];
    List tempBlockUsers = [];
    for(String user in listUsers){
      tempUsers.add(user);
    }
    for(String user in listBlockUsers){
      tempBlockUsers.add(user);
    }
    return {
    'idAmin':idAmin,
    'sort':sort,
    'nameAr':nameAr,
    'nameEn':nameEn,
    'chat':chat.toJson(),
    'photoUrl':photoUrl,
    'listUsers':tempUsers,//listUsers,
    'listBlockUsers':tempBlockUsers,//listBlockUsers,
    'listUserPay':listUserPay,//listBlockUsers,
    'date':date,
  };
}
  Map<String,dynamic> toJsonFire(){
    List tempUsers = [];
    List tempBlockUsers = [];
    for(String user in listUsers){
      tempUsers.add(user);
    }
    for(String user in listBlockUsers){
      tempBlockUsers.add(user);
    }
    return {
      'idAmin':idAmin,
      'sort':sort,
      'nameAr':nameAr,
      'nameEn':nameEn,
      //'chat':chat.toJson(),
      'photoUrl':photoUrl,
      'listUsers':tempUsers,//listUsers,
      'listBlockUsers':tempBlockUsers,//listBlockUsers,
      'listUserPay':listUserPay,//listBlockUsers,
      'date':date,
    };
  }
}

//Groups
class Groups {
  List<Group> groups;
  //DateTime date;

  Groups({
    required this.groups
  });
  factory Groups.fromJson( json){
    List<Group> tempGroups = [];
    for(int i=0;i<json.length;i++){
      Group tempGroup=Group.fromJsonFire(json[i]);
      tempGroup.id=json[i].id;
      tempGroups.add(tempGroup);
    }
    return Groups(
        groups: tempGroups
    );
  }
  Map<String,dynamic> toJson(){
    List<Map<String,dynamic>> tempGroups = [];
    for(Group group in groups){
      tempGroups.add(group.toJsonFire());
    }
    return {
      'groups':tempGroups,
    };
  }
}

//Session
class Session {
  String id;
  String idAmin;
  String sessionUrl;
  String idGroup;
  String name;
  int price;
  List<String> listDoctor;
  List<String> listUserPay;
  List<String> listNotifications;
  List<String> listNotificationsView;
  String photoUrl;
  DateTime date;

  Session(
      {this.id="",
        required this.idAmin,
        required this.name,
        required this.sessionUrl,
        required this.idGroup,
         this.photoUrl="",
        required this.price,
        required this.listDoctor,
        required this.listUserPay,
         this.listNotifications=const [],
         this.listNotificationsView=const [],
        required this.date});
  factory Session.fromJson( json){
    List<String> tempDoctor = [];
    List<String> tempUserPay = [];
    List<String> tempNotifications = [];
    List<String> tempNotificationsView = [];
    for(String user in json["listDoctor"]){
      tempDoctor.add(user);
    }
    for(String user in json["listUserPay"]){
      tempUserPay.add(user);
    }
    for(String user in json["listNotifications"]){
      tempNotifications.add(user);
    }
    for(String user in json["listNotificationsView"]){
      tempNotificationsView.add(user);
    }
    return Session(
        id: json["id"],
        idAmin: json["idAmin"],
        name: json["name"],
        photoUrl: json["photoUrl"],
        sessionUrl: json["sessionUrl"],
        idGroup: json["idGroup"],
        price: json["price"],
        listDoctor: tempDoctor,//json["listUsers"],
        listUserPay: tempUserPay,//json["listBlockUsers"],
        listNotifications: tempNotifications,//json["listBlockUsers"],
        listNotificationsView: tempNotificationsView,//json["listBlockUsers"],
        date: json["date"].toDate()
    );
  }
  factory Session.fromJsonFire( json){
    List<String> tempDoctor = [];
    List<String> tempUserPay = [];
    List<String> tempNotifications = [];
    List<String> tempNotificationsView = [];
    for(String user in json["listDoctor"]){
      tempDoctor.add(user);
    }
    for(String user in json["listUserPay"]){
      tempUserPay.add(user);
    }
    for(String user in json["listNotifications"]){
      tempNotifications.add(user);
    }
    for(String user in json["listNotificationsView"]){
      tempNotificationsView.add(user);
    }
    return Session(
        idAmin: json["idAmin"],
        name: json["name"],
        photoUrl: json["photoUrl"],
        sessionUrl: json["sessionUrl"],
        idGroup: json["idGroup"],
        price: json["price"],
        listDoctor: tempDoctor,//json["listUsers"],
        listUserPay: tempUserPay,//json["listBlockUsers"],
        listNotifications: tempNotifications,//json["listBlockUsers"],
        listNotificationsView: tempNotificationsView,//json["listBlockUsers"],
        date: json["date"]
    );
  }
  Map<String,dynamic> toJson(){
    List tempDoctor = [];
    List tempUserPay = [];
    List<String> tempNotifications = [];
    List<String> tempNotificationsView = [];
    for(String user in listDoctor){
      tempDoctor.add(user);
    }
    for(String user in listUserPay){
      tempUserPay.add(user);
    }
    for(String user in listNotifications){
      tempNotifications.add(user);
    }
    for(String user in listNotificationsView){
      tempNotificationsView.add(user);
    }
    return {
      'id':id,
      'idAmin':idAmin,
      'name':name,
      'photoUrl':photoUrl,
      'sessionUrl':sessionUrl,
      'idGroup':idGroup,
      'price':price,
      'listDoctor':tempDoctor,//listUsers,
      'listUserPay':tempUserPay,//listBlockUsers,
      'listNotifications':tempNotifications,//listBlockUsers,
      'listNotificationsView':tempNotificationsView,//listBlockUsers,
      'date':date,
    };
  }
  Map<String,dynamic> toJsonFire(){
    List tempDoctor = [];
    List tempUserPay = [];
    List<String> tempNotifications = [];
    List<String> tempNotificationsView = [];
    for(String user in listDoctor){
      tempDoctor.add(user);
    }
    for(String user in listUserPay){
      tempUserPay.add(user);
    }
    for(String user in listNotifications){
      tempNotifications.add(user);
    }
    for(String user in listNotificationsView){
      tempNotificationsView.add(user);
    }
    return {
      'id':id,
      'idAmin':idAmin,
      'name':name,
      'photoUrl':photoUrl,
      'sessionUrl':sessionUrl,
      'idGroup':idGroup,
      'price':price,
      'listDoctor':tempDoctor,//listUsers,
      'listUserPay':tempUserPay,//listBlockUsers,
      'listNotifications':tempNotifications,//listBlockUsers,
      'listNotificationsView':tempNotificationsView,//listBlockUsers,
      'date':date,
    };
  }
}

//Sessions
class Sessions {
  List<Session> sessions;

  Sessions({
    required this.sessions
  });
  factory Sessions.fromJson( json){
    List<Session> tempSessions = [];
    for(int i=0;i<json.length;i++){
      Session tempSession=Session.fromJson(json[i]);
     // tempSession.id=json[i].id;
      tempSessions.add(tempSession);
    }
    return Sessions(
        sessions: tempSessions
    );
  }
  Map<String,dynamic> toJson(){
    List<Map<String,dynamic>> tempSessions = [];
    for(Session session in sessions){
      tempSessions.add(session.toJsonFire());
    }
    return {
      'sessions':tempSessions,
    };
  }
}

//Session
class PaySession {
  String idUser;
  bool checkWrite;
  List<DateTime> listSessionPay=[DateTime.now(),DateTime.now(),DateTime.now(),DateTime.now()];
  List<bool> listCheckSessionPay;
  PaySession(
      {required this.idUser,
      this.checkWrite=true,
        required this.listSessionPay,
         this.listCheckSessionPay=const [false,false,false,false],
        });
  factory PaySession.fromJson( json){
    List<DateTime> tempSessionPay = [];
    List<bool> tempCheckSessionPay = [];
    for(Timestamp date in json["listSessionPay"]){
      tempSessionPay.add(date.toDate());
    }
    for(bool checkSessionPay in json["listCheckSessionPay"]){
      tempCheckSessionPay.add(checkSessionPay);
    }
    return PaySession(
        idUser: json["idUser"],
      checkWrite: json["checkWrite"],
      listSessionPay: tempSessionPay,
      listCheckSessionPay: tempCheckSessionPay,

    );
  }
  Map<String,dynamic> toJson(){
    List<Timestamp> tempSessionPay = [];
    List<bool> tempCheckSessionPay = [];
    for(DateTime date in listSessionPay){
      tempSessionPay.add(Timestamp.fromDate(date));
    }
    for(bool checkSessionPay in listCheckSessionPay){
      tempCheckSessionPay.add(checkSessionPay);
    }
    return {
      'idUser':idUser,
      'checkWrite':checkWrite,
      'listSessionPay':tempSessionPay,
      'listCheckSessionPay':tempCheckSessionPay,
    };
  }
}

//Notification
class Notification {
  String id;
  int range;
  //DateTime date;

  Notification({
    required this.id,
    required this.range,
  });
  factory Notification.fromJson( json){
    return Notification(
        id: json['id'],
  range: json["range"]
    );
  }
  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'range':range,
    };
  }
}


enum ChatMessageType{text,audio,image,video}
enum MessageStatus{not_sent,not_view,view}
enum UpdateGroupType{update,change_name,add_user,block_user,delete_user,PaySessions}
/*

flutter pub run easy_localization:generate -S "assets/translations/" -O "lib/translations"
flutter pub run easy_localization:generate -S "assets/translations/" -O "lib/translations" -o "locale_keys.g.dart" -f keys
flutter build apk --split-per-abi
./gradlew signingReport ///SH1
temp@gmail.com   123456
 */
