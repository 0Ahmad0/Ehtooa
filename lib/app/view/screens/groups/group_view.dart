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
            return Container(
                        child: Column(
                          children: [
                            Container(
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
                                    child: FlutterLogo(),
                                  ),
                                ),
                                title: Text(
                                   "${groupsProvider.groups.groups.length}",
                                  //tr(LocaleKeys.anxiety_patients),
                                  style: getRegularStyle(
                                      color: Theme.of(context).textTheme.bodyText1!.color,
                                      fontSize: Sizer.getW(context)/26
                                  ),),
                                subtitle: Text("السلام عليكم ورحمة الله",
                                  style: getLightStyle(
                                      color: Theme.of(context).textTheme.bodyText1!.color,
                                      fontSize: Sizer.getW(context)/32
                                  ),),
                              ),
                            )
                          ],
                        ),
                      );
            ///ToDo hariri
            ///اضافة ليست فيو
              /*ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 2,
                    itemBuilder: (_, index) {
                      return  Container(

                        child: Column(
                          children: [
                            Container(
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
                                    child: FlutterLogo(),
                                  ),
                                ),
                                title: Text(
                                  // "${value.groups.groups.length}",
                                  tr(LocaleKeys.anxiety_patients),
                                  style: getRegularStyle(
                                      color: Theme.of(context).textTheme.bodyText1!.color,
                                      fontSize: Sizer.getW(context)/26
                                  ),),
                                subtitle: Text("السلام عليكم ورحمة الله",
                                  style: getLightStyle(
                                      color: Theme.of(context).textTheme.bodyText1!.color,
                                      fontSize: Sizer.getW(context)/32
                                  ),),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );*/
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
