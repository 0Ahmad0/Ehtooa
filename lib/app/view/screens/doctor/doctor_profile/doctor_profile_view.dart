import 'package:ehtooa/app/model/utils/sizer.dart';
import 'package:ehtooa/app/view/resources/values_manager.dart';
import 'package:ehtooa/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../model/models.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/style_manager.dart';

class DoctorProfile extends StatelessWidget {
  final Doctor doctor;

  const DoctorProfile({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(LocaleKeys.profile)),
      ),
      body: Column(
        children: [
          Expanded(child: Container(
            color: Colors.green,
          )),
          const SizedBox(height: AppSize.s20,),
          Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.only(
                  top: AppPadding.p30,
                  left: AppPadding.p20,
                  right: AppPadding.p20
                ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(AppSize.s50
                ),
              )
            ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildListTile(context,
                      icon: Icons.person,
                        title: tr(LocaleKeys.name),
                        subTitle: doctor.name
                      ),
                      const Divider(
                        thickness: AppSize.s1_5,
                      ),
                      _buildListTile(context,
                          icon: Icons.credit_card,
                          title: tr(LocaleKeys.name),
                          subTitle: doctor.carer
                      ),
                      const Divider(
                        thickness: AppSize.s1_5,
                      ),
                      _buildListTile(context,
                          icon: Icons.description,
                          title: tr(LocaleKeys.name),
                          subTitle: doctor.description
                      ),
                      const Divider(
                        thickness: AppSize.s1_5,
                      ),
                    ],
                  ),
                ),
          ))
        ],
      ),
    );
  }

  Widget _buildListTile(BuildContext context,{icon,title,subTitle}){
    return ListTile(
      leading: Icon(icon),
      title: Text(title,style: getRegularStyle(
        // color: Theme.of(context).textTheme.bodyText1!.color
          color: ColorManager.white,
          fontSize: Sizer.getW(context) / 24
      ),),
      subtitle: Text(subTitle,style: getRegularStyle(
        // color: Theme.of(context).textTheme.bodyText1!.color
          color: ColorManager.white,
          fontSize: Sizer.getW(context) / 28
      ),),
    );
  }
}