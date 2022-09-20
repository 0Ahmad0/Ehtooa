import 'package:ehtooa/app/controller/home_provider.dart';
import 'package:ehtooa/app/view/resources/consts_manager.dart';
import 'package:ehtooa/app/view/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import '../../../controller/chat_provider.dart';
import '../../../controller/utils/firebase.dart';
import '../../../model/models.dart';
import '../../../model/utils/const.dart';
import '../../../model/utils/sizer.dart';
import '../../resources/color_manager.dart';
import 'package:ehtooa/translations/locale_keys.g.dart';
import 'package:provider/provider.dart';
import '../../resources/style_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
class ListOfMemberView extends StatelessWidget {
  final List<User> users;

  const ListOfMemberView({super.key, required this.users});
  @override
  Widget build(BuildContext context) {
     final chatProvider = Provider.of<ChatProvider>(context);
     final homeProvider = Provider.of<HomeProvider>(context);
     List listUsers=[chatProvider.group.idAmin];
     listUsers.addAll(chatProvider.group.listUsers);
    return Scaffold(
      appBar: AppBar(
        title: Text("Members"),
      ),
      body: ListView.builder(
            padding: EdgeInsets.all(AppPadding.p10),
            itemCount: listUsers.length,//users.length + 3,
            itemBuilder: (_,index){
              return user(context, homeProvider, idUser: listUsers[index],
                  typeUser: (index==0)?AppConstants.collectionAdmin:AppConstants.collectionPatient,
                  checkblock:(chatProvider.group.listBlockUsers.contains( listUsers[index]))?true:false);
              /**
                  Container(
                  margin: EdgeInsets.symmetric(vertical: AppMargin.m4),
                  padding: EdgeInsets.symmetric(
                  vertical: AppPadding.p10
                  ),
                  decoration: BoxDecoration(
                  color: ColorManager.lightGray.withOpacity(.2),
                  borderRadius: BorderRadius.circular(AppSize.s14)
                  ),
                  child: ListTile(
                  leading: CachedNetworkImage(
                  fit: BoxFit.fill,
                  width: Sizer.getW(context) * 0.1,
                  height: Sizer.getW(context) * 0.1,
                  imageUrl:
                  // "${AppUrl.baseUrlImage}${widget.restaurant.imageLogo!}",
                  "${AppConstants.photoProfilePatient}",
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
                  title: //Text("users[index].name"),
                  FutureBuilder(
                  future: homeProvider
                  .fetchNameUser(context,
                  idUser: chatProvider.group.listUsers[index]),
                  builder: (context, snapshot,) {
                  print(snapshot.error);
                  if (snapshot
                  .connectionState ==
                  ConnectionState.waiting) {
                  return   Text("${FirebaseFun.findTextToast("جاري التحميل ..")}"); // Expanded(child: Const.SHOWLOADINGINDECATOR());
                  //Const.CIRCLE(context);
                  } else if (snapshot
                  .connectionState ==
                  ConnectionState.done) {
                  if (snapshot.hasError) {
                  return const Text(
                  'Error');
                  } else
                  if (snapshot.hasData) {
                  // Map<String,dynamic> data=snapshot.data as Map<String,dynamic>;
                  //homeProvider.sessions=Sessions.fromJson(data['body']);
                  return Text("${snapshot.data}");
                  } else {
                  return const Text(
                  'Empty data');
                  }
                  } else {
                  return Text(
                  'State: ${snapshot
                  .connectionState}');
                  }
                  },
                  ),
                  ///subtitle: Text("users[index].name"),
                  trailing: InkWell(
                  onTap: (){
                  Get.defaultDialog(
                  confirm: Row(
                  children: [
                  TextButton(
                  style: TextButton.styleFrom(
                  backgroundColor:
                  Theme.of(context).primaryColor),
                  onPressed: () {
                  Navigator.pop(context);
                  },
                  child: Text(
                  tr(LocaleKeys.yes),
                  style: getLightStyle(
                  color: ColorManager.white,
                  fontSize: Sizer.getW(context) / 26),
                  )),
                  const SizedBox(
                  width: AppSize.s8,
                  ),
                  TextButton(
                  style: TextButton.styleFrom(
                  primary: ColorManager.error,
                  backgroundColor: ColorManager.error),
                  onPressed: () {
                  Navigator.pop(context);
                  },
                  child: Text(
                  tr(LocaleKeys.no),
                  style: getLightStyle(
                  color: ColorManager.white,
                  fontSize: Sizer.getW(context) / 26),
                  )),
                  ],
                  ),
                  titleStyle: getBoldStyle(
                  color: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .color,
                  fontSize: Sizer.getW(context) / 22),
                  title: tr(LocaleKeys.are_you_sure),
                  content: Text(
                  tr(LocaleKeys.confirm_delete),
                  style: getRegularStyle(
                  color: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .color,
                  fontSize: Sizer.getW(context) / 24),
                  ),
                  radius: AppSize.s14,
                  );

                  },
                  child: Container(
                  padding: EdgeInsets.all(AppPadding.p14),
                  decoration: BoxDecoration(
                  color: ColorManager.error,
                  borderRadius: BorderRadius.circular(AppSize.s8)
                  ),
                  child: Text(tr(LocaleKeys.delete),style: getRegularStyle(
                  color: ColorManager.white
                  ),),
                  )
                  ),
                  ),
                  );
               **/
            },
          ),


    );
  }
  user(context,homeProvider,{required String idUser,required String typeUser,required bool checkblock}){
    return Container(
      margin: EdgeInsets.symmetric(vertical: AppMargin.m4),
      padding: EdgeInsets.symmetric(
          vertical: AppPadding.p10
      ),
      decoration: BoxDecoration(
          color: ColorManager.lightGray.withOpacity(.2),
          borderRadius: BorderRadius.circular(AppSize.s14)
      ),
      child: ListTile(
        leading: CachedNetworkImage(
          fit: BoxFit.fill,
          width: Sizer.getW(context) * 0.1,
          height: Sizer.getW(context) * 0.1,
          imageUrl:
          // "${AppUrl.baseUrlImage}${widget.restaurant.imageLogo!}",
          (typeUser.contains(AppConstants.collectionPatient))
              ?"${AppConstants.photoProfilePatient}"
              :"${AppConstants.photoProfileAdmin}",
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
        title: //Text("users[index].name"),
        FutureBuilder(
          future: homeProvider
              .fetchNameUser(context,
              idUser: idUser //chatProvider.group.listUsers[index]
  ),
          builder: (context, snapshot,) {
            print(snapshot.error);
            if (snapshot
                .connectionState ==
                ConnectionState.waiting) {
              return   Text("${FirebaseFun.findTextToast("جاري التحميل ..")}"); // Expanded(child: Const.SHOWLOADINGINDECATOR());
              //Const.CIRCLE(context);
            } else if (snapshot
                .connectionState ==
                ConnectionState.done) {
              if (snapshot.hasError) {
                return const Text(
                    'Error');
              } else
              if (snapshot.hasData) {
                // Map<String,dynamic> data=snapshot.data as Map<String,dynamic>;
                //homeProvider.sessions=Sessions.fromJson(data['body']);
                return Row(
                  children: [
                Text("${snapshot.data}"),
                    SizedBox(width: Sizer.getW(context)*0.01,),
                    (typeUser.contains(AppConstants.collectionPatient))?
                     SizedBox():
                    Icon(Icons.star),
                    (!checkblock)?
                    SizedBox():
                    Icon(Icons.block),
                  ],
                );
              } else {
                return const Text(
                    'Empty data');
              }
            } else {
              return Text(
                  'State: ${snapshot
                      .connectionState}');
            }
          },
        ),
        ///subtitle: Text("users[index].name"),

        trailing: (typeUser.contains(AppConstants.collectionPatient))?
        InkWell(
            onTap: (){
              Get.defaultDialog(
                confirm: Row(
                  children: [
                    TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor:
                            Theme.of(context).primaryColor),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          tr(LocaleKeys.yes),
                          style: getLightStyle(
                              color: ColorManager.white,
                              fontSize: Sizer.getW(context) / 26),
                        )),
                    const SizedBox(
                      width: AppSize.s8,
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                            primary: ColorManager.error,
                            backgroundColor: ColorManager.error),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          tr(LocaleKeys.no),
                          style: getLightStyle(
                              color: ColorManager.white,
                              fontSize: Sizer.getW(context) / 26),
                        )),
                  ],
                ),
                titleStyle: getBoldStyle(
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .color,
                    fontSize: Sizer.getW(context) / 22),
                title: tr(LocaleKeys.are_you_sure),
                content: Text(
                  tr(LocaleKeys.confirm_delete),
                  style: getRegularStyle(
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color,
                      fontSize: Sizer.getW(context) / 24),
                ),
                radius: AppSize.s14,
              );

            },
            child: Container(
              padding: EdgeInsets.all(AppPadding.p14),
              decoration: BoxDecoration(
                  color: ColorManager.error,
                  borderRadius: BorderRadius.circular(AppSize.s8)
              ),
              child: Text(tr(LocaleKeys.delete),style: getRegularStyle(
                  color: ColorManager.white
              ),),
            )
        )
        :SizedBox(),
      ),
    );
  }
}
