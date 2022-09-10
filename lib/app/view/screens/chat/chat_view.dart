import 'package:ehtooa/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  title: Text(tr(LocaleKeys.groups)),
),
        body:             Center(
          child: Text("Chat"),
        ),
    );
  }
}