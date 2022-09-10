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
  int id;
  String name;
  String email;
  String phoneNumber;
  String password;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.phoneNumber,
      required this.password});
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
  int proportion;

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
/*

flutter pub run easy_localization:generate -S "assets/translations/" -O "lib/translations"
flutter pub run easy_localization:generate -S "assets/translations/" -O "lib/translations" -o "locale_keys.g.dart" -f keys
flutter build apk --split-per-abi

 */
