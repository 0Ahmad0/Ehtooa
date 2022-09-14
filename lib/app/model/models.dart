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

  User(
      {required this.id,
      required this.uid,
      required this.name,
      required this.email,
      required this.phoneNumber,
      required this.password,
        required this.typeUser,
        required this.photoUrl,
        this.description=""});
  factory User.fromJson( json){
    return User(id: json["id"],
                uid: json["uid"],
                name: json["name"],
                email: json["email"],
                phoneNumber: json["phoneNumber"],
                password: json["password"],
                typeUser: json["typeUser"],
                photoUrl: json["photoUrl"],
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
    'photoUrl':photoUrl,
    'description':description,
  };
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
  String doctorName;
  String price;
  bool isSold;

  InteractiveSessions({
    required this.name,
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
}

//Message
class Message {
  String textMessage;
  String typeMessage;
  String senderId;
  DateTime sendingTime;

  Message(
      {required this.textMessage,
      required this.typeMessage,
      required this.senderId,
      required this.sendingTime});
  factory Message.fromJson( json){
    return Message(
        textMessage: json["textMessage"],
        typeMessage: json["typeMessage"],
        sendingTime: json["sendingTime"].toDate(),
        senderId: json["senderId"]);
  }
  Map<String,dynamic> toJson()=>{
    'textMessage':textMessage,
    'typeMessage':typeMessage,
    'sendingTime':sendingTime,
    'senderId':senderId,
  };
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
  DateTime date;

  Chat({
    required this.id,
    required this.date,
    required this.messages,
  });
  factory Chat.fromJson( json){
    List<Message> tempMessages = [];
    for(Message message in json["messages"]){
      tempMessages.add(Message.fromJson(message));
    }
    return Chat(
        id: json["id"],
        messages: tempMessages,//json["messages"],
        date: json["date"]);
  }
  Map<String,dynamic> toJson(){
    List<Map<String,dynamic>> tempMessages = [];
    for(Message message in messages){
      tempMessages.add(message.toJson());
    }
    return {
    'id':id,
    'date':date,
    'messages':tempMessages,
  };
  }
}

//Group
class Group {
  String idAmin;
  String nameAr;
  String nameEn;
  Chat chat;
  List<String> listUsers;
  List<String> listBlockUsers;
  String photoUrl;
  DateTime date;

  Group(
      {required this.idAmin,
        required this.nameAr,
        required this.nameEn,
        required this.chat,
        required this.photoUrl,
        required this.listUsers,
        required this.listBlockUsers,
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
        nameAr: json["nameAr"],
        nameEn: json["nameEn"],
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
    return Group(
        idAmin: json["idAmin"],
        nameAr: json["nameAr"],
        nameEn: json["nameEn"],
        chat: Chat(id: "", date: DateTime.now(), messages: []), //Chat.fromJson(json["chat"]),
        photoUrl: json["photoUrl"],
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
    'nameAr':nameAr,
    'nameEn':nameEn,
    'chat':chat.toJson(),
    'photoUrl':photoUrl,
    'listUsers':tempUsers,//listUsers,
    'listBlockUsers':tempBlockUsers,//listBlockUsers,
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
      'nameAr':nameAr,
      'nameEn':nameEn,
      //'chat':chat.toJson(),
      'photoUrl':photoUrl,
      'listUsers':tempUsers,//listUsers,
      'listBlockUsers':tempBlockUsers,//listBlockUsers,
      'date':date,
    };
  }
}

enum ChatMessageType{text,audio,image,vedio}
enum MessageStatus{not_sent,not_view,view}
/*

flutter pub run easy_localization:generate -S "assets/translations/" -O "lib/translations"
flutter pub run easy_localization:generate -S "assets/translations/" -O "lib/translations" -o "locale_keys.g.dart" -f keys
flutter build apk --split-per-abi

 */
