import 'dart:developer';
import 'dart:io';
import 'package:chat_composer/chat_composer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
import '../../../controller/utils/chat_provider.dart';
import '../../../model/models.dart';
import '../../resources/color_manager.dart';
import 'dart:ui' as ui;
import 'package:provider/provider.dart';
import '../../resources/consts_manager.dart';
import '../list_of_member/list_of_member_view.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  List<Widget> list = [];
  TextEditingController con = TextEditingController();
  final foucsNode = FocusNode();
  String? replayMessage;

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final groupsProvider = Provider.of<GroupsProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context);
    bool isReplay = replayMessage != null;
    return Directionality(
      textDirection: ui.TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 1,
          title: ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => ListOfMemberView(
                    users: [
                      User(
                          id: "id",
                          uid: "uid",
                          name: "Kholod",
                          email: "Kholod@gmail.com",
                          phoneNumber: "0522325465",
                          password: "password",
                          typeUser: "typeUser",
                          photoUrl: "photoUrl"
                      )
                    ],
                  )));
            },
            leading: CircleAvatar(
              radius: AppSize.s24,
            ),
            title: Text(tr(LocaleKeys.anxiety_patients)),
            subtitle: Text("35 Member"),
            trailing: IconButton(onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => ListOfMemberView(
                    users: [
                      User(
                          id: "id",
                          uid: "uid",
                          name: "Kholod",
                          email: "Kholod@gmail.com",
                          phoneNumber: "0522325465",
                          password: "password",
                          typeUser: "typeUser",
                          photoUrl: "photoUrl"
                      )
                    ],
                  )));
            }, icon: Icon(Icons.more_vert)),
          ),
        ),
        body:
        /**
        StreamBuilder<QuerySnapshot>( //prints the messages to the screen0
          stream: FirebaseFirestore.instance.collection(AppConstants.collectionGroup)
              .doc("taoId1xj5dSDNEoaYlFd")
              .collection(AppConstants.collectionChat)
              .orderBy("sendingTime")
              .snapshots(),
          builder: (context,snapshot){
            // List<messageLine> messageWidgets=[];// all the messages saved here
            if (!snapshot.hasData) { //is there data(messages) or not
              //////////add spinner 1:48
            }
            final messages=snapshot.data!.docs.reversed;
            for (var message in messages) { //print each message
              //final messageText = message.get('text'); //get the text
              //final messageSender = message.get('sender');//  the sender email
              /* final currentUser= signedInUser.email; //the user currently signed in email
                    final messageWidget =
                    messageLine(sender:messageSender,
                      text:messageText,
                      isMe: messageSender==currentUser,
                    );
                    messageWidgets.add(messageWidget);*/
            }
            return Column(
              children: [
                Expanded(
                  child:


                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(.2), BlendMode.darken),
                            image: AssetImage(ImagesAssets.backgroundChat))),
                    child: ListView.builder(
                        padding: EdgeInsets.all(
                          AppPadding.p10,
                        ),
                        itemCount: list.length,
                        itemBuilder: (_, pos) {
                          return list[pos];
                          // return ListTile(title: Text(list[pos]));
                        }),
                  ),
                ),

                Column(
                  children: [
                    if (isReplay) buildReplay(),
                    ChatComposer(
                      backgroundColor: Colors.green,
                      borderRadius: isReplay
                          ? BorderRadius.vertical(
                          bottom: Radius.circular(AppSize.s8))
                          : BorderRadius.circular(AppSize.s8),
                      padding: EdgeInsets.only(
                        top: 0.0,
                        bottom: AppPadding.p10,
                        left: AppPadding.p10,
                        right: AppPadding.p10,
                      ),
                      focusNode: foucsNode,
                      textFieldDecoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      textStyle: getRegularStyle(
                          color: Theme
                              .of(context)
                              .textTheme
                              .bodyText1!
                              .color,
                          fontSize: Sizer.getW(context) / 30),
                      controller: con,
                      onReceiveText: (str) {
                        setState(() {
                          if (isReplay) {
                            list.add(SwipeTo(
                                onRightSwipe: () {
                                  print(str);
                                  replayMessage = str;
                                  foucsNode.requestFocus();
                                  setState(() {});
                                },
                                child: BuildMessageShape(
                                  isMe: true,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                              color: Theme
                                                  .of(context)
                                                  .primaryColor
                                                  .withOpacity(.5),
                                            ),
                                            Flexible(
                                                child: Text(
                                                  replayMessage!,
                                                ))
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
                            replayMessage = null;
                            setState(() {});
                          } else
                            list.add(SwipeTo(
                                onRightSwipe: () {
                                  print(str);
                                  replayMessage = str;
                                  foucsNode.requestFocus();
                                  setState(() {});
                                },
                                child: BuildMessageShape(
                                  isMe: false,
                                  child: Row(
                                    children: [
                                      Text(str.toString()),
                                    ],
                                  ),
                                )));
                          con.text = '';
                        });
                      },
                      onRecordEnd: (path) {
                        setState(() {
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
                        });
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
                            SelectedImagesDetails? details = await picker.pickBoth(
                              source: ImageSource.both,
                              multiSelection: false,
                              galleryDisplaySettings: GalleryDisplaySettings(
                                tabsTexts: TabsTexts(
                                    videoText: tr(LocaleKeys.video),
                                    galleryText: tr(LocaleKeys.gallery),
                                    photoText: tr(LocaleKeys.camera),
                                    deletingText: tr(LocaleKeys.delete)),
                                appTheme: AppTheme(
                                    focusColor: Colors.white,
                                    primaryColor: Colors.black),
                                showImagePreview: true,
                                cropImage: true,
                              ),

                            );
                            if (details != null) await displayDetails(details);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          },

        ),
        **/
        Column(
          children: [
            Expanded(
              child:


               Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(.2), BlendMode.darken),
                        image: AssetImage(ImagesAssets.backgroundChat))),
                child: ListView.builder(
                    padding: EdgeInsets.all(
                      AppPadding.p10,
                    ),
                    itemCount: list.length,
                    itemBuilder: (_, pos) {
                      return list[pos];
                      // return ListTile(title: Text(list[pos]));
                    }),
              ),
            ),

            Column(
              children: [
                if (isReplay) buildReplay(),
                ChatComposer(
                  backgroundColor: Colors.green,
                  borderRadius: isReplay
                      ? BorderRadius.vertical(
                      bottom: Radius.circular(AppSize.s8))
                      : BorderRadius.circular(AppSize.s8),
                  padding: EdgeInsets.only(
                    top: 0.0,
                    bottom: AppPadding.p10,
                    left: AppPadding.p10,
                    right: AppPadding.p10,
                  ),
                  focusNode: foucsNode,
                  textFieldDecoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  textStyle: getRegularStyle(
                      color: Theme
                          .of(context)
                          .textTheme
                          .bodyText1!
                          .color,
                      fontSize: Sizer.getW(context) / 30),
                  controller: con,
                  onReceiveText: (str) {
                    setState(() {
                      if (isReplay) {
                        list.add(SwipeTo(
                            onRightSwipe: () {
                              print(str);
                              replayMessage = str;
                              foucsNode.requestFocus();
                              setState(() {});
                            },
                            child: BuildMessageShape(
                              isMe: true,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                          color: Theme
                                              .of(context)
                                              .primaryColor
                                              .withOpacity(.5),
                                        ),
                                        Flexible(
                                            child: Text(
                                              replayMessage!,
                                            ))
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
                        replayMessage = null;
                        setState(() {});
                      } else
                        list.add(SwipeTo(
                            onRightSwipe: () {
                              print(str);
                              replayMessage = str;
                              foucsNode.requestFocus();
                              setState(() {});
                            },
                            child: BuildMessageShape(
                              isMe: false,
                              child: Row(
                                children: [
                                  Text(str.toString()),
                                ],
                              ),
                            )));
                      con.text = '';
                    });
                  },
                  onRecordEnd: (path) {
                    setState(() {
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
                    });
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
                        SelectedImagesDetails? details = await picker.pickBoth(
                          source: ImageSource.both,
                          multiSelection: false,
                          galleryDisplaySettings: GalleryDisplaySettings(
                            tabsTexts: TabsTexts(
                                videoText: tr(LocaleKeys.video),
                                galleryText: tr(LocaleKeys.gallery),
                                photoText: tr(LocaleKeys.camera),
                                deletingText: tr(LocaleKeys.delete)),
                            appTheme: AppTheme(
                                focusColor: Colors.white,
                                primaryColor: Colors.black),
                            showImagePreview: true,
                            cropImage: true,
                          ),

                        );
                        if (details != null) await displayDetails(details);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Future<void> displayDetails(SelectedImagesDetails details) async {
    if (details.isThatImage) {
      list.add(InkWell(
        onTap: () {
          showDialog(
              context: context, builder: (ctx) =>
              Material(
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
                      child: IconButton(onPressed: () {
                        Navigator.pop(context);
                      }, icon: Icon(Icons.close, color: ColorManager.white,)),
                    )
                  ],
                ),
              ));
        },
        child:

        BuildMessageShape(
            isMe: true, child: DisplayImages(
            selectedFiles: details.selectedFiles != null
                ? details.selectedFiles!
                : [details.selectedFile],
            details: details,
            aspectRatio: details.aspectRatio)),
      ));
      setState(() {});
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
      setState(() {});
    }
  }

  Widget buildReplay() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppMargin.m10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: Sizer.getW(context) - 79,
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
                        color: Theme
                            .of(context)
                            .primaryColor
                            .withOpacity(.5),
                      ),
                      Flexible(
                          child: Text(
                            replayMessage!,
                          ))
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                    onPressed: () {
                      replayMessage = null;
                      setState(() {});
                    },
                    icon: Icon(Icons.close)),
              ),
            ],
          )
        ],
      ),
    );
  }

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
                          list.add(Container(
                            margin: EdgeInsets.only(
                              top: AppMargin.m4,
                              bottom: AppMargin.m4,
                              // right: Sizer.getW(context) /2 -20.0,
                              left: Sizer.getW(context) / 2 - 20.0,
                            ),
                            color: Theme
                                .of(context)
                                .primaryColor
                                .withOpacity(.2),
                            padding: EdgeInsets.all(AppPadding.p8),
                            child: Container(
                              padding: EdgeInsets.all(AppPadding.p4),
                              decoration: BoxDecoration(
                                  color: ColorManager.blackGray.withOpacity(.5),
                                  borderRadius: BorderRadius.circular(
                                      AppSize.s8)),
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
                          setState(() {});
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
                color: Theme
                    .of(context)
                    .textTheme
                    .bodyText1!
                    .color),
          )
        ],
      ),
    );
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
  final bool isMe;
  final Widget child;

  const BuildMessageShape({super.key, required this.isMe, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: AppPadding.p12,
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
        children: [
          child, const SizedBox(height: AppSize.s8,),
          Row(
            children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: AppSize.s4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: Colors.green[100]),
                  child:
                  Text("${DateFormat().add_jm().format(DateTime.now())}")),
            ],
          )
        ],
      ),
    );
  }
}
