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

  User(
      {required this.id,
      required this.uid,
      required this.name,
      required this.email,
      required this.phoneNumber,
      required this.password,
        required this.typeUser,
        required this.photoUrl});
  factory User.fromJson(Map<String,dynamic> json){
    return User(id: json["id"],
                uid: json["uid"],
                name: json["name"],
                email: json["email"],
                phoneNumber: json["phoneNumber"],
                password: json["password"],
                typeUser: json["typeUser"],
                photoUrl: json["photoUrl"]);
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
  String senderName;
  DateTime sendingTime;

  Message(
      {required this.textMessage,
      required this.senderName,
      required this.sendingTime});
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
  List<User> users;
  List<Message> messages;
  Admin admin;

  Chat({
    required this.id,
    required this.users,
    required this.messages,
    required this.admin,
  });
}

enum ChatMessageType{text,audio,image,vedio}
enum MessageStatus{not_sent,not_view,view}
/*

flutter pub run easy_localization:generate -S "assets/translations/" -O "lib/translations"
flutter pub run easy_localization:generate -S "assets/translations/" -O "lib/translations" -o "locale_keys.g.dart" -f keys
flutter build apk --split-per-abi

 */
