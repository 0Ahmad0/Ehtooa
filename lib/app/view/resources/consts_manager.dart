import 'package:ehtooa/translations/locale_keys.g.dart';
import 'package:camera/camera.dart';
import '../../model/models.dart';

class AppConstants {
  static const int splashDelay = 5;
  static const int logoDelay = 1600;
  static const int onBoardingDelay = 500;
  static const themeKEY = "theme";
  static const languageKEY = "language";
  static const isLoginedKEY = "isLogin";
  static const nameKEY = "name";
  static const phoneNumberKEY = "phoneNumber";
  static const emailKey = "email";
  static const tokenKEY = "token";
  static const idKEY = "id";

  static String storageUrl = "gs://ehtooa-266e1.appspot.com";
  static String photoProfilePatient =
      "https://firebasestorage.googleapis.com/v0/b/ehtooa-266e1.appspot.com/o/const%2Fimages%2FphotoProfilePatient.png?alt=media&token=47a6b5e2-9b83-486e-85c8-bf1a12f614b2";
  static String photoProfileAdmin =
      "https://firebasestorage.googleapis.com/v0/b/ehtooa-266e1.appspot.com/o/const%2Fimages%2FphotoProfileAdmin.png?alt=media&token=d2267ef3-e473-4248-8a5f-d5b7cd450b7d";
  static String photoProfileDoctor =
      "https://firebasestorage.googleapis.com/v0/b/ehtooa-266e1.appspot.com/o/const%2Fimages%2FphotoProfileDoctor.png?alt=media&token=4225ba33-d453-4036-afe9-37d3c29ff43d";
  static String photoGroup =
      "https://firebasestorage.googleapis.com/v0/b/ehtooa-266e1.appspot.com/o/const%2Fimages%2FphotoGroup.png?alt=media&token=afd6dcbb-8299-4525-8d44-c9d5b6cbe52e";

  //collection
  static String collection = "";
  static String collectionAdmin = "Admin";
  static String collectionDoctor = "Doctor";
  static String collectionPatient = "Patient";
  static String collectionGroup = "Group";
  static String collectionChat = "Chat";
  static String collectionSession = "Session";
  static String collectionPaySession = "PaySession";

