import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehtooa/app/controller/groups_provider.dart';
import 'package:ehtooa/app/model/utils/const.dart';
import 'package:ehtooa/app/model/utils/sizer.dart';
import 'package:ehtooa/app/view/resources/style_manager.dart';
import 'package:ehtooa/app/view/screens/chat/chat_view.dart';
import 'package:ehtooa/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';

import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:provider/provider.dart';
import '../../../controller/profile_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
class GroupsView extends StatelessWidget {
  const GroupsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final groupsProvider = Provider.of<GroupsProvider>(context);

    return   FutureBuilder(
      future: groupsProvider.fetchGroupsToUser(context, idUser: profileProvider.user.id),
      builder: (
          context, snapshot,) {
        //  print(snapshot.error);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return  Const.SHOWLOADINGINDECATOR();
          //Const.CIRCLE(context);
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Text('Error');
          } else if (snapshot.hasData) {


            return ListView.builder(
              itemCount: groupsProvider.groups.groups.length,
              itemBuilder: (_, index) {
                return                                Container(
                  decoration: BoxDecoration(
                      color: ColorManager.lightGray.withOpacity(.2),
                      border: Border(
                        bottom: BorderSide(
                          color: Theme.of(context).textTheme.bodyText1!.color!,
                        ),
                      )
                  ),
                  child: ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (ctx)=>ChatView()));
                    },
                    onLongPress: (){
                      Const.LOADIG(context);
                    },
                    leading: Transform.scale(
                      scale: 1.5,
                      child: CircleAvatar(
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          width: Sizer.getW(context) * 0.1,
                          height: Sizer.getW(context) * 0.1,
                          imageUrl:
                          // "${AppUrl.baseUrlImage}${widget.restaurant.imageLogo!}",
                          "${groupsProvider.groups.groups[index].photoUrl}",
                          imageBuilder: (context, imageProvider) =>
                              Container(
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
                          errorWidget: (context, url, error) =>
                              FlutterLogo(),
                        ),
                      ),
                    ),
                    title: Text(

                       "${!(context.locale == 'en')?groupsProvider.groups.groups[index].nameAr:groupsProvider.groups.groups[index].nameEn}",
                      //tr(LocaleKeys.anxiety_patients),
                      style: getRegularStyle(
                          color: Theme.of(context).textTheme.bodyText1!.color,
                          fontSize: Sizer.getW(context)/26
                      ),),
                    subtitle: Text(
                      ((groupsProvider.groups.groups[index].chat.id=="")
                          ?"جاري التحميل .."
                      ///ToDo mriwed
                          :"${groupsProvider.groups.groups[index].chat.messages.last.typeMessage}"),
                     // "السلام عليكم ورحمة الله",
                      style: getLightStyle(
                          color: Theme.of(context).textTheme.bodyText1!.color,
                          fontSize: Sizer.getW(context)/32
                      ),),
                  ),
                )
                ;
              },
            );

          } else {
            return const Text('Empty data');
          }
        } else {
          return Text('State: ${snapshot.connectionState}');
        }
      },
    );
    /*ChangeNotifierProvider<GroupsProvider>(
        create: (_)=> GroupsProvider(),
        child: Consumer<GroupsProvider>(
            builder: (context, value, child) =>


    ));*/
  }
}
