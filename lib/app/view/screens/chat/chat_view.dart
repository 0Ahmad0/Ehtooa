import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehtooa/app/controller/home_provider.dart';
import 'package:ehtooa/app/model/models.dart';
import 'package:ehtooa/app/view/screens/global_member/global_member.dart';
import 'package:open_file/open_file.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:ehtooa/app/model/utils/const.dart';
import 'package:ehtooa/app/model/utils/sizer.dart';
import 'package:ehtooa/app/view/resources/assets_manager.dart';
import 'package:ehtooa/app/view/resources/style_manager.dart';
import 'package:ehtooa/app/view/resources/values_manager.dart';
import 'package:ehtooa/translations/locale_keys.g.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:video_player/video_player.dart';
import 'package:voice_message_package/voice_message_package.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:custom_gallery_display/custom_gallery_display.dart';
import '../../../controller/groups_provider.dart';
import '../../../controller/profile_provider.dart';
import '../../../controller/chat_provider.dart';
import '../../../controller/utils/firebase.dart';
import '../../../model/models.dart' as model;
import '../../../model/models.dart';
import '../../../model/models.dart';
import '../../resources/color_manager.dart';
import 'dart:ui' as ui;
import 'package:provider/provider.dart';
import '../../resources/consts_manager.dart';
import '../list_of_member/list_of_member_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'ex/chat_composer.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  List<Widget> list = [];
  List<Widget> listSend = [];
  List<Message> listSendMessage = [];
  TextEditingController con = TextEditingController();
  final foucsNode = FocusNode();
  var setState3;

  //String? replayMessage;
  String? replayIdMessage = "";
  late ChatProvider chatProvider;
  late HomeProvider homeProvider;
  late ProfileProvider profileProvider;
  Function? setStateChat;
  double? widthImageChat;

  @override
  Widget build(BuildContext context) {
    foucsNode.requestFocus();
    profileProvider = Provider.of<ProfileProvider>(context);
    chatProvider = Provider.of<ChatProvider>(context);
    homeProvider = Provider.of<HomeProvider>(context);
    widthImageChat = Sizer.getW(context) * 0.20;
    ///print(chatProvider.group.nameAr);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 1,
        title: ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (ctx) => ListOfMemberView(
                          users: [
                            User(
                                id: "id",
                                uid: "uid",
                                name: "Kholod",
                                email: "Kholod@gmail.com",
                                phoneNumber: "0522325465",
                                password: "password",
                                typeUser: "typeUser",
                                photoUrl: "photoUrl",
                                listUsedQuizzes: [false, false, false, false])
                          ],
                        )));
          },
          leading: CircleAvatar(
            radius: AppSize.s24,
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              width: Sizer.getW(context) * 0.1,
              height: Sizer.getW(context) * 0.1,
              imageUrl:
                  // "${AppUrl.baseUrlImage}${widget.restaurant.imageLogo!}",
                  "${chatProvider.group.photoUrl}",
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    //    colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                  ),
                ),
              ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                  //FlutterLogo(),
                  SizedBox(),
            ),
          ),
          title: Text(
            "${!(context.locale == 'en') ? chatProvider.group.nameAr : chatProvider.group.nameEn}", /*tr(LocaleKeys.anxiety_patients)*/
          ),
          subtitle: Text(
              "${chatProvider.group.listUsers.length + 1} Member" /*"35 Member"*/),
          trailing:
          (profileProvider.user.typeUser.contains(AppConstants.collectionAdmin))?
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => GlobalMemberView()));
              },
              icon: Icon(Icons.person_add))
          :SizedBox(),
        ),
      ),
      body:
          Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(.2), BlendMode.darken),
                      image: AssetImage(ImagesAssets.backgroundChat))),
              child: StreamBuilder<QuerySnapshot>(
                  //prints the messages to the screen0
                  stream: FirebaseFirestore.instance
                      .collection(AppConstants.collectionGroup)
                      // .doc("taoId1xj5dSDNEoaYlFd")
                      .doc(chatProvider.group.id)
                      .collection(AppConstants.collectionChat)
                      .orderBy("sendingTime")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Const.SHOWLOADINGINDECATOR();
                      //Const.CIRCLE(context);
                    } else if (snapshot.connectionState ==
                        ConnectionState.active) {
                      if (snapshot.hasError) {
                        return const Text('Error');
                      } else if (snapshot.hasData) {
                        Const.SHOWLOADINGINDECATOR();
                        print("streame ${snapshot.data!.docs.length}");
                        chatProvider.group.chat =
                            Chat.fromJsonWithFilterIdUser({
                          'id': chatProvider.group.id,
                          'messages': snapshot.data!.docs
                        }, idUser: profileProvider.user.id);

                        convertListMessagesToListUsers(chatProvider.group.chat);
                        convertListMessagesToListWidget(
                            chatProvider.group.chat);
                        return StatefulBuilder(builder: (_, setStateChat) {
                          setState3 = setStateChat;
                          convertListSendMessagesToListWidget(listSendMessage);
                          // Navigator.of(context).pop();
                          return SingleChildScrollView(
                            reverse: true,
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.all(
                                  AppPadding.p10,
                                ),
                                itemCount:
                                    chatProvider.group.chat.messages.length +
                                        listSendMessage.length,

                                ///list.length,
                                itemBuilder: (_, pos) {
                                  //   chatProvider.group.chat.messages[pos].index = pos;
                                  return

                                      ///BuildMessageShape(isMe: true, child: Text("${chatProvider.group.chat.messages[pos].textMessage}"));
                                      list[pos];
                                  // return ListTile(title: Text(list[pos]));
                                }),
                          );
                        });

                        /// }));
                      } else {
                        return const Text('Empty data');
                      }
                    } else {
                      return Text('State: ${snapshot.connectionState}');
                    }
                  }),
            ),
          ),
          ChangeNotifierProvider<ChatProvider>.value(
              value: chatProvider,
              child: Consumer<ChatProvider>(
                builder: (context, value, child) =>

                    // print("chat replay massege${value.replayMessage}");
                    //  setStateChat=setState1;
                (!chatProvider.checkBlockUserInGroup(idUser: profileProvider.user.id))?
                    Column(
                  children: [
                    if (value.isReplay) buildReplay(),
                    Directionality(
                      textDirection: ui.TextDirection.ltr,
                      child: ChatComposer(
                        composerColor: Theme.of(context).cardColor,
                        backgroundColor: Theme.of(context).cardColor,
                        borderRadius: value.isReplay
                            ? BorderRadius.vertical(
                                bottom: Radius.circular(AppSize.s8))
                            : BorderRadius.circular(AppSize.s8),
                        focusNode: foucsNode,
                        textFieldDecoration: InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        textStyle: getRegularStyle(
                            color: Theme.of(context).textTheme.bodyText1!.color,
                            fontSize: Sizer.getW(context) / 30),
                        controller: con,
                        onReceiveText: (str) async {
                          //  print("gggg${str}");
                          ///   setState1(() async {
                          // print("chat lists : ${list.length}");
                          Message tempMessage = Message(
                              textMessage: str.toString(),
                              replayId: "",
                              typeMessage: "text",
                              senderId: profileProvider.user.id,
                              deleteUserMessage: [],
                              sendingTime: DateTime.now(),
                              checkSend: false);
                          value.getReplayMessage();
                          if (value.isReplay) {
                            tempMessage.replayId = value.replayIdMessage;
                            print(value.replayIdMessage);
                            list.add(SwipeTo(
                                onRightSwipe: () {
                                  print(str);

                                  /// value.replayMessage = str;
                                  foucsNode.requestFocus();
                                  chatProvider.changeReplayMessage(
                                      replayMessage: str);

                                  // setState1(() {});
                                },
                                child: BuildMessageShape(
                                  //isMe: true,
                                  message: tempMessage,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: Sizer.getW(context) * 0.15,
                                        padding: EdgeInsets.all(AppPadding.p8),
                                        decoration: BoxDecoration(
                                          color: ColorManager.lightGray
                                              .withOpacity(.5),
                                          borderRadius:
                                              BorderRadius.circular(AppSize.s8),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            VerticalDivider(
                                              thickness: AppSize.s4,
                                              color: Theme.of(context)
                                                  .primaryColor
                                                  .withOpacity(.5),
                                            ),
                                            Flexible(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    ("${(homeProvider.cacheUser.containsKey(value.messageReplay.senderId) ? homeProvider.cacheUser[value.messageReplay.senderId] : "")}"),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        Sizer.getW(context) *
                                                            0.01,
                                                  ),
                                                  Text(
                                                    value.messageReplay
                                                        .textMessage,
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(con.text),
                                      )
                                    ],
                                  ),
                                )));

                            /// value.replayMessage = null;
                            /// chatProvider.replayIdMessage="";
                            ///   chatProvider.changeReplayMessage(replayMessage: null);
                            ///setState1(() {});
                          } else {
                            Message tempMessage = Message(
                                textMessage: str.toString(),
                                replayId: "",
                                typeMessage: "text",
                                senderId: profileProvider.user.id,
                                deleteUserMessage: [],
                                sendingTime: DateTime.now(),
                                checkSend: false);
                            list.add(SwipeTo(
                                onRightSwipe: () {
                                  print(str);

                                  ///value.replayMessage = str;
                                  foucsNode.requestFocus();
                                  chatProvider.changeReplayMessage(
                                      replayMessage: str);

                                  /// setState1(() {});
                                },
                                child: BuildMessageShape(
                                  //    isMe: false,
                                  message: tempMessage,

                                  child: Row(
                                    children: [
                                      Text(str.toString()),
                                    ],
                                  ),
                                )));
                          }
                          print("${tempMessage.toJson()}");

                          ///toDo هنا لا يختفي الرسالة حتا تتم ارسالها
                          ///في حال اردت التغير قم بوضع السطر الاول في الاخر
                          con.text = '';
                          chatProvider.replayIdMessage = "";
                          chatProvider.changeReplayMessage(replayMessage: null);
                          await value.addMessage(context,
                              idGroup: chatProvider.group.id,
                              message: tempMessage);
                          //chatProvider.replayIdMessage = "";
                          //chatProvider.changeReplayMessage(replayMessage: null);

                          ///  });
                        },
                        onRecordEnd: (path) {
                          ///  setState1(() {
                          list.add(Container(
                              margin: EdgeInsets.only(
                                  top: AppMargin.m4,
                                  bottom: AppMargin.m4,
                                  //TODO check audio List Sender
                                  left: Sizer.getW(context) / 2 - AppSize.s20),
                              child: SizedBox()
                              /*
                                        VoiceMessage(
                                          key: Key(path!),
                                          audioSrc: path,
                                          me: true,
                                        ),
                                        */
                              ));
                          chatProvider.changeReplayMessage(
                              replayMessage: chatProvider.replayMessage);

                          ///});
                        },
                        textPadding: EdgeInsets.zero,
                        leading: CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: const Icon(
                            Icons.insert_emoticon_outlined,
                            size: 25,
                            color: Colors.grey,
                          ),
                          onPressed: () {},
                        ),
                        actions: [
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            child: const Icon(
                              Icons.attach_file_rounded,
                              size: 25,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (_) => bottomSheet());
                            },
                          ),
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              size: 25,
                              color: Colors.grey,
                            ),
                            onPressed: () async {
                              ImagePickerPlus picker = ImagePickerPlus(context);
                              SelectedImagesDetails? details =
                                  await picker.pickBoth(
                                source: ImageSource.both,
                                multiSelection: false,
                                galleryDisplaySettings: GalleryDisplaySettings(
                                  tabsTexts: TabsTexts(
                                      videoText: tr(LocaleKeys.video),
                                      galleryText: tr(LocaleKeys.gallery),
                                      photoText: tr(LocaleKeys.camera),
                                      deletingText: tr(LocaleKeys.del)),
                                  appTheme: AppTheme(
                                      focusColor: Colors.white,
                                      primaryColor: Colors.black),
                                  showImagePreview: true,
                                  cropImage: true,
                                ),
                              );
                              if (details != null)
                                await displayDetails(details);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                )
                ///TODO وضع كونتنر لقد تم حظرك من هذا الغروب
                :Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: Sizer.getW(context) * 0.15,
                  color: Theme.of(context).cardColor,
                  child: Text(tr(LocaleKeys.have_ban),style: getRegularStyle(
                    color: Theme.of(context).textTheme.bodyText1!.color,
                    fontSize: Sizer.getW(context) / 30
                  ),),
                ),
                //     }),
              ))
        ],
      ),
    );
  }

  Future<void> displayDetails(SelectedImagesDetails details) async {
    if (details.isThatImage) {
      Message tempMessage = Message(
          textMessage: chatProvider.findbasename(details.selectedFile.path),
          url: "",
          replayId: chatProvider.replayIdMessage,
          typeMessage: "image",
          senderId: profileProvider.user.id,
          deleteUserMessage: [],
          sendingTime: DateTime.now(),
          checkSend: false);
      if (chatProvider.isReplay) {
        tempMessage.replayId = chatProvider.replayIdMessage;
      }
      list.add(InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (ctx) => Material(
                    color: Colors.black,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.file(
                          File(details.selectedFile.path),
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          top: AppSize.s10,
                          right: AppSize.s10,
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.close,
                                color: ColorManager.white,
                              )),
                        )
                      ],
                    ),
                  ));
        },
        child: BuildMessageShape(
            //  isMe: true,
            message: Message(
                textMessage: "",
                replayId: "",
                typeMessage: "",
                senderId: "",
                deleteUserMessage: [],
                sendingTime: DateTime.now()),
            child: DisplayImages(
                selectedFiles: details.selectedFiles != null
                    ? details.selectedFiles!
                    : [details.selectedFile],
                details: details,
                aspectRatio: details.aspectRatio)),
      ));

      ///add local message
      var tempMessageSemd = Message(
          textMessage: "",

          ///chatProvider.findbasename(details.selectedFile.path),
          url: "",
          replayId: "",

          ///chatProvider.replayIdMessage,
          typeMessage: "image",
          senderId: "",

          ///profileProvider.user.id,
          deleteUserMessage: [],
          sendingTime: DateTime.now(),
          checkSend: false);
      tempMessageSemd.url = details.selectedFile.path;
      listSendMessage.add(tempMessageSemd);
      setState3(() {});
      chatProvider.replayIdMessage = "";
      chatProvider.changeReplayMessage(replayMessage: null);

      String url = await chatProvider.uploadImage(details.selectedFile.path);
      tempMessage.url = url;
      print("${tempMessage.toJson()}");

      ///remove local message
      listSendMessage.remove(tempMessageSemd);
      await chatProvider.addMessage(context,
          idGroup: chatProvider.group.id, message: tempMessage);
      //chatProvider.notifyListeners();

      //setState1(() {});
    } else {
      // final video = await VideoThumbnail.thumbnailData(
      //   video: details.selectedFile.path,
      //   imageFormat: ImageFormat.JPEG,
      //   maxWidth: 128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
      //   quality: 25,
      // );
      // print("hhhhhh");
      // print(video);

      // list.add(BuildMessageShape(
      //     isMe: true, child: DisplayImages(
      //     selectedFiles: details.selectedFiles != null
      //         ? details.selectedFiles!
      //         : [details.selectedFile],
      //     details: details,
      //     aspectRatio: details.aspectRatio)));
      // Navigator.push(
      //     context,
      //     CupertinoDialogRoute(
      //         builder: (_) {
      //           return DisplayVideo(
      //               video: details.selectedFile,
      //               aspectRatio: details.aspectRatio);
      //         },
      //         context: context));
      // list.add(DisplayVideo(
      //     video: details.selectedFile, aspectRatio: details.aspectRatio));
      chatProvider.changeReplayMessage(
          replayMessage: chatProvider.replayMessage);
      //setState1(() {});
    }
  }

  Widget buildReplay() {
    return Container(
      height: Sizer.getW(context) * 0.25,
      decoration: BoxDecoration(color: Theme.of(context).cardColor),
      padding: EdgeInsets.all(AppPadding.p8),
      child: Container(
        padding: EdgeInsets.all(AppPadding.p4),
        decoration: BoxDecoration(
            color: ColorManager.lightGray.withOpacity(.2),
            borderRadius: BorderRadius.circular(AppSize.s8)),
        child: Stack(
          children: [
            Row(
              children: [
                VerticalDivider(
                  thickness: AppSize.s6,
                  color: Theme.of(context).primaryColor.withOpacity(.8),
                ),
                Flexible(child: buildrReplayText())
              ],
            ),
            Positioned(
              top: 0,
              left: context.locale == "en" ? null : 0,
              right: context.locale == "en" ? 0 : null,
              child: IconButton(
                  onPressed: () {
                    ///chatProvider.replayMessage = null;
                    chatProvider.replayIdMessage = "";
                    chatProvider.changeReplayMessage(replayMessage: null);

                    ///  setState(() {});
                  },
                  icon: Icon(Icons.close)),
            ),
          ],
        ),
      ),
    );
  }

