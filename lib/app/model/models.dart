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
  Question({required this.questionText,required this.answer});
}

//Answer
class Answer {
  String answerText;
  int proportion;

  Answer({required this.answerText,required this.proportion});
}
/*
flutter pub run easy_localization:generate -S "assets/translations/" -O "lib/translations"
flutter pub run easy_localization:generate -S "assets/translations/" -O "lib/translations" -o "locale_keys.g.dart" -f keys
flutter build apk --split-per-abi

 */
