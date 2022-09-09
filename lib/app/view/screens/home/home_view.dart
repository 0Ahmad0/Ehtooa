import 'package:ehtooa/app/model/utils/sizer.dart';
import 'package:ehtooa/app/view/resources/style_manager.dart';
import 'package:ehtooa/app/view/resources/values_manager.dart';
import 'package:ehtooa/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../resources/color_manager.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: Sizer.getW(context) / 2.5,
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.topRight,
                  width: double.infinity,
                  height: Sizer.getW(context) / 4,
                  padding: EdgeInsets.symmetric(
                      horizontal: AppPadding.p20, vertical: AppPadding.p10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(AppSize.s40))),
                  child: Row(
                    children: [
                      Text(
                        tr(LocaleKeys.welcome) + "  ",
                        style: getRegularStyle(
                          color: ColorManager.white,
                          fontSize: Sizer.getW(context) / 22,
                        ),
                      ),
                      Text(
                        "أحمد",
                        style: getBoldStyle(
                          color: ColorManager.white,
                          fontSize: Sizer.getW(context) / 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned.fill(
                    top: Sizer.getW(context) / 6,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.p20),
                      child: TextFormField(
                        onFieldSubmitted: (val){},
                        style: getRegularStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: Sizer.getW(context) / 22),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppSize.s100),
                              borderSide: BorderSide.none,
                            ),
                            hintText: tr(LocaleKeys.search),
                            hintStyle: getRegularStyle(
                                color: Theme.of(context).primaryColor,
                              fontSize: Sizer.getW(context) / 24
                            ),
                            prefixIcon: IconButton(
                                onPressed: (){},
                            icon: Icon(Icons.search,
                              color: Theme.of(context).primaryColor,
                            ),
                            )),
                      ),
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  tr(LocaleKeys.interactive_sessions),
                  style: getMediumStyle(
                      color: Theme.of(context).textTheme.bodyText1!.color,
                      fontSize: Sizer.getW(context) / 24),
                ),
                Container(
                  width: Sizer.getW(context) * 0.1,
                  height: 2,
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                const SizedBox(height: AppSize.s4,)
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.2
              ),
              itemCount: 4,
              itemBuilder: (_, index) {
                return Stack(alignment: Alignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.all(AppMargin.m4),
                        padding: EdgeInsets.all(AppPadding.p10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: index.isEven?Colors.grey:Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(AppSize.s14),
                            boxShadow: [
                              BoxShadow(
                                  color: ColorManager.blackGray.withOpacity(.5),
                                  blurRadius: 10)
                            ]),
                        child: Column(
                          children: [
                            Text(
                              "جلسة اضطرابات القلق",
                              textAlign: TextAlign.center,
                              style: getRegularStyle(
                                  color: ColorManager.white,
                                  fontSize: Sizer.getW(context) / 26),
                            ),
                          ],
                        )),
                    if(index.isEven)
                    Icon(Icons.lock,size: Sizer.getW(context) * 0.18,),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  tr(LocaleKeys.psychologists),
                  style: getMediumStyle(
                      color: Theme.of(context).textTheme.bodyText1!.color,
                      fontSize: Sizer.getW(context) / 24),
                ),
                Container(
                  width: Sizer.getW(context) * 0.1,
                  height: 2,
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                const SizedBox(height: AppSize.s4,)
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 12,
            itemBuilder: (_, index) {
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.p10
                ),
                margin: EdgeInsets.all(AppMargin.m4),
                width: Sizer.getW(context) / 2,
                decoration:
                    BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(.5),
                      borderRadius: BorderRadius.circular(AppSize.s14),
                        boxShadow: [
                          BoxShadow(
                              color: ColorManager.blackGray.withOpacity(.3),
                              blurRadius: 10
                          ),
                        ],

                    ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: Sizer.getW(context) * 0.08,
                      child: FlutterLogo(),
                    ),
                    SizedBox(width: AppSize.s4,),
                    Text("د.أحمد الحريري",style: getRegularStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color,
                      fontSize: Sizer.getW(context) / 26
                    )
                      ,)
                  ],
                ),
              );
            },
          ))
        ],
      ),
    );
  }
}