/*
Stack(
      children: [
        Container(
          padding: EdgeInsets.all(AppPadding.p8),
          height: Sizer.getW(context) * 0.2,
          decoration: BoxDecoration(
            color: ColorManager.lightGray.withOpacity(.2),
            borderRadius:
            BorderRadius.vertical(top: Radius.circular(AppSize.s8)),
          ),
          child: Container(
            padding: EdgeInsets.all(AppPadding.p4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s4),
              color: ColorManager.lightGray.withOpacity(.5),
            ),
            child: Row(
              children: [
                VerticalDivider(
                  thickness: AppSize.s4,
                  color: Theme.of(context).primaryColor.withOpacity(.5),
                ),
                Flexible(child: buildrReplayText()
                  /** Text(
                      chatProvider.replayMessage!,
                      )**/
                )
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: context.locale == "en"?null:0,
          right: context.locale == "en"?0:null,
          child: IconButton(
              onPressed: () {
                ///chatProvider.replayMessage = null;
                chatProvider.replayIdMessage = "";
                chatProvider.changeReplayMessage(replayMessage: null);

                ///  setState(() {});
              },
              icon: Icon(Icons.close)),
        ),
      ],
    )
 */
  Widget bottomSheet() {
    return Container(
      height: Sizer.getW(context) * 0.55,
      width: Sizer.getW(context),
      margin: const EdgeInsets.all(AppMargin.m12),
      child: Card(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildItemBottomsheet(
                  icon: FontAwesomeIcons.file,
                  text: tr(LocaleKeys.documents),
                  onTap: () async {
                    Navigator.pop(context);
                    FilePickerResult? result = await FilePicker.platform
                        .pickFiles(allowMultiple: false);
                    if (result != null) {
                      Message tempMessage = Message(
                          textMessage: "",
                          url: "",
                          replayId: "",
                          typeMessage: "file",
                          senderId: profileProvider.user.id,
                          deleteUserMessage: [],
                          sendingTime: DateTime.now(),
                          checkSend: false);
                      if (chatProvider.isReplay) {
                        tempMessage.replayId = chatProvider.replayIdMessage;
                      }
                      list.add(Container(
                        margin: EdgeInsets.only(
                          top: AppMargin.m4,
                          bottom: AppMargin.m4,
                          // right: Sizer.getW(context) /2 -20.0,
                          left: Sizer.getW(context) / 2 - 20.0,
                        ),
                        color: Theme.of(context).primaryColor.withOpacity(.2),
                        padding: EdgeInsets.all(AppPadding.p8),
                        child: Container(
                          padding: EdgeInsets.all(AppPadding.p4),
                          decoration: BoxDecoration(
                              color: ColorManager.blackGray.withOpacity(.5),
                              borderRadius: BorderRadius.circular(AppSize.s8)),
                          child: Row(
                            children: [
                              CircleAvatar(
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.download))),
                              const SizedBox(
                                width: AppSize.s8,
                              ),
                              Flexible(child: Text(result.files[0].name)),
                            ],
                          ),
                        ),
                      ));
                      // Not sure if I should only get file path or complete data (this was in package documentation)
                      List<File> files =
                          result.paths.map((path) => File(path!)).toList();

                      chatProvider.replayIdMessage = "";
                      chatProvider.changeReplayMessage(replayMessage: null);
                      for (File file in files) {
                        String url = await chatProvider.uploadFile(file.path);
                        tempMessage.url = url;
                        tempMessage.textMessage =
                            chatProvider.findbasename(file.path);
                        print("${tempMessage.toJson()}");
                        await chatProvider.addMessage(context,
                            idGroup: chatProvider.group.id,
                            message: tempMessage);
                      }
                      //setState(() {});
                    } else {
                      // User canceled the picker
                    }
                  },
                  color: Colors.blueAccent),
              buildItemBottomsheet(
                  icon: FontAwesomeIcons.camera,
                  text: tr(LocaleKeys.camera),
                  onTap: () {},
                  color: Colors.pinkAccent),
              buildItemBottomsheet(
                  icon: Icons.photo,
                  text: tr(LocaleKeys.gallery),
                  onTap: () {},
                  color: Colors.purpleAccent),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildItemBottomsheet(
                  icon: Icons.audiotrack_sharp,
                  text: tr(LocaleKeys.audio),
                  onTap: () {
                    Const.TOAST(context, textToast: tr(LocaleKeys.no));
                  },
                  color: Colors.orange),
              buildItemBottomsheet(
                  icon: FontAwesomeIcons.locationDot,
                  text: tr(LocaleKeys.location),
                  onTap: () {
                    Const.TOAST(context, textToast: tr(LocaleKeys.no));
                  },
                  color: Colors.green),
              buildItemBottomsheet(
                  icon: Icons.person,
                  text: tr(LocaleKeys.contacts),
                  onTap: () {
                    Const.TOAST(context, textToast: tr(LocaleKeys.no));
                  },
                  color: Colors.blue),
            ],
          ),
        ],
      )),
    );
  }

  Widget buildItemBottomsheet({icon, text, color, onTap}) {
    return Expanded(
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: CircleAvatar(
              radius: AppSize.s26,
              child: Icon(
                icon,
                color: Colors.white,
              ),
              backgroundColor: color,
            ),
          ),
          Text(
            text,
            style: getRegularStyle(
                color: Theme.of(context).textTheme.bodyText1!.color),
          )
        ],
      ),
    );
  }

  Widget buildrReplayText() {
    switch (chatProvider.messageReplay.typeMessage) {
      case "text":
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              ("${(homeProvider.cacheUser.containsKey(chatProvider.messageReplay.senderId) ? homeProvider.cacheUser[chatProvider.messageReplay.senderId] : "")}"),
              style: getBoldStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color),
            ),
            Text(
              chatProvider.messageReplay.textMessage,
              overflow: TextOverflow.ellipsis,
            )
          ],
        );
      case "image":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              ("${(homeProvider.cacheUser.containsKey(chatProvider.messageReplay.senderId) ? homeProvider.cacheUser[chatProvider.messageReplay.senderId] : "")}"),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: Sizer.getW(context) * 0.02,
            ),
            Row(
              children: [
                CachedNetworkImage(
                  fit: BoxFit.fill,
                  width: Sizer.getW(context) * 0.1,
                  height: Sizer.getW(context) * 0.1,
                  imageUrl:
                      // "${AppUrl.baseUrlImage}${widget.restaurant.imageLogo!}",
                      ///"${chatProvider.replayMessage}",
                      "${chatProvider.messageReplay.url}",
                  // "${AppConstants.photoGroup}",
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        //    colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                      ),
                    ),
                  ),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => FlutterLogo(),
                ),
                SizedBox(
                  width: Sizer.getW(context) * 0.01,
                ),
                Text(
                  "photo",
                )
              ],
            ),
          ],
        );
      case "file":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              ("${(homeProvider.cacheUser.containsKey(chatProvider.messageReplay.senderId) ? homeProvider.cacheUser[chatProvider.messageReplay.senderId] : "")}"),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: Sizer.getW(context) * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "attatchment",
                ),
                SizedBox(
                  width: Sizer.getW(context) * 0.01,
                ),
                Icon(Icons.attach_file)
              ],
            ),
          ],
        );
    }
    return SizedBox();
  }

  Widget buildrReplayMessage({required Message message}) {
    Message messageReplay =
        chatProvider.findReplayMessage(repIdMessage: message.replayId);
    switch (messageReplay.typeMessage) {
      case "text":
        return Container(
          height: Sizer.getW(context) * 0.2,
          padding: EdgeInsets.all(AppPadding.p8),
          decoration: BoxDecoration(
            color: ColorManager.lightGray.withOpacity(.5),
            borderRadius: BorderRadius.circular(AppSize.s8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              VerticalDivider(
                thickness: AppSize.s4,
                color: Theme.of(context).primaryColor.withOpacity(.5),
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      ("${receiveReplayname(message: message)}"),
                      style: getBoldStyle(
                          color: ColorManager.blackGray),
                    ),
                    const SizedBox(
                      height: AppSize.s4,
                    ),
                    Text(
                      messageReplay.textMessage,
                      //"gjgjhghnghmjqhvsjvsjdhvjsvdjcvjsvdjcvsjcdvjsdhvjscvjdsvdscjvdcsjcdvsjdcsv",
                      overflow: TextOverflow.ellipsis,

                      ///"${messageReplay.url}",
                    )
                  ],
                ),
              )
            ],
          ),
        );
      case "image":
        return Container(
          height: Sizer.getW(context) * 0.25,
          padding: EdgeInsets.all(AppPadding.p8),
          decoration: BoxDecoration(
            color: ColorManager.lightGray.withOpacity(.5),
            borderRadius: BorderRadius.circular(AppSize.s8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              VerticalDivider(
                thickness: AppSize.s4,
                color: Theme.of(context).primaryColor.withOpacity(.5),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      ("${receiveReplayname(message: message)}"),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: Sizer.getW(context) * 0.02,
                    ),
                    Row(
                      children: [
                        CachedNetworkImage(
                          fit: BoxFit.fill,
                          width: Sizer.getW(context) * 0.1,
                          height: Sizer.getW(context) * 0.1,
                          imageUrl:
                              // "${AppUrl.baseUrlImage}${widget.restaurant.imageLogo!}",
                              // "${messageReplay.textMessage}",
                              "${messageReplay.url}",

                          /// "${AppConstants.photoGroup}",
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                                //    colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                              ),
                            ),
                          ),
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) => FlutterLogo(),
                        ),
                        SizedBox(
                          width: Sizer.getW(context) * 0.01,
                        ),
                        Text(
                          "photo",
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      case "file":
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ("${receiveReplayname(message: message)}"),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: Sizer.getW(context) * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "attatchment",
                    ),
                    SizedBox(
                      width: Sizer.getW(context) * 0.01,
                    ),
                    Icon(Icons.attach_file)
                  ],
                )
              ],
            ),
          ],
        );
    }
    return SizedBox();
  }

  ///function
  ///==================================================================
  convertListMessagesToListUsers(Chat chat) async {
    ///print("objectffffffffffffffffffffffffffffffffffff");
    chat.messages.forEach((message) async {
      if (!homeProvider.cacheUser.containsKey(message.senderId)) {
        await homeProvider.fetchNameUser(context, idUser: message.senderId);
        print(homeProvider.cacheUser);
      }
    });
  }

  convertListMessagesToListWidget(Chat chat) async {
    List<Widget> tempList = [];

    ///print("objectffffffffffffffffffffffffffffffffffff");
    chat.messages.forEach((message) async {
      // print(homeProvider.cacheUser);
      //  if(!message.deleteUserMessage.contains(profileProvider.user.id)){
      tempList.add(receiveMessage(message: message));
      //}
    });
    list = [];
    list.addAll(tempList);
  }

  convertListSendMessagesToListWidget(List messages) async {
    List<Widget> tempList = [];
    messages.forEach((message) async {
      // print(homeProvider.cacheUser);
      //  if(!message.deleteUserMessage.contains(profileProvider.user.id)){
      tempList.add(receiveMessage(message: message));
      //}
    });
    list.addAll(tempList);
  }

  ///==================================================================
  receiveReplay({required Message message}) {
    String textReplay = "delete_message";
    for (Message element in chatProvider.group.chat.messages) {
      if (element.id.contains(message.replayId)) {
        switch (message.typeMessage) {
          case "text":
            textReplay = element.textMessage;
            break;
          case "video":
            textReplay = element.textMessage;
            break;
          case "image":
            textReplay = element.textMessage;
            break;
          case "audio":
            textReplay = "replay_audio";
            break;
          case "file":
            textReplay = "replay_file";
        }
      }
    }
    return textReplay;
  }

  receiveReplayname({required Message message}) {
    String name = "";
    for (Message element in chatProvider.group.chat.messages) {
      if (element.id.contains(message.replayId)) {
        if (homeProvider.cacheUser.containsKey(element.senderId)) {
          name = homeProvider.cacheUser[element.senderId];
        }
      }
    }
    return name;
  }

  receiveMessage({required Message message}) {
    /// print("type  ${message.textMessage} ${message.typeMessage}");
    switch (message.typeMessage) {
      case "text":
        return receiveText(
            isReplay: (message.replayId == "") ? false : true,
            message: message);
      case "image":
        // print("type  ${message.textMessage} ${message.typeMessage}");
        return receiveImage(
            isReplay: (message.replayId == "") ? false : true,
            message: message);
      case "file":
        // print("type  ${message.textMessage} ${message.typeMessage}");
        return receiveFile(
            isReplay: (message.replayId == "") ? false : true,
            message: message);
    }
  }

  Widget receiveText({required bool isReplay, required Message message}) {
    Widget childWidget;
    String replaytext = receiveReplay(message: message);
    if (isReplay) {
      childWidget = SwipeTo(
          onRightSwipe: () {
            print("replay : ${message.id} ${message.textMessage}");
            chatProvider.replayIdMessage = message.id;
            chatProvider.getReplayMessage();
            chatProvider.changeReplayMessageId(
                replayMessage: message.textMessage,
                replayIdMessage: message.id);
            foucsNode.requestFocus();

            /// setState(() {});
          },
          child: BuildMessageShape(
            //  isMe: true,
            message: message,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildrReplayMessage(message: message),
                Text(message.textMessage)
              ],
            ),
          ));

      ///setState(() {});
    } else
      //list.add(
      childWidget = SwipeTo(
          onRightSwipe: () {
            print("replay : ${message.id} ${message.textMessage}");

            ///  chatProvider.replayMessage = message.textMessage;
            chatProvider.replayIdMessage = message.id;
            chatProvider.getReplayMessage();
            chatProvider.changeReplayMessage(
                replayMessage: message.textMessage);
            foucsNode.requestFocus();
            // setState(() {});
            //  chatProvider.notifyListeners();
          },
          child: BuildMessageShape(
            //isMe: false,
            message: message,
            child: Text(message.textMessage),
          ));
    //  );
    return childWidget;
  }

  Widget receiveImage({required bool isReplay, required Message message}) {
    Widget childWidget;
    String replaytext = receiveReplay(message: message);
    if (isReplay) {
      childWidget = SwipeTo(
          onRightSwipe: () {
            print("replay : ${message.id} ${message.textMessage}");
            chatProvider.replayIdMessage = message.id;
            chatProvider.getReplayMessage();
            chatProvider.changeReplayMessageId(
                replayMessage: message.textMessage,
                replayIdMessage: message.id);
            foucsNode.requestFocus();

            /// setState(() {});
          },
          child: BuildMessageShape(
            //  isMe: true,
            message: message,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildrReplayMessage(message: message),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    width: widthImageChat,
                    //Sizer.getW(context) * 0.25,
                    height: widthImageChat,
                    //Sizer.getW(context) * 0.25,
                    imageUrl:
                        // "${AppUrl.baseUrlImage}${widget.restaurant.imageLogo!}",
                        /// "${replaytext}",
                        /// "${message.textMessage}",
                        "${message.url}",
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                          //    colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                        ),
                      ),
                    ),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => FlutterLogo(),
                  ),
                  //Text(message.textMessage),
                  //  child: Text(con.text),
                )
              ],
            ),
          ));

      ///setState(() {});
    } else
      //list.add(
      childWidget = SwipeTo(
          onRightSwipe: () {
            print("replay : ${message.id} ${message.textMessage}");

            ///  chatProvider.replayMessage = message.textMessage;
            chatProvider.replayIdMessage = message.id;
            chatProvider.getReplayMessage();
            chatProvider.changeReplayMessage(
                replayMessage: message.textMessage);
            foucsNode.requestFocus();
            // setState(() {});
            //  chatProvider.notifyListeners();
          },
          child: BuildMessageShape(
            //isMe: false,
            message: message,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  fit: BoxFit.fill,
                  width: widthImageChat,
                  //Sizer.getW(context) * 0.25,
                  height: widthImageChat,
                  //Sizer.getW(context) * 0.25,
                  imageUrl:
                      // "${AppUrl.baseUrlImage}${widget.restaurant.imageLogo!}",
                      /// "${replaytext}",
                      ///"${message.textMessage}",
                      "${message.url}",
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        //    colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                      ),
                    ),
                  ),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => FlutterLogo(),
                ),
                //Text("str".toString()),
                //Text(message.textMessage),
              ],
            ),
          ));
    //  );
    return childWidget;
  }

  Widget receiveFile({required bool isReplay, required Message message}) {
    Widget childWidget;
    String replaytext = receiveReplay(message: message);
    if (isReplay) {
      childWidget = SwipeTo(
          onRightSwipe: () {
            print("replay : ${message.id} ${message.textMessage}");
            chatProvider.replayIdMessage = message.id;
            chatProvider.getReplayMessage();
            chatProvider.changeReplayMessageId(
                replayMessage: message.textMessage,
                replayIdMessage: message.id);
            foucsNode.requestFocus();

            /// setState(() {});
          },
          child: BuildMessageShape(
            //  isMe: true,
            message: message,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildrReplayMessage(message: message),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                          child: IconButton(
                              onPressed: () {
                                OpenFile.open("${message.url}");
                              },
                              icon: Icon(Icons.download))),
                      const SizedBox(
                        width: AppSize.s8,
                      ),
                      Flexible(
                          child: Text(
                              "${message.textMessage}" /*result.files[0].name*/)),
                    ],
                  ),
                  //Text(message.textMessage),
                  //  child: Text(con.text),
                )
              ],
            ),
          ));

      ///setState(() {});
    } else
      //list.add(
      childWidget = SwipeTo(
          onRightSwipe: () {
            print("replay : ${message.id} ${message.textMessage}");

            ///  chatProvider.replayMessage = message.textMessage;
            chatProvider.replayIdMessage = message.id;
            chatProvider.getReplayMessage();
            chatProvider.changeReplayMessage(
                replayMessage: message.textMessage);
            foucsNode.requestFocus();
            // setState(() {});
            //  chatProvider.notifyListeners();
          },
          child: BuildMessageShape(
            //isMe: false,
            message: message,
            child: Row(
              children: [
                CircleAvatar(
                    child: IconButton(
                        onPressed: () {
                          OpenFile.open("${message.url}");
                        },
                        icon: Icon(Icons.download))),
                const SizedBox(
                  width: AppSize.s8,
                ),
                Flexible(
                    child: Text(
                        "${message.textMessage}" /*result.files[0].name*/)),
              ],
            ),
          ));
    //  );
    return childWidget;
  }
}

