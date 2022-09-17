import 'dart:io';

import 'package:flutter/material.dart';

import '../widgets/audio_bubble.dart';
import 'audio_state.dart';
import 'globals.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  List<FileSystemEntity> data = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimatedList(
        padding: const EdgeInsets.symmetric(vertical: 15),
        key: Globals.audioListKey,
        itemBuilder: (context, index, animation) {
          return FadeTransition(
            opacity: animation,
            child: AudioBubble(
              filepath: AudioState.files[index],
              key: ValueKey(AudioState.files[index]),
            ),
          );
        },
      ),
    );
  }

  Future<List<FileSystemEntity>> fetchAudioFiles() async {
    String dirPath = Globals.documentPath;
    List<FileSystemEntity> file = Directory(dirPath).listSync();
    file.removeWhere((element) => !element.path.endsWith("m4a"));
    file = file.reversed.toList();
    return file;
  }
}
