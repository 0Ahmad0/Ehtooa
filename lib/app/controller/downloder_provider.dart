

import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:ehtooa/app/controller/utils/firebase.dart';
import 'package:ehtooa/app/model/models.dart';
import 'package:ehtooa/app/model/utils/local/storage.dart';
import 'package:ehtooa/app/view/resources/consts_manager.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../model/utils/const.dart';

class DownloaderProvider with ChangeNotifier{
  Map<String,double> downloadProgress={};
  Map<String,bool> checkClickDownload={};
  Map<String,bool> checkCompleteDownload={};
   late var tempDir;
  Future downloadFile(Message message) async {
    checkClickDownload[message.id]=true;
    checkCompleteDownload[message.id]=false;
    downloadProgress[message.id]=0;
    notifyListeners();
    final tempDir= await getTemporaryDirectory();
    final path = "${tempDir.path}/${message.textMessage}";
    var result =await Dio().download(
        message.url,
        path,
      onReceiveProgress: (received,total){
          double progress=received/total;
          if(received==total){
            checkCompleteDownload[message.id]=true;
            checkClickDownload[message.id]=false;
          }
          downloadProgress[message.id]=progress;
          notifyListeners();
      }
    );
  }

}