  static List<Question> questionsDepression = [
    Question(questionText: LocaleKeys.depression_q1, answer: [
      Answer(
          answerText: LocaleKeys.depression_q1_list_answer1, proportion: 0.0),
      Answer(
          answerText: LocaleKeys.depression_q1_list_answer2, proportion: 0.5),
      Answer(
          answerText: LocaleKeys.depression_q1_list_answer3, proportion: 1.0),
      Answer(
          answerText: LocaleKeys.depression_q1_list_answer4, proportion: 1.25),
    ]),
    Question(questionText: LocaleKeys.depression_q2, answer: [
      Answer(
          answerText: LocaleKeys.depression_q1_list_answer1, proportion: 0.0),
      Answer(
          answerText: LocaleKeys.depression_q1_list_answer2, proportion: 0.5),
      Answer(
          answerText: LocaleKeys.depression_q1_list_answer3, proportion: 1.0),
      Answer(
          answerText: LocaleKeys.depression_q1_list_answer4, proportion: 1.25),
    ]),
    Question(questionText: LocaleKeys.depression_q3, answer: [
      Answer(
          answerText: LocaleKeys.depression_q1_list_answer1, proportion: 0.0),
      Answer(
          answerText: LocaleKeys.depression_q1_list_answer2, proportion: 0.5),
      Answer(
          answerText: LocaleKeys.depression_q1_list_answer3, proportion: 1.0),
      Answer(
          answerText: LocaleKeys.depression_q1_list_answer4, proportion: 1.25),
    ]),
    Question(questionText: LocaleKeys.depression_q4, answer: [
      Answer(
          answerText: LocaleKeys.depression_q1_list_answer1, proportion: 0.0),
      Answer(
          answerText: LocaleKeys.depression_q1_list_answer2, proportion: 0.5),
      Answer(
          answerText: LocaleKeys.depression_q1_list_answer3, proportion: 1.0),
      Answer(
          answerText: LocaleKeys.depression_q1_list_answer4, proportion: 1.25),
    ]),
    Question(questionText: LocaleKeys.depression_q5, answer: [
      Answer(
          answerText: LocaleKeys.depression_q1_list_answer1, proportion: 0.0),
      Answer(
          answerText: LocaleKeys.depression_q1_list_answer2, proportion: 0.5),
      Answer(
          answerText: LocaleKeys.depression_q1_list_answer3, proportion: 1.0),
      Answer(
          answerText: LocaleKeys.depression_q1_list_answer4, proportion: 1.25),
    ]),
    Question(questionText: LocaleKeys.depression_q6, answer: [
      Answer(
          answerText: LocaleKeys.depression_q1_list_answer1, proportion: 0.0),
      Answer(
          answerText: LocaleKeys.depression_q1_list_answer2, proportion: 0.5),
      Answer(
          answerText: LocaleKeys.depression_q1_list_answer3, proportion: 1.0),
      Answer(
          answerText: LocaleKeys.depression_q1_list_answer4, proportion: 1.25),
    ]),
    Question(questionText: LocaleKeys.depression_q7, answer: [
      Answer(
          answerText: LocaleKeys.depression_q1_list_answer1, proportion: 0.0),
      Answer(
          answerText: LocaleKeys.depression_q1_list_answer2, proportion: 0.5),
      Answer(
          answerText: LocaleKeys.depression_q1_list_answer3, proportion: 1.0),
      Answer(
          answerText: LocaleKeys.depression_q1_list_answer4, proportion: 1.25),
    ]),
    Question(questionText: LocaleKeys.depression_q8, answer: [
      Answer(
          answerText: LocaleKeys.depression_q1_list_answer1, proportion: 0.0),
      Answer(
          answerText: LocaleKeys.depression_q1_list_answer2, proportion: 0.5),
      Answer(
          answerText: LocaleKeys.depression_q1_list_answer3, proportion: 1.0),
      Answer(
          answerText: LocaleKeys.depression_q1_list_answer4, proportion: 1.25),
    ]),
  ];
  static List<Question> questionsOcd = [
    Question(
        questionText: LocaleKeys.ocd_q1,
        answer: [
          Answer(answerText: LocaleKeys.q1_a1, proportion: 0.0),
          Answer(answerText: LocaleKeys.q1_a2, proportion: 0.5),
          Answer(answerText: LocaleKeys.q1_a3, proportion: 1.0),
          Answer(answerText: LocaleKeys.q1_a4, proportion: 1.5),
        ]),
    Question(
        questionText: LocaleKeys.ocd_q2,
        answer: [
          Answer(answerText: LocaleKeys.q2_a1, proportion: 0.0),
          Answer(answerText: LocaleKeys.q2_a2, proportion: 0.5),
          Answer(answerText: LocaleKeys.q2_a3, proportion: 1.0),
          Answer(answerText: LocaleKeys.q2_a4, proportion: 1.5),
        ]),
    Question(
        questionText: LocaleKeys.ocd_q3,
        answer: [
          Answer(answerText: LocaleKeys.q3_a1, proportion: 0.0),
          Answer(answerText: LocaleKeys.q3_a2, proportion: 0.5),
          Answer(answerText: LocaleKeys.q3_a3, proportion: 1.0),
          Answer(answerText: LocaleKeys.q3_a4, proportion: 1.5),
        ]),
    Question(
        questionText: LocaleKeys.ocd_q4,
        answer: [
          Answer(answerText: LocaleKeys.q4_a1, proportion: 0.5),
          Answer(answerText: LocaleKeys.q4_a2, proportion: 1.0),
          Answer(answerText: LocaleKeys.q4_a3, proportion: 0.0),
          Answer(answerText: LocaleKeys.q4_a4, proportion: 1.5),
        ]),
    Question(
        questionText: LocaleKeys.ocd_q5,
        answer: [
          Answer(answerText: LocaleKeys.q5_a1, proportion: 0.5),
          Answer(answerText: LocaleKeys.q5_a2, proportion: 1.0),
          Answer(answerText: LocaleKeys.q5_a3, proportion: 0.0),
          Answer(answerText: LocaleKeys.q5_a4, proportion: 1.5),
        ]),
    Question(
        questionText: LocaleKeys.ocd_q6,
        answer: [
          Answer(answerText: LocaleKeys.q6_a1, proportion: 0.5),
          Answer(answerText: LocaleKeys.q6_a2, proportion: 1.0),
          Answer(answerText: LocaleKeys.q6_a3, proportion: 0.0),
          Answer(answerText: LocaleKeys.q6_a4, proportion: 1.5),
        ]),
    Question(
        questionText: LocaleKeys.ocd_q7,
        answer: [
          Answer(answerText: LocaleKeys.q7_a1, proportion: 0.5),
          Answer(answerText: LocaleKeys.q7_a2, proportion: 1.0),
          Answer(answerText: LocaleKeys.q7_a3, proportion: 0.0),
          Answer(answerText: LocaleKeys.q7_a4, proportion: 1.5),
        ]),
    Question(
        questionText: LocaleKeys.ocd_q8,
        answer: [
          Answer(answerText: LocaleKeys.q8_a1, proportion: 0.5),
          Answer(answerText: LocaleKeys.q8_a2, proportion: 1.0),
          Answer(answerText: LocaleKeys.q8_a3, proportion: 0.0),
          Answer(answerText: LocaleKeys.q8_a4, proportion: 1.5),
        ]),
  ];
  static List<Question> questionsSleepDisorders = [
    Question(
        questionText: LocaleKeys.sleep_q1,
        answer: [
          Answer(answerText: LocaleKeys.s1_a1, proportion: 0.5),
          Answer(answerText: LocaleKeys.s1_a2, proportion: 1.0),
          Answer(answerText: LocaleKeys.s1_a3, proportion: 0.0),
          Answer(answerText: LocaleKeys.s1_a4, proportion: 1.5),
        ]),
    Question(
        questionText: LocaleKeys.sleep_q2,
        answer: [
          Answer(answerText: LocaleKeys.s2_a1, proportion: 0.5),
          Answer(answerText: LocaleKeys.s2_a2, proportion: 1.0),
          Answer(answerText: LocaleKeys.s2_a3, proportion: 0.0),
          Answer(answerText: LocaleKeys.s2_a4, proportion: 1.5),
        ]),
    Question(
        questionText: LocaleKeys.sleep_q3,
        answer: [
          Answer(answerText: LocaleKeys.s3_a1, proportion: 0.5),
          Answer(answerText: LocaleKeys.s3_a2, proportion: 1.0),
          Answer(answerText: LocaleKeys.s3_a3, proportion: 0.0),
          Answer(answerText: LocaleKeys.s3_a4, proportion: 1.5),
        ]),
    Question(
        questionText: LocaleKeys.sleep_q4,
        answer: [
          Answer(answerText: LocaleKeys.s4_a1, proportion: 0.5),
          Answer(answerText: LocaleKeys.s4_a2, proportion: 1.0),
          Answer(answerText: LocaleKeys.s4_a3, proportion: 0.0),
          Answer(answerText: LocaleKeys.s4_a4, proportion: 1.5),
        ]),
    Question(
        questionText: LocaleKeys.sleep_q5,
        answer: [
          Answer(answerText: LocaleKeys.s5_a1, proportion: 0.5),
          Answer(answerText: LocaleKeys.s5_a2, proportion: 1.0),
          Answer(answerText: LocaleKeys.s5_a3, proportion: 0.0),
          Answer(answerText: LocaleKeys.s5_a4, proportion: 1.5),
        ]),
    Question(
        questionText: LocaleKeys.sleep_q6,
        answer: [
          Answer(answerText: LocaleKeys.s6_a1, proportion: 0.5),
          Answer(answerText: LocaleKeys.s6_a2, proportion: 1.0),
          Answer(answerText: LocaleKeys.s6_a3, proportion: 0.0),
          Answer(answerText: LocaleKeys.s6_a4, proportion: 1.5),
        ]),
    Question(
        questionText: LocaleKeys.sleep_q7,
        answer: [
          Answer(answerText: LocaleKeys.s7_a1, proportion: 0.5),
          Answer(answerText: LocaleKeys.s7_a2, proportion: 1.0),
          Answer(answerText: LocaleKeys.s7_a3, proportion: 0.0),
          Answer(answerText: LocaleKeys.s7_a4, proportion: 1.5),
        ]),
    Question(
        questionText: LocaleKeys.sleep_q8,
        answer: [
          Answer(answerText: LocaleKeys.s8_a1, proportion: 0.5),
          Answer(answerText: LocaleKeys.s8_a2, proportion: 1.0),
          Answer(answerText: LocaleKeys.s8_a3, proportion: 0.0),
          Answer(answerText: LocaleKeys.s8_a4, proportion: 1.5),
        ]),

  ];
  static List<Question> questionsAnxiety = [
    Question(
        questionText: LocaleKeys.anxiet_q1,
        answer: [
          Answer(answerText: LocaleKeys.a8_a1, proportion: 0.5),
          Answer(answerText: LocaleKeys.a8_a2, proportion: 1.0),
          Answer(answerText: LocaleKeys.a8_a3, proportion: 0.0),
          Answer(answerText: LocaleKeys.a8_a4, proportion: 1.5),
        ]),
    Question(
        questionText: LocaleKeys.anxiet_q2,
        answer: [
          Answer(answerText: LocaleKeys.a8_a1, proportion: 0.5),
          Answer(answerText: LocaleKeys.a8_a2, proportion: 1.0),
          Answer(answerText: LocaleKeys.a8_a3, proportion: 0.0),
          Answer(answerText: LocaleKeys.a8_a4, proportion: 1.5),
        ]),
    Question(
        questionText: LocaleKeys.anxiet_q3,
        answer: [
          Answer(answerText: LocaleKeys.a8_a1, proportion: 0.5),
          Answer(answerText: LocaleKeys.a8_a2, proportion: 1.0),
          Answer(answerText: LocaleKeys.a8_a3, proportion: 0.0),
          Answer(answerText: LocaleKeys.a8_a4, proportion: 1.5),
        ]),
    Question(
        questionText: LocaleKeys.anxiet_q4,
        answer: [
          Answer(answerText: LocaleKeys.a8_a1, proportion: 0.5),
          Answer(answerText: LocaleKeys.a8_a2, proportion: 1.0),
          Answer(answerText: LocaleKeys.a8_a3, proportion: 0.0),
          Answer(answerText: LocaleKeys.a8_a4, proportion: 1.5),
        ]),
    Question(
        questionText: LocaleKeys.anxiet_q5,
        answer: [
          Answer(answerText: LocaleKeys.a8_a1, proportion: 0.5),
          Answer(answerText: LocaleKeys.a8_a2, proportion: 1.0),
          Answer(answerText: LocaleKeys.a8_a3, proportion: 0.0),
          Answer(answerText: LocaleKeys.a8_a4, proportion: 1.5),
        ]),
    Question(
        questionText: LocaleKeys.anxiet_q6,
        answer: [
          Answer(answerText: LocaleKeys.a8_a1, proportion: 0.5),
          Answer(answerText: LocaleKeys.a8_a2, proportion: 1.0),
          Answer(answerText: LocaleKeys.a8_a3, proportion: 0.0),
          Answer(answerText: LocaleKeys.a8_a4, proportion: 1.5),
        ]),
    Question(
        questionText: LocaleKeys.anxiet_q7,
        answer: [
          Answer(answerText: LocaleKeys.a8_a1, proportion: 0.5),
          Answer(answerText: LocaleKeys.a8_a2, proportion: 1.0),
          Answer(answerText: LocaleKeys.a8_a3, proportion: 0.0),
          Answer(answerText: LocaleKeys.a8_a4, proportion: 1.5),
        ]),
    Question(
        questionText: LocaleKeys.anxiet_q8,
        answer: [
          Answer(answerText: LocaleKeys.a8_a1, proportion: 0.5),
          Answer(answerText: LocaleKeys.a8_a2, proportion: 1.0),
          Answer(answerText: LocaleKeys.a8_a3, proportion: 0.0),
          Answer(answerText: LocaleKeys.a8_a4, proportion: 1.5),
        ]),
  ];

}