class DisplayImages extends StatelessWidget {
  final List<File> selectedFiles;
  final double aspectRatio;
  final SelectedImagesDetails details;

  const DisplayImages({
    Key? key,
    required this.details,
    required this.selectedFiles,
    required this.aspectRatio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.file(
      selectedFiles.first,
    );
  }
}

class DisplayVideo extends StatefulWidget {
  final File video;
  final double aspectRatio;

  const DisplayVideo({
    Key? key,
    required this.video,
    required this.aspectRatio,
  }) : super(key: key);

  @override
  State<DisplayVideo> createState() => _DisplayVideoState();
}

class _DisplayVideoState extends State<DisplayVideo> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.video);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Video')),
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}

class BuildMessageShape extends StatelessWidget {
  // final bool isMe;
  final Widget child;
  final model.Message message;

  const BuildMessageShape(
      {super.key, required this.child, required this.message});

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);
    final homeProvider = Provider.of<HomeProvider>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);
    final isMe = (message.senderId.contains(profileProvider.user.id));
    //print(homeProvider.cacheUser);
    return InkWell(
      onLongPress: () async {
        (!chatProvider.checkBlockUserInGroup(idUser: profileProvider.user.id))?
        Get.defaultDialog(
          titleStyle: getBoldStyle(
              color: Theme.of(context).textTheme.bodyText1!.color,
              fontSize: Sizer.getW(context) / 22),
          content: Column(
            children: [
              TextButton(
                  style: TextButton.styleFrom(
                      minimumSize: Size(double.infinity, 80)),
                  onPressed: () {},
                  child: Text(
                    tr(LocaleKeys.dle_for_me),
                    style: getRegularStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color,
                        fontSize: Sizer.getW(context) / 24),
                  )),
              TextButton(
                  style: TextButton.styleFrom(
                      minimumSize: Size(double.infinity, 80)),
                  onPressed: () async {
                    await chatProvider.deleteMessage(context,
                        message: message, idUser: profileProvider.user.id);
                  },
                  child: Text(
                    tr(LocaleKeys.dle_for_all),
                    style: getRegularStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color,
                        fontSize: Sizer.getW(context) / 24),
                  )),
            ],
          ),
          title: tr(LocaleKeys.are_you_sure),
          radius: AppSize.s14,
        )
        :SizedBox();

        ///TODO add SHOWDELETEDIALOOG

        // print("object"),
        //  Const.SHOWDELETEDIALOOG(context),
      },
      child: Container(
        padding: EdgeInsets.only(
          top: AppPadding.p4,
          left: AppPadding.p8,
          right: AppPadding.p8,
          bottom: AppPadding.p4,
        ),
        margin: EdgeInsets.only(
          top: AppMargin.m4,
          bottom: AppMargin.m4,
          right: isMe ? 0 : Sizer.getW(context) / 2 - AppSize.s20,
          left: isMe ? Sizer.getW(context) / 2 - AppSize.s20 : 0,
        ),
        decoration: BoxDecoration(
            // color: Theme.of(context).primaryColor.withOpacity(isMe ? 0.2 : 0.8),
            color: isMe ? Color(0xffdffec5) : Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSize.s10),
              topRight: Radius.circular(AppSize.s10),
              bottomLeft: isMe ? Radius.circular(AppSize.s10) : Radius.zero,
              bottomRight: isMe ? Radius.zero : Radius.circular(AppSize.s10),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            (homeProvider.cacheUser.containsKey(message.senderId))
                ? Text(
                    "${homeProvider.cacheUser[message.senderId]}",
                    style: getRegularStyle(
                      color: ColorManager.black,
                      fontSize: Sizer.getW(context) / 30
                    ),
                    //TODO
                    // textAlign: TextAlign.left,
                  )
                : FutureBuilder(
                    future: HomeProvider().fetchNameUser(context,
                        idUser: message
                            .senderId //chatProvider.group.listUsers[index]
                        ),
                    builder: (
                      context,
                      snapshot,
                    ) {
                      print(snapshot.error);
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text(
                            "${FirebaseFun.findTextToast("جاري التحميل ..")}"); // Expanded(child: Const.SHOWLOADINGINDECATOR());
                        //Const.CIRCLE(context);
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasError) {
                          return const Text('Error');
                        } else if (snapshot.hasData) {
                          // Map<String,dynamic> data=snapshot.data as Map<String,dynamic>;
                          //homeProvider.sessions=Sessions.fromJson(data['body']);
                          return Row(
                            children: [
                              Text("${snapshot.data}"),
                              /*SizedBox(width: Sizer.getW(context)*0.01,),
                      (typeUser.contains(AppConstants.collectionPatient))?
                      SizedBox():
                      Icon(Icons.star),
                      (!checkblock)?
                      SizedBox():
                      Icon(Icons.block),*/
                            ],
                          );
                        } else {
                          return const Text('Empty data');
                        }
                      } else {
                        return Text('State: ${snapshot.connectionState}');
                      }
                    },
                  ),
            child,
            const SizedBox(
              height: AppSize.s8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(horizontal: AppSize.s4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: Colors.green[100]),
                    child:
                        //   Text("${DateFormat().add_jm().format(DateTime.now())}")),
                        Text(
                      "${DateFormat().add_jm().format(message.sendingTime)}",
                      style: getRegularStyle(
                          color: Theme.of(context).textTheme.bodyText1!.color,
                          fontSize: AppSize.s10),
                    )),
                (isMe)
                    ? ((message.checkSend)
                            ? Icon(Icons.check,
                                size: AppSize.s14)
                            : SizedBox()
                        /**
                        FutureBuilder(
                        future: chatProvider.addMessage(context,
                        idGroup: chatProvider.group.id,
                        message: message),
                        builder: (
                        context,
                        snapshot,
                        ) {
                        print(snapshot.error);
                        if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                        return Icon(Icons
                        .check_circle_outline,
                        size: AppSize.s1_5,
                        ); // Expanded(child: Const.SHOWLOADINGINDECATOR());
                        //Const.CIRCLE(context);
                        } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                        if (snapshot.hasError) {
                        return Icon(Icons.error_outline);
                        } else if (snapshot.hasData) {
                        // Map<String,dynamic> data=snapshot.data as Map<String,dynamic>;
                        //homeProvider.sessions=Sessions.fromJson(data['body']);
                        return Icon(Icons.check_circle_outline);
                        } else {
                        return Icon(Icons.error_outline);
                        }
                        } else {
                        return Icon(Icons.error_outline);
                        }
                        },
                        )
                     **/
                        )
                    : SizedBox(),
                // Icon(Icons.check_circle_outline),
              ],
            )
          ],
        ),
      ),
    );
  }
}
