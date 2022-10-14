import 'dart:convert';
import 'package:http/http.dart'as http;
class SendEmail{
    static Future sendEmail({required String name,required String to_email,required String message,}) async{

final url = Uri.parse("https://api.nylas.com/send");
    String token = "8SmaXcYnO1JNcMRkrHuaYir184RL7b";
final response = await http.post(
  url,
  headers: {
    "Accept":"application/json",
    "Authorization": "Bearer $token",
    },
  body:json.encode({
    "subject": "Ehtooa App",
    "to": [
      {
        "email": to_email,
        "name": name
      }
    ],
    "from": [
      {
        "email": "ehtooaapp@gmail.com",
        "name": "Ehtooa App"
      }
    ],
    "body": message
  })
  
);
print("*******************************************************");
print("*******************************************************");
print("*******************************************************");
print(response.body);
print(response.statusCode);
// final r = await http.get(Uri.parse('https://api.nylas.com/messages?limit=100&unread=true'));
// print(r.body);
print("*******************************************************");
print("*******************************************************");
print("*******************************************************");

}
}