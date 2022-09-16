import 'dart:developer';
import 'dart:io';
import 'package:chat_composer/chat_composer.dart';
import 'package:ehtooa/app/model/utils/const.dart';
import 'package:ehtooa/app/model/utils/sizer.dart';
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
import '../../resources/color_manager.dart';
import 'dart:ui' as ui;
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
    bool isReplay = replayMessage !=null;
    return Directionality(
      textDirection: ui.TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Chat Composer'),
        ),
        body: Column(
          children: [
            Expanded(
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
            Column(
              children: [
                if(isReplay) buildReplay(),
                ChatComposer(
                  borderRadius: isReplay
                      ? BorderRadius.vertical(bottom: Radius.circular(AppSize.s8))
                      :BorderRadius.circular(AppSize.s8),
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
                  textStyle: getRegularStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontSize: Sizer.getW(context)/30),
                  controller: con,
                  onReceiveText: (str) {
                    setState(() {
                      if(isReplay)
                      {
                        list.add(SwipeTo(
                          onRightSwipe: (){
                            print(str);
                            replayMessage = str;
                            foucsNode.requestFocus();
                            setState(() {

                            });
                          },
                          child: Container(
                              margin: EdgeInsets.only(
                                top: AppMargin.m4,
                                bottom: AppMargin.m4,
                                // right: Sizer.getW(context) /2 -20.0,
                                left: Sizer.getW(context) /2 -20.0,
                              ),
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor.withOpacity(.2),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(AppSize.s12),
                                    topRight: Radius.circular(AppSize.s12),
                                    //ToDo check is ursender
                                    bottomLeft: Radius.circular(AppSize.s12),
                                    // bottomRight: Radius.circular(AppSize.s50),
                                  )
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: Sizer.getW(context) * 0.15,
                                    padding: EdgeInsets.all(AppPadding.p8),
                                    decoration: BoxDecoration(
                                      color: ColorManager.lightGray.withOpacity(.5),
                                      borderRadius: BorderRadius.circular( AppSize.s8),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        VerticalDivider(
                                          thickness: AppSize.s4,
                                          color: Theme.of(context).primaryColor.withOpacity(.5),
                                        ),
                                        Text(replayMessage!)
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(con.text),
                                  )
                                ],
                              )),
                        ));
                      }else
                        list.add(SwipeTo(
                          onRightSwipe: (){
                            print(str);
                            replayMessage = str;
                            foucsNode.requestFocus();
                            setState(() {

                            });
                          },
                          child: Container(
                              margin: EdgeInsets.only(
                                top: AppMargin.m4,
                                bottom: AppMargin.m4,
                                // right: Sizer.getW(context) /2 -20.0,
                                left: Sizer.getW(context) /2 -20.0,
                              ),
                              padding: EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor.withOpacity(.2),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(AppSize.s50),
                                    topRight: Radius.circular(AppSize.s50),
                                    //ToDo check is ursender
                                    bottomLeft: Radius.circular(50),
                                    // bottomRight: Radius.circular(AppSize.s50),
                                  )
                              ),
                              child: Text("${str}")),
                        ));
                      // list.add('TEXT : ${str!}');
                      con.text = '';
                    });
                  },
                  onRecordEnd: (path) {
                    setState(() {
                      list.add(Container(
                        margin: EdgeInsets.only(
                            left: Sizer.getW(context) / 2 - 20.0
                        ),
                        child: VoiceMessage(
                          audioSrc: path!,
                          me: false,
                        ),
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
                            appTheme:
                            AppTheme(focusColor: Colors.white, primaryColor: Colors.black),
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
      list.add(Container(
          margin: EdgeInsets.only(
            top: AppMargin.m4,
            bottom: AppMargin.m4,
            // right: Sizer.getW(context) /2 -20.0,
            left: Sizer.getW(context) /2 -20.0,
          ),
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(.2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppSize.s50),
                topRight: Radius.circular(AppSize.s50),
                //ToDo check is ursender
                bottomLeft: Radius.circular(50),
                // bottomRight: Radius.circular(AppSize.s50),
              )
          ),
          child: DisplayImages(
              selectedFiles: details.selectedFiles != null
                  ? details.selectedFiles!
                  : [details.selectedFile],
              details: details,
              aspectRatio: details.aspectRatio)));
      setState(() {

      });
    }
    else{
      Navigator.push(context, CupertinoDialogRoute(builder: (_){
        return DisplayVideo(
            video: details.selectedFile, aspectRatio: details.aspectRatio);
      }, context: context));
      // list.add(DisplayVideo(
      //     video: details.selectedFile, aspectRatio: details.aspectRatio));
      setState(() {

      });
    }
  }

  Widget buildReplay(){
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: AppMargin.m10
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: Sizer.getW(context) - 79,
                padding: EdgeInsets.all(AppPadding.p8),
                height: Sizer.getW(context)*0.2,
                decoration: BoxDecoration(
                  color: ColorManager.lightGray.withOpacity(.2),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(AppSize.s8)),
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
                      Text(replayMessage!)
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(onPressed: (){
                  replayMessage = null;
                  setState(() {

                  });
                }, icon: Icon(Icons.close)),
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
                  buildItemBottomsheet(icon: FontAwesomeIcons.file,
                      text: tr(LocaleKeys.documents), onTap: ()async {
                        Navigator.pop(context);
                        FilePickerResult? result = await FilePicker.platform.pickFiles(
                            allowMultiple: false
                        );
                        if(result != null) {
                          list.add(
                              Container(
                                margin: EdgeInsets.only(
                                  top: AppMargin.m4,
                                  bottom: AppMargin.m4,
                                  // right: Sizer.getW(context) /2 -20.0,
                                  left: Sizer.getW(context) /2 -20.0,
                                ),
                                color: Theme.of(context).primaryColor.withOpacity(.2),

                                padding: EdgeInsets.all(AppPadding.p8),
                                child: Container(
                                  padding: EdgeInsets.all(AppPadding.p4),
                                  decoration: BoxDecoration(
                                      color: ColorManager.blackGray.withOpacity(.5),
                                      borderRadius: BorderRadius.circular(AppSize.s8)
                                  ),
                                  child: Row(
                                    children: [
                                      CircleAvatar(child: IconButton(onPressed: (){}, icon: Icon(Icons.download))),
                                      const SizedBox(width: AppSize.s8,),
                                      Flexible(
                                          child: Text(
                                              result.files[0].name)),

                                    ],
                                  ),
                                ),
                              )
                          );
                          // Not sure if I should only get file path or complete data (this was in package documentation)
                          List<File> files = result.paths.map((path) => File(path!)).toList();
                          setState(() {

                          });
                        } else {
                          // User canceled the picker
                        }}, color: Colors.blueAccent),
                  buildItemBottomsheet(icon: FontAwesomeIcons.camera, text: tr(LocaleKeys.camera), onTap: () {
                  }, color: Colors.pinkAccent),
                  buildItemBottomsheet(icon: Icons.photo, text: tr(LocaleKeys.gallery), onTap: () {}, color: Colors.purpleAccent),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildItemBottomsheet(icon: Icons.audiotrack_sharp, text: tr(LocaleKeys.audio), onTap: () {
                    Const.TOAST(context,textToast: tr(LocaleKeys.no));
                  }, color: Colors.orange),
                  buildItemBottomsheet(icon: FontAwesomeIcons.locationDot, text: tr(LocaleKeys.location), onTap: () {

                    Const.TOAST(context,textToast: tr(LocaleKeys.no));

                  }, color: Colors.green),
                  buildItemBottomsheet(icon: Icons.person, text: tr(LocaleKeys.contacts), onTap: () {
                    Const.TOAST(context,textToast: tr(LocaleKeys.no));
                  }, color: Colors.blue),
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
    return  Image.file(selectedFiles.first)
    ;
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