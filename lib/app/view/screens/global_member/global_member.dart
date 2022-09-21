import 'package:ehtooa/app/model/models.dart';
import 'package:ehtooa/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';import '../../../controller/chat_provider.dart';
import '../../../controller/global_member_provider.dart';
import '../../../controller/utils/firebase.dart';
import '../../../model/utils/const.dart';
import '../../../model/utils/sizer.dart';
import '../../resources/color_manager.dart';
import 'package:get/get.dart';
import '../../resources/consts_manager.dart';
import '../../resources/style_manager.dart';
import '../../resources/values_manager.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
class GlobalMemberView extends StatefulWidget {
  const GlobalMemberView({Key? key}) : super(key: key);

  @override
  State<GlobalMemberView> createState() => _GlobalMemberViewState();
}

class _GlobalMemberViewState extends State<GlobalMemberView> {
  late GlobalMemberProvider globalMemberProvider;
  @override
  Widget build(BuildContext context) {
    globalMemberProvider = Provider.of<GlobalMemberProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(LocaleKeys.add_member)),
      ),
      body: FutureBuilder(
        future: globalMemberProvider.fetchUsers(context),
        builder: (context, snapshot,) {
          //  print(snapshot.error);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Const.SHOWLOADINGINDECATOR();
            //Const.CIRCLE(context);
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Text('Error');
            } else if (snapshot.hasData) {
              Map<String, dynamic> data = snapshot.data as Map<String, dynamic>;
              globalMemberProvider.users = Users.fromJson(data['body']);
              return ChangeNotifierProvider<GlobalMemberProvider>.value(
                  value: globalMemberProvider,
                  child: Consumer<GlobalMemberProvider>(
                      builder: (context, value, child) =>
                          ListView.builder(
                            padding: EdgeInsets.all(AppPadding.p10),
                            itemCount: globalMemberProvider.users.users.length,
                            itemBuilder: (_,index)=>_buildUsers(index),
                          ),
                  ));
            } else {
              return const Text('Empty data');
            }
          } else {
            return Text('State: ${snapshot.connectionState}');
          }
        },
      ),
    );
  }
  Widget _buildUsers(index){
    return  Container(
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
            "${globalMemberProvider.users.users[index].photoUrl}",
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
        title: Text(globalMemberProvider.users.users[index].name
          ,style: getRegularStyle(color: Theme.of(context).textTheme.bodyText1!.color,
          fontSize: Sizer.getW(context) / 24
        ),),
        trailing:           
        (globalMemberProvider.checkAddUserToGroup(context, idUser: globalMemberProvider.users.users[index].id))?
        Icon(Icons.check,size: Sizer.getW(context)*0.1,color: ColorManager.success,):
        InkWell(
          onTap: (){
            globalMemberProvider.addUserToGroup(context, idUser: globalMemberProvider.users.users[index].id);
          },
          child: Container(
            padding: EdgeInsets.all(AppPadding.p14),
            decoration: BoxDecoration(
                color: ColorManager.success,
                borderRadius: BorderRadius.circular(AppSize.s8)
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add,color :ColorManager.white),
                const SizedBox(width: AppSize.s4,),
                Text(tr(LocaleKeys.add),style: getRegularStyle(
                    color: ColorManager.white
                ),),
              ],
            ),
          ),
        ),

        // :SizedBox(),
      ),
    );
  }
}
