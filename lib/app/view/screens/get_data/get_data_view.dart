import 'dart:async';

import 'package:ehtooa/app/controller/home_provider.dart';
import 'package:ehtooa/app/view/resources/consts_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../controller/groups_provider.dart';
import '../../../controller/profile_provider.dart';
import '../../../model/models.dart';
import '../../../model/utils/const.dart';
import '../../resources/values_manager.dart';
import 'package:provider/provider.dart';

import '../bottom_nav_bar/bottom_nav_bar_view.dart';
import '../home/home_view.dart';
import '../questions/questions_view.dart';
class GetDataView extends StatefulWidget {
  const GetDataView({Key? key}) : super(key: key);

  @override
  State<GetDataView> createState() => _GetDataViewState();
}

class _GetDataViewState extends State<GetDataView> {
temp(groupsProvider,profileProvider,homeProvider) async {
  var data;
  ///ToDo hariri
  ///وضع تايمر بدل الحلقة
  homeProvider.groups=Groups(groups: []);
  groupsProvider.groups=Groups(groups: []);
 // groupsProvider.groups.groups=[];
  var resultGroup= await homeProvider.fetchGroups(context);
  if(resultGroup['status']){
    homeProvider.groups=Groups.fromJson(resultGroup['body']);
  }
  if(!profileProvider.user.typeUser.contains(AppConstants.collectionPatient)){
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (ctx) => BottomNavBarView()));
  }else{
    final resultPaySession=await profileProvider.fetchPaySession(context);
    if(resultPaySession['status']){
      profileProvider.paySession=PaySession.fromJson(resultPaySession['body']);
    }

    data = await groupsProvider.fetchGroupsToUser(context, idUser: profileProvider.user.id);
    if(data!=null)
      groupsProvider.groups=Groups.fromJson(data['body']);
    if(groupsProvider.groups.groups.length>0){
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (ctx) => BottomNavBarView()));
    }else{
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (ctx) => QuestionsView(indexTaken: [],)));
    }
  }


}

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final groupsProvider = Provider.of<GroupsProvider>(context);
    final homeProvider = Provider.of<HomeProvider>(context);
    Timer(Duration(milliseconds: 1), () async {
      if(!profileProvider.isEmailUserVerified())
       profileProvider.emailUserVerified(context);
      else
      temp(groupsProvider,profileProvider,homeProvider);
    });
    return
        Scaffold(
        body: Center(
          child: SpinKitPouringHourGlass(
            color: Theme.of(context).primaryColor,
            size: AppSize.s40,
          ),
        ),
      );
  }
}
