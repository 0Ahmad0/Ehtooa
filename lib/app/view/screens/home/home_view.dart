import 'package:ehtooa/app/model/utils/const.dart';
import 'package:ehtooa/app/model/utils/sizer.dart';
import 'package:ehtooa/app/view/resources/style_manager.dart';
import 'package:ehtooa/app/view/resources/values_manager.dart';
import 'package:ehtooa/app/view/screens/doctor/doctor_profile/doctor_profile_view.dart';
import 'package:ehtooa/app/view/screens/payment/payment_view.dart';
import 'package:ehtooa/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../model/models.dart';
import '../../resources/color_manager.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  List<InteractiveSessions> sessions = [
    InteractiveSessions(
      name: "الجلسة العلاجية رقم",
      id_link: "https://marketplace.zoom.us/docs/guides/build/launch-zoom-client-from-your-app/",
      isSold: false
    ),
    InteractiveSessions(
      name: "الجلسة العلاجية رقم",
      id_link: "https://marketplace.zoom.us/docs/guides/build/launch-zoom-client-from-your-app/",
      isSold: true
    ),
    InteractiveSessions(
      name: "الجلسة العلاجية رقم",
      id_link: "https://marketplace.zoom.us/docs/guides/build/launch-zoom-client-from-your-app/",
      isSold: false
    ),
    InteractiveSessions(
      name: "الجلسة العلاجية رقم",
      id_link: "https://marketplace.zoom.us/docs/guides/build/launch-zoom-client-from-your-app/",
      isSold: false
    ),
    InteractiveSessions(
      name: "الجلسة العلاجية رقم",
      id_link: "https://marketplace.zoom.us/docs/guides/build/launch-zoom-client-from-your-app/",
      isSold: true
    ),
  ];
  List<Doctor> doctors = [
    Doctor(id: "id", name: "د.أحمد الحريري", carer: "طبيب نفسي خريج فرنسا", description: "يعمل على معالجة الفيزيائبة والروحية للعقل والنفس"
        "خريج من جامعة فرنسا للامراض والطب النفسي "
        "حاصل على جائزة أفضل طبيب لعام 2016"),
    Doctor(id: "id", name: "د.أحمد مريود", carer: "طبيب نفسي خريج فرنسا", description: "يعمل على معالجة الفيزيائبة والروحية للعقل والنفس"
        "خريج من جامعة فرنسا للامراض والطب النفسي "
        "حاصل على جائزة أفضل طبيب لعام 2016"),
    Doctor(id: "id", name: "د.أحمد مريود", carer: "طبيب نفسي خريج فرنسا", description: "يعمل على معالجة الفيزيائبة والروحية للعقل والنفس"
        "خريج من جامعة فرنسا للامراض والطب النفسي "
        "حاصل على جائزة أفضل طبيب لعام 2016"),
    Doctor(id: "id", name: "د.أحمد الحريري", carer: "طبيب نفسي خريج فرنسا", description: "يعمل على معالجة الفيزيائبة والروحية للعقل والنفس"
        "خريج من جامعة فرنسا للامراض والطب النفسي "
        "حاصل على جائزة أفضل طبيب لعام 2016"),
    Doctor(id: "id", name: "د.أحمد الحريري", carer: "طبيب نفسي خريج فرنسا", description: "يعمل على معالجة الفيزيائبة والروحية للعقل والنفس"
        "خريج من جامعة فرنسا للامراض والطب النفسي "
        "حاصل على جائزة أفضل طبيب لعام 2016"),
    Doctor(id: "id", name: "د.أحمد الحريري", carer: "طبيب نفسي خريج فرنسا", description: "يعمل على معالجة الفيزيائبة والروحية للعقل والنفس"
        "خريج من جامعة فرنسا للامراض والطب النفسي "
        "حاصل على جائزة أفضل طبيب لعام 2016"),
    Doctor(id: "id", name: "د.أحمد الحريري", carer: "طبيب نفسي خريج فرنسا", description: "يعمل على معالجة الفيزيائبة والروحية للعقل والنفس"
        "خريج من جامعة فرنسا للامراض والطب النفسي "
        "حاصل على جائزة أفضل طبيب لعام 2016"),
    Doctor(id: "id", name: "د.أحمد الحريري", carer: "طبيب نفسي خريج فرنسا", description: "يعمل على معالجة الفيزيائبة والروحية للعقل والنفس"
        "خريج من جامعة فرنسا للامراض والطب النفسي "
        "حاصل على جائزة أفضل طبيب لعام 2016"),
    Doctor(id: "id", name: "د.أحمد الحريري", carer: "طبيب نفسي خريج فرنسا", description: "يعمل على معالجة الفيزيائبة والروحية للعقل والنفس"
        "خريج من جامعة فرنسا للامراض والطب النفسي "
        "حاصل على جائزة أفضل طبيب لعام 2016"),
  ];
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
                          contentPadding: EdgeInsets.all(AppPadding.p16),
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
              itemCount: sessions.length,
              itemBuilder: (_, index) {
                return InkWell(
                  onTap: ()async{
                    if(sessions[index].isSold){

                    }else{
                      Get.defaultDialog(
                      confirm: Row(
                        children: [
                          TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor:
                                  Theme.of(context).primaryColor
                              ),
                              onPressed: (){
                                Navigator.pop(context);
                                Navigator.push(context, MaterialPageRoute(builder: (ctx)=>PaymentView()));
                              }, child: Text(
                            tr(LocaleKeys.yes),
                            style: getLightStyle(
                                color: ColorManager.white,

                                fontSize: Sizer.getW(context) / 26
                            ),
                          )),
                          const SizedBox(width: AppSize.s8,),
                          TextButton(
                              style: TextButton.styleFrom(
                                  primary: ColorManager.error,
                                  backgroundColor: ColorManager.error
                              ),
                              onPressed: (){
                                Navigator.pop(context);
                              }, child: Text(
                            tr(LocaleKeys.no),
                            style: getLightStyle(
                                color: ColorManager.white,
                                fontSize: Sizer.getW(context) / 26
                            ),
                          )),
                        ],
                      ),
                        titleStyle: getBoldStyle(
                            color: Theme.of(context).textTheme.bodyText1!.color,
                          fontSize: Sizer.getW(context) / 22
                        ),
                        title: tr(LocaleKeys.this_session_is_paid),
                        content: Text(tr(LocaleKeys.pay_and_join),
                          style: getRegularStyle(
                            color: Theme.of(context).textTheme.bodyText1!.color,
                            fontSize: Sizer.getW(context) / 24
                          ),),
                        radius: AppSize.s14,


                      );
                    }
                  },
                  child: Stack(alignment: Alignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.all(AppMargin.m4),
                          padding: EdgeInsets.all(AppPadding.p10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: sessions[index].isSold?Theme.of(context).primaryColor:Colors.grey,
                              borderRadius: BorderRadius.circular(AppSize.s14),
                              boxShadow: [
                                BoxShadow(
                                    color: ColorManager.blackGray.withOpacity(.5),
                                    blurRadius: 4)
                              ]),
                          child: Column(
                            children: [
                              Text(
                                sessions[index].name,
                                textAlign: TextAlign.center,
                                style: getRegularStyle(
                                    color: ColorManager.white,
                                    fontSize: Sizer.getW(context) / 26),
                              ),
                            ],
                          )),
                      if(!sessions[index].isSold)
                      Icon(Icons.lock,size: Sizer.getW(context) * 0.18,),
                    ],
                  ),
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
            itemCount: doctors.length,
            itemBuilder: (_, index) {
              return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (ctx)=>
                      DoctorProfile(
                        doctor : doctors[index]
                      )));
                },
                child: Container(
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
                                blurRadius: 4
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
                      Text(doctors[index].name,
                        style: getRegularStyle(
                          color: Theme.of(context).textTheme.bodyText1!.color,
                        fontSize: Sizer.getW(context) / 26
                      )
                        ,)
                    ],
                  ),
                ),
              );
            },
          ))
        ],
      ),
    );
  }
}
