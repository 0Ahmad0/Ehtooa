import 'package:ehtooa/app/view/resources/audio_list.dart';
import 'package:ehtooa/app/view/resources/color_manager.dart';
import 'package:ehtooa/app/view/resources/values_manager.dart';
import 'package:ehtooa/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../resources/assets_manager.dart';
import '../../resources/globals.dart';
import '../../widgets/chat_box.dart';
import '../../widgets/record_button.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  final textMessage = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(tr(LocaleKeys.groups)),
        ),
        body: Container(
          padding: const EdgeInsets.all(Globals.defaultPadding),
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImagesAssets.backgroundChat),
              fit: BoxFit.cover
            ),
          ),
          child: Column(
            children: [
              Expanded(child: AudioList()),
              StatefulBuilder(
                builder: (_,setStat1){
                  return  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ChatBox(
                        controller: controller,
                        text: textMessage,
                        onChanged: (val){
                          setStat1(() {

                          });
                        },
                      ),
                      const SizedBox(width: 4),
                      textMessage.text.trim().isEmpty
                      ?RecordButton(controller: controller,)
                      :GestureDetector(
                        onTap: (){
                          textMessage.clear();
                          setStat1(() {

                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle
                          ),
                          child: Icon(Icons.send,color: ColorManager.white,),
                        ),
                      )
                    ],
                  );
                },
              )
            ],
          ),
        ));
  }
}
