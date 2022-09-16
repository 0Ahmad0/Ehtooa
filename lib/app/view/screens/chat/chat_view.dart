// // import 'package:ehtooa/app/view/resources/audio_list.dart';
// // import 'package:ehtooa/app/view/resources/audio_state.dart';
// // import 'package:ehtooa/app/view/resources/color_manager.dart';
// // import 'package:ehtooa/app/view/resources/values_manager.dart';
// // import 'package:ehtooa/translations/locale_keys.g.dart';
// // import 'package:flutter/material.dart';
// // import 'package:easy_localization/easy_localization.dart';
// //
// // import '../../resources/assets_manager.dart';
// // import '../../resources/globals.dart';
// // import '../../widgets/chat_box.dart';
// // import '../../widgets/record_button.dart';
// //
// // class ChatView extends StatefulWidget {
// //   const ChatView({Key? key}) : super(key: key);
// //
// //   @override
// //   _ChatViewState createState() => _ChatViewState();
// // }
// //
// // class _ChatViewState extends State<ChatView>
// //     with SingleTickerProviderStateMixin {
// //   late AnimationController controller;
// //   final textMessage = TextEditingController();
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     controller = AnimationController(
// //       vsync: this,
// //       duration: const Duration(milliseconds: 600),
// //     );
// //   }
// //
// //   @override
// //   void dispose() {
// //     controller.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //         appBar: AppBar(
// //           elevation: 0.0,
// //           title: Text(tr(LocaleKeys.groups)),
// //         ),
// //         body: Container(
// //           padding: const EdgeInsets.all(Globals.defaultPadding),
// //           width: double.infinity,
// //           height: double.infinity,
// //           decoration: BoxDecoration(
// //             image: DecorationImage(
// //               image: AssetImage(ImagesAssets.backgroundChat),
// //               fit: BoxFit.cover
// //             ),
// //           ),
// //           child: Column(
// //             children: [
// //               Expanded(child: ChatList()),
// //               StatefulBuilder(
// //                 builder: (_,setStat1){
// //                   return  Row(
// //                     mainAxisSize: MainAxisSize.max,
// //                     children: [
// //                       ChatBox(
// //                         controller: controller,
// //                         text: textMessage,
// //                         onChanged: (val){
// //                           setStat1(() {
// //
// //                           });
// //                         },
// //                       ),
// //                       const SizedBox(width: 4),
// //                       textMessage.text.trim().isEmpty
// //                       ?RecordButton(controller: controller,)
// //                       :GestureDetector(
// //                         onTap: (){
// //                           AudioState.files.add(textMessage.text);
// //                           textMessage.clear();
// //                           setStat1(() {
// //
// //                           });
// //                         },
// //                         child: Container(
// //                           padding: EdgeInsets.all(15),
// //                           decoration: BoxDecoration(
// //                             color: Theme.of(context).primaryColor,
// //                             shape: BoxShape.circle
// //                           ),
// //                           child: Icon(Icons.send,color: ColorManager.white,),
// //                         ),
// //                       )
// //                     ],
// //                   );
// //                 },
// //               )
// //             ],
// //           ),
// //         ));
// //   }
// // }
//
// import 'package:flutter/material.dart';
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       child: SafeArea(
//         child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               button1(context),
//               button2(context),
//               button3(context),
//               button4(context),
//             ]),
//       ),
//     );
//   }
//
//   ElevatedButton button1(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () async {
//         SelectedImagesDetails? details =
//         await ImagePickerPlus(context).pickImage(
//           source: ImageSource.gallery,
//           multiImages: true,
//           galleryDisplaySettings: GalleryDisplaySettings(
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 3,
//               crossAxisSpacing: 1.7,
//               mainAxisSpacing: 1.5,
//               childAspectRatio: .5,
//             ),
//           ),
//         );
//         if (details != null) await displayDetails(details);
//       },
//       child: const Text("Normal 3 display"),
//     );
//   }
//
//   ElevatedButton button3(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () async {
//         ImagePickerPlus picker = ImagePickerPlus(context);
//         SelectedImagesDetails? details = await picker.pickVideo(
//           source: ImageSource.camera,
//           multiVideos: true,
//           galleryDisplaySettings: _galleryDisplaySettings(),
//         );
//         if (details != null) await displayDetails(details);
//       },
//       child: const Text("Normal 2 display"),
//     );
//   }
//
//   GalleryDisplaySettings _galleryDisplaySettings() {
//     return GalleryDisplaySettings(
//       appTheme: AppTheme(focusColor: Colors.white, primaryColor: Colors.black),
//       tabsTexts: TabsTexts(
//         videoText: "فيديو",
//         galleryText: "المعرض",
//         deletingText: "حذف",
//         clearImagesText: "الغاء الصور المحدده",
//         limitingText: "اقصي حد للصور هو 10",
//       ),
//       showImagePreview: true,
//       cropImage: true,
//     );
//   }
//
//   ElevatedButton button2(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () async {
//         ImagePickerPlus picker = ImagePickerPlus(context);
//         SelectedImagesDetails? details = await picker.pickBoth(
//           source: ImageSource.gallery,
//           multiSelection: true,
//           galleryDisplaySettings: GalleryDisplaySettings(
//             appTheme:
//             AppTheme(focusColor: Colors.white, primaryColor: Colors.black),
//             showImagePreview: true,
//             cropImage: true,
//           ),
//         );
//         if (details != null) await displayDetails(details);
//       },
//       child: const Text("Normal display"),
//     );
//   }
//
//   ElevatedButton button4(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () async {
//         ImagePickerPlus picker = ImagePickerPlus(context);
//         SelectedImagesDetails? details = await picker.pickBoth(
//           source: ImageSource.both,
//           multiSelection: false,
//           galleryDisplaySettings: GalleryDisplaySettings(
//             appTheme:
//             AppTheme(focusColor: Colors.white, primaryColor: Colors.black),
//             showImagePreview: true,
//             cropImage: true,
//           ),
//         );
//         if (details != null) await displayDetails(details);
//       },
//       child: const Text("Instagram 3 display"),
//     );
//   }
//
//   Future<void> displayDetails(SelectedImagesDetails details) async {
//     await Navigator.of(context).push(
//       CupertinoPageRoute(
//         builder: (context) {
//           if (details.isThatImage) {
//             return DisplayImages(
//                 selectedFiles: details.selectedFiles != null
//                     ? details.selectedFiles!
//                     : [details.selectedFile],
//                 details: details,
//                 aspectRatio: details.aspectRatio);
//           } else {
//             return DisplayVideo(
//                 video: details.selectedFile, aspectRatio: details.aspectRatio);
//           }
//         },
//       ),
//     );
//   }
// }
//
// class DisplayImages extends StatelessWidget {
//   final List<File> selectedFiles;
//   final double aspectRatio;
//   final SelectedImagesDetails details;
//   const DisplayImages({
//     Key? key,
//     required this.details,
//     required this.selectedFiles,
//     required this.aspectRatio,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Image')),
//       body: ListView.builder(
//         itemBuilder: (context, index) {
//           return SizedBox(
//               width: double.infinity, child: Image.file(selectedFiles[index]));
//         },
//         itemCount: selectedFiles.length,
//       ),
//     );
//   }
// }
//
// class DisplayVideo extends StatefulWidget {
//   final File video;
//   final double aspectRatio;
//   const DisplayVideo({
//     Key? key,
//     required this.video,
//     required this.aspectRatio,
//   }) : super(key: key);
//
//   @override
//   State<DisplayVideo> createState() => _DisplayVideoState();
// }
//
// class _DisplayVideoState extends State<DisplayVideo> {
//   late VideoPlayerController _controller;
//   late Future<void> _initializeVideoPlayerFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.file(widget.video);
//     _initializeVideoPlayerFuture = _controller.initialize();
//     _controller.setLooping(true);
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Video')),
//       body: FutureBuilder(
//         future: _initializeVideoPlayerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return AspectRatio(
//               aspectRatio: _controller.value.aspectRatio,
//               child: VideoPlayer(_controller),
//             );
//           }
//           else {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           setState(() {
//             if (_controller.value.isPlaying) {
//               _controller.pause();
//             } else {
//               _controller.play();
//             }
//           });
//         },
//         child: Icon(
//           _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//         ),
//       ),
//     );
//   }
// }