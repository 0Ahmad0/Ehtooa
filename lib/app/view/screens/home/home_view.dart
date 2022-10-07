import 'dart:math';
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehtooa/app/controller/add_doctor_provider.dart';
import 'package:ehtooa/app/controller/groups_provider.dart';
import 'package:ehtooa/app/controller/home_provider.dart';
import 'package:ehtooa/app/controller/payment_provider.dart';
import 'package:ehtooa/app/controller/profile_provider.dart';
import 'package:ehtooa/app/model/utils/const.dart';
import 'package:ehtooa/app/model/utils/sizer.dart';
import 'package:ehtooa/app/view/resources/assets_manager.dart';
import 'package:ehtooa/app/view/resources/consts_manager.dart';
import 'package:ehtooa/app/view/resources/style_manager.dart';
import 'package:ehtooa/app/view/resources/values_manager.dart';
import 'package:ehtooa/app/view/screens/doctor/doctor_profile/doctor_profile_view.dart';
import 'package:ehtooa/app/view/screens/payment/payment_view.dart';
import 'package:ehtooa/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../controller/utils/firebase.dart';
import '../../../model/models.dart';
import 'package:path_provider/path_provider.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../resources/color_manager.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _current = 0;
  var getChat;
  dynamic _selectedIndex = {};
  var getSessions;
  late HomeProvider homeProvider1;
  final CarouselController _carouselController = CarouselController();

  late HomeProvider homeProvider;

  late PaymentProvider paymentProvider;

  late ProfileProvider   profileProvider;

  late GroupsProvider groupsProvider;
  @override
  void initState() {
    // TODO: implement initState
    //getChatFuc();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileProvider = Provider.of<ProfileProvider>(context, listen: false);
      groupsProvider = Provider.of<GroupsProvider>(context, listen: false);
      homeProvider =  Provider.of<HomeProvider>(context, listen: false);
           homeProvider.search = "";
           getChatFuc();
         });
    super.initState();

  }
  getChatFuc(){
  //  homeProvider = Provider.of<HomeProvider>(context);
    getChat = homeProvider.fetchSessionsIdUser(context,
        groups: groupsProvider.groups.groups,
        paySession: profileProvider.paySession,
        idUser: profileProvider.user.id,
        typeUser: profileProvider.user.typeUser);
    return getChat;
  }


  ///];
// ProfileProvider profileProvider = ProfileProvider();
  @override
  Widget build(BuildContext context) {
     profileProvider = Provider.of<ProfileProvider>(context);
     homeProvider = Provider.of<HomeProvider>(context);
     groupsProvider = Provider.of<GroupsProvider>(context);
     paymentProvider = Provider.of<PaymentProvider>(context);
    final addDoctorProvider = Provider.of<AddDoctorProvider>(context);
   /// getChatFuc();
    //homeProvider.search = "";
    return Container(
      child: StatefulBuilder(builder: (_, setState1) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: Sizer.getW(context) / 4,
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    width: double.infinity,
                    height: Sizer.getW(context) / 6,
                    padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
                    decoration: BoxDecoration(
                        color: Theme.of(context).appBarTheme.backgroundColor,
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
                        ChangeNotifierProvider<ProfileProvider>.value(
                            value: profileProvider,
                            child: Consumer<ProfileProvider>(
                              builder: (context, value, child) => Text(
                                value.user.name,
                                //"أحمد",
                                style: getBoldStyle(
                                  color: ColorManager.white,
                                  fontSize: Sizer.getW(context) / 16,
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                  Positioned.fill(
                      top: Sizer.getW(context) / 9,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.p20),
                        child: TextFormField(
                          onChanged: (val) {
                            homeProvider.search = val;
                            print(homeProvider.search);
                          },
                          autofocus: false,
                          onFieldSubmitted: (val) {
                            homeProvider.search = val;
                            print(homeProvider.search);
                          },
                          style: getRegularStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                              fontSize: Sizer.getW(context) / 22),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(AppPadding.p16),
                              filled: true,
                              fillColor: Theme.of(context).cardColor,
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(AppSize.s100),
                                borderSide: BorderSide.none,
                              ),
                              hintText: tr(LocaleKeys.search),
                              hintStyle: getRegularStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                  fontSize: Sizer.getW(context) / 24),
                              prefixIcon: IconButton(
                                onPressed: () {
                               //   setState1(() {});
                                  homeProvider.setState3((){});
                                  homeProvider.setState2((){});
                                },
                                icon: Icon(
                                  Icons.search,
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
                  const SizedBox(
                    height: AppSize.s4,
                  )
                ],
              ),
            ),
            StatefulBuilder(builder: (_, setState3) {
              homeProvider.setState3=setState3;
              getChatFuc();
              return FutureBuilder(
                future: getChat,
                builder: (
                  context,
                  snapshot,
                ) {
                  //  print(snapshot.error);
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    ///return SizedBox(height: Sizer.getH(context) / 2.35, child: Const.SHOWLOADINGINDECATOR());
                    return circleWaitSessions(setState3);
                    //Const.CIRCLE(context);
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    } else if (snapshot.hasData) {
                      Map<String, dynamic> data =
                          snapshot.data as Map<String, dynamic>;
                      homeProvider.sessions = Sessions.fromJson(data['body']);
                      if(homeProvider.sessionsToUser.length<=0){
                        return Expanded(
                            flex: 3,
                            child: SvgPicture.asset(
                              ImagesAssets.noDataFound,
                            ));
                      }else
                      return StatefulBuilder(
                        builder: (_, setState1) {
                          return CarouselSlider(
                              carouselController: _carouselController,
                              options: CarouselOptions(
                                  height: Sizer.getH(context) / 2.35,
                                  aspectRatio: 16 / 9,
                                  viewportFraction: 0.7,
                                  enlargeCenterPage: true,
                                  pageSnapping: true,
                                  onPageChanged: (index, reason) {
                                    setState1(() {
                                      _current = index;
                                      //print(index);
                                    });
                                  }),
                              items: homeProvider.sessionsToUser.map((e) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: AppPadding.p12),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (homeProvider.sessionsToUser[homeProvider.sessionsToUser.indexOf(e)]
                                          .isSold) {
                                        setState1(() {
                                          if (_selectedIndex == e) {
                                            _selectedIndex = {};
                                          } else {
                                            _selectedIndex = e;
                                          }
                                        });
                                      } else {
                                        Get.defaultDialog(
                                          confirm: Row(
                                            children: [
                                              TextButton(
                                                  style: TextButton.styleFrom(
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .primaryColor),
                                                  onPressed: () {
                                                    paymentProvider.idGroup =
                                                        e.idGroup;
                                                    paymentProvider.setStat3 =
                                                        setState3;
                                                    Navigator.pop(context);
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (ctx) =>
                                                                PaymentView()));
                                                  },
                                                  child: Text(
                                                    tr(LocaleKeys.yes),
                                                    style: getLightStyle(
                                                        color:
                                                            ColorManager.white,
                                                        fontSize: Sizer.getW(
                                                                context) /
                                                            26),
                                                  )),
                                              const SizedBox(
                                                width: AppSize.s8,
                                              ),
                                              TextButton(
                                                  style: TextButton.styleFrom(
                                                      primary:
                                                          ColorManager.error,
                                                      backgroundColor:
                                                          ColorManager.error),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    tr(LocaleKeys.no),
                                                    style: getLightStyle(
                                                        color:
                                                            ColorManager.white,
                                                        fontSize: Sizer.getW(
                                                                context) /
                                                            26),
                                                  )),
                                            ],
                                          ),
                                          titleStyle: getBoldStyle(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .color,
                                              fontSize:
                                                  Sizer.getW(context) / 22),
                                          title: tr(
                                              LocaleKeys.this_session_is_paid),
                                          content: Text(
                                            tr(LocaleKeys.pay_and_join),
                                            style: getRegularStyle(
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .color,
                                                fontSize:
                                                    Sizer.getW(context) / 24),
                                          ),
                                          radius: AppSize.s14,
                                        );
                                      }
                                    },
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              color:
                                                  Theme.of(context).cardColor,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppSize.s8),
                                              border: _selectedIndex == e
                                                  ? Border.all(
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .color!,
                                                      width: 2)
                                                  : null,
                                              boxShadow: _selectedIndex == e
                                                  ? [
                                                      BoxShadow(
                                                        color: Theme.of(context)
                                                            .primaryColor
                                                            .withOpacity(.8),
                                                        blurRadius: 8,
                                                      )
                                                    ]
                                                  : [
                                                      BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.2),
                                                          blurRadius: 8,
                                                          offset: Offset(0, 5))
                                                    ]),
                                          child: Column(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  margin:
                                                      const EdgeInsets.all(10),
                                                  clipBehavior: Clip.hardEdge,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            AppSize.s20),
                                                  ),
                                                  child: SvgPicture.asset(
                                                      ImagesAssets
                                                              .imagesInteractiveSessions[
                                                          homeProvider
                                                              .sessionsToUser
                                                              .indexOf(e)],
                                                      fit: BoxFit.fill),
                                                ),
                                              ),
                                              if (homeProvider
                                                  .sessionsToUser[homeProvider
                                                      .sessionsToUser
                                                      .indexOf(e)]
                                                  .isSold)
                                                Text(e.name,
                                                    style: getRegularStyle(
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .color,
                                                        fontSize: Sizer.getW(
                                                                context) /
                                                            24)),
                                              _selectedIndex == e
                                                  ? ZoomIn(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    AppPadding
                                                                        .p10),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            FutureBuilder(
                                                              future: homeProvider
                                                                  .fetchNameUser(
                                                                      context,
                                                                      idUser: e
                                                                          .doctorName),
                                                              builder: (
                                                                context,
                                                                snapshot,
                                                              ) {
                                                                print(snapshot
                                                                    .error);
                                                                if (snapshot
                                                                        .connectionState ==
                                                                    ConnectionState
                                                                        .waiting) {
                                                                  return Expanded(
                                                                      child: Const
                                                                          .SHOWLOADINGINDECATOR());
                                                                  //Const.CIRCLE(context);
                                                                } else if (snapshot
                                                                        .connectionState ==
                                                                    ConnectionState
                                                                        .done) {
                                                                  if (snapshot
                                                                      .hasError) {
                                                                    return const Text(
                                                                        'Error');
                                                                  } else if (snapshot
                                                                      .hasData) {
                                                                    // Map<String,dynamic> data=snapshot.data as Map<String,dynamic>;
                                                                    //homeProvider.sessions=Sessions.fromJson(data['body']);
                                                                    return Text(
                                                                      "${tr(LocaleKeys.
                                                                      specialist)}:${snapshot.data}",
                                                                      style: getBoldStyle(
                                                                          color: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyText1!
                                                                              .color,
                                                                          fontSize:
                                                                              Sizer.getW(context) / 24),
                                                                    );
                                                                  } else {
                                                                    return const Text(
                                                                        'Empty data');
                                                                  }
                                                                } else {
                                                                  return Text(
                                                                      'State: ${snapshot.connectionState}');
                                                                }
                                                              },
                                                            ),
                                                            TextButton(
                                                                style: TextButton
                                                                    .styleFrom(
                                                                  backgroundColor:
                                                                      Theme.of(
                                                                              context)
                                                                          .primaryColor,
                                                                ),
                                                                onPressed:
                                                                    () async {
                                                                  await homeProvider
                                                                      .goToUrl(
                                                                          context,
                                                                          e.id_link);
                                                                },
                                                                child: Text(
                                                                  tr(LocaleKeys
                                                                      .go),
                                                                  style: getRegularStyle(
                                                                      color: ColorManager.white,
                                                                      fontSize:
                                                                          Sizer.getW(context) /
                                                                              30),
                                                                ))
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  : SizedBox()
                                            ],
                                          ),
                                        ),
                                        (!homeProvider
                                                .sessionsToUser[homeProvider
                                                    .sessionsToUser
                                                    .indexOf(e)]
                                                .isSold)
                                            ? Container(
                                                width: double.infinity,
                                                height: double.infinity,
                                                decoration: BoxDecoration(
                                                    color: ColorManager
                                                        .blackGray
                                                        .withOpacity(.6),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            AppSize.s14)),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Icon(
                                                      Icons.lock,
                                                      size:
                                                          Sizer.getH(context) *
                                                              0.15,
                                                    ),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              AppMargin.m8),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              AppPadding.p4),
                                                      width: double.infinity,
                                                      height:
                                                          Sizer.getW(context) *
                                                              0.2,
                                                      decoration: BoxDecoration(
                                                          color: Theme.of(
                                                                  context)
                                                              .cardColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      AppSize
                                                                          .s14)),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Text(
                                                            " ${tr(LocaleKeys.price)} ${e.price} \$",
                                                            style: getLightStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText1!
                                                                    .color,
                                                                fontSize:
                                                                    Sizer.getW(
                                                                            context) /
                                                                        26),
                                                          ),
                                                          const Text("|"),
                                                          FutureBuilder(
                                                            future: homeProvider
                                                                .fetchNameUser(
                                                                    context,
                                                                    idUser: e
                                                                        .doctorName),
                                                            builder: (
                                                              context,
                                                              snapshot,
                                                            ) {
                                                              print(snapshot
                                                                  .error);
                                                              if (snapshot
                                                                      .connectionState ==
                                                                  ConnectionState
                                                                      .waiting) {
                                                                return Expanded(
                                                                    child: Const
                                                                        .SHOWLOADINGINDECATOR());
                                                                //Const.CIRCLE(context);
                                                              } else if (snapshot
                                                                      .connectionState ==
                                                                  ConnectionState
                                                                      .done) {
                                                                if (snapshot
                                                                    .hasError) {
                                                                  return const Text(
                                                                      'Error');
                                                                } else if (snapshot
                                                                    .hasData) {
                                                                  // Map<String,dynamic> data=snapshot.data as Map<String,dynamic>;
                                                                  //homeProvider.sessions=Sessions.fromJson(data['body']);
                                                                  return Flexible(
                                                                    child: Text(
                                                                      "${snapshot.data}",
                                                                      // overflow: TextOverflow.ellipsis,
                                                                      //"${ fetchNameUser(context,e.doctorName,homeProvider)}",
                                                                      style: getLightStyle(
                                                                          color: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyText1!
                                                                              .color,
                                                                          fontSize:
                                                                              Sizer.getW(context) /
                                                                                  24),
                                                                    ),
                                                                  );
                                                                } else {
                                                                  return const Text(
                                                                      'Empty data');
                                                                }
                                                              } else {
                                                                return Text(
                                                                    'State: ${snapshot.connectionState}');
                                                              }
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            : SizedBox(),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList());
                        },
                      );
                    } else {
                      return Expanded(
                        flex: 3,
                        child: SvgPicture.asset(
                          ImagesAssets.noDataFound,
                        ),
                      );
                    }
                  } else {
                    return Text('State: ${snapshot.connectionState}');
                  }
                },
              );
            }),
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
                  const SizedBox(
                    height: AppSize.s4,
                  )
                ],
              ),
            ),
            StatefulBuilder(builder: (_, setState2) {
              addDoctorProvider.setState2 = setState2;
              homeProvider.setState2 = setState2;
             // homeProvider.setState2=setState2;
           return FutureBuilder(
              future: homeProvider.fetchDoctors(context),
              builder: (
                context,
                snapshot,
              ) {
                //  print(snapshot.error);
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Expanded(child:
                 /// Const.SHOWLOADINGINDECATOR()
                     circleWaitDoctors(setState2)
                  );
                  //Const.CIRCLE(context);
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Text('Error');
                  }
                  else if (snapshot.hasData) {
                    Map<String, dynamic> data =
                        snapshot.data as Map<String, dynamic>;
                    homeProvider.doctors = Users.fromJson(data['body']);
                    if (homeProvider.search != "") {
                      //print("ffffffffffffffffff");
                      homeProvider.doctors.users =
                          homeProvider.searchListDoctors(context,
                              search: homeProvider.search,
                              users: homeProvider.doctors.users);
                    }
                    if(homeProvider.doctors.users.length<=0){
                      return Expanded(
                          flex: 3,
                          child: SvgPicture.asset(
                            ImagesAssets.noDataFound,
                          ));
                    }else
                    return
                      Expanded(
                        child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: homeProvider.doctors.users.length,
                      itemBuilder: (_, index) {
                        return InkWell(
                          onTap: () async {
                            // print(groupsProvider.groups.groups.length);
                            //  print(profileProvider.paySession.toJson());
                            // print("ame :${await homeProvider.fetchNameUser(context, idUser: profileProvider.user.id)}");
                            print(homeProvider.sessionsToUser.length);
                            // print(homeProvider.sessions.sessions.length);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => DoctorProfile(
                                        doctor: homeProvider
                                            .doctors.users[index])));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppPadding.p10),
                            margin: EdgeInsets.all(AppMargin.m4),
                            width: Sizer.getW(context) / 2,
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColor.withOpacity(.7),
                              borderRadius: BorderRadius.circular(AppSize.s14),
                              boxShadow: [
                                BoxShadow(
                                    color:
                                        ColorManager.blackGray.withOpacity(.3),
                                    blurRadius: 4),
                              ],
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                            backgroundColor: Theme.of(context).cardColor,
                                  radius: Sizer.getW(context) * 0.08,
                                  child: CachedNetworkImage(
                                    fit: BoxFit.fill,
                                    width: Sizer.getW(context) * 0.14,
                                    height: Sizer.getW(context) * 0.14,
                                    imageUrl:
                                        // "${AppUrl.baseUrlImage}${widget.restaurant.imageLogo!}",
                                        "${homeProvider.doctors.users[index].photoUrl}",
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
                                  //FlutterLogo(),
                                ),
                                SizedBox(
                                  width: AppSize.s4,
                                ),
                                Text(
                                  homeProvider.doctors.users[index].name,
                                  style: getRegularStyle(
                                      color: ColorManager.white,
                                      fontSize: Sizer.getW(context) / 26),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ));
                  } else {
                    return  Expanded(
                      child: SvgPicture.asset(
                        ImagesAssets.noDataFound,
                      ),
                    );
                  }
                } else {
                  return Text('State: ${snapshot.connectionState}');
                }
              },
            );

             })
          ],
        );
      }),
    );
  }

  fetchNameUser(context, String idUser, homeProvider) async {
    return FutureBuilder(
      future: homeProvider.fetchNameUser(context, idUser: idUser),
      builder: (
        context,
        snapshot,
      ) {
        print(snapshot.error);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Expanded(child: Const.SHOWLOADINGINDECATOR());
          //Const.CIRCLE(context);
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Text('Error');
          } else if (snapshot.hasData) {
            // Map<String,dynamic> data=snapshot.data as Map<String,dynamic>;
            //homeProvider.sessions=Sessions.fromJson(data['body']);
            return const Text('ok');
          } else {
            return const Text('Empty data');
          }
        } else {
          return Text('State: ${snapshot.connectionState}');
        }
      },
    );
    return await homeProvider.fetchNameUser(context, idUser: idUser);
  }
  /// temp soul
  circleWaitSessions(setState3){
    if(homeProvider.sessionsToUser.length<=0){
      return  SizedBox(
          height: Sizer.getH(context) / 2.35,
          child: Const.SHOWLOADINGINDECATOR());
    }else
    {
      return  StatefulBuilder(
        builder: (_, setState1) {
          return CarouselSlider(
              carouselController: _carouselController,
              options: CarouselOptions(
                  height: Sizer.getH(context) / 2.35,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.7,
                  enlargeCenterPage: true,
                  pageSnapping: true,
                  onPageChanged: (index, reason) {
                    setState1(() {
                      _current = index;
                      //print(index);
                    });
                  }),
              items: homeProvider.sessionsToUser.map((e) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: AppPadding.p12),
                  child: GestureDetector(
                    onTap: () {
                      if (homeProvider.sessionsToUser[homeProvider.sessionsToUser.indexOf(e)]
                          .isSold) {
                        setState1(() {
                          if (_selectedIndex == e) {
                            _selectedIndex = {};
                          } else {
                            _selectedIndex = e;
                          }
                        });
                      } else {
                        Get.defaultDialog(
                          confirm: Row(
                            children: [
                              TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor:
                                      Theme.of(context)
                                          .primaryColor),
                                  onPressed: () {
                                    paymentProvider.idGroup =
                                        e.idGroup;
                                    paymentProvider.setStat3 =
                                        setState3;
                                    Navigator.pop(context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                PaymentView()));
                                  },
                                  child: Text(
                                    tr(LocaleKeys.yes),
                                    style: getLightStyle(
                                        color:
                                        ColorManager.white,
                                        fontSize: Sizer.getW(
                                            context) /
                                            26),
                                  )),
                              const SizedBox(
                                width: AppSize.s8,
                              ),
                              TextButton(
                                  style: TextButton.styleFrom(
                                      primary:
                                      ColorManager.error,
                                      backgroundColor:
                                      ColorManager.error),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    tr(LocaleKeys.no),
                                    style: getLightStyle(
                                        color:
                                        ColorManager.white,
                                        fontSize: Sizer.getW(
                                            context) /
                                            26),
                                  )),
                            ],
                          ),
                          titleStyle: getBoldStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .color,
                              fontSize:
                              Sizer.getW(context) / 22),
                          title: tr(
                              LocaleKeys.this_session_is_paid),
                          content: Text(
                            tr(LocaleKeys.pay_and_join),
                            style: getRegularStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                                fontSize:
                                Sizer.getW(context) / 24),
                          ),
                          radius: AppSize.s14,
                        );
                      }
                    },
                    child: Stack(
                        alignment: Alignment.center,
                        children: [
                          AnimatedContainer(
                              duration:
                              const Duration(milliseconds: 300),
                              width:
                              MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color:
                                  Theme.of(context).cardColor,
                                  borderRadius:
                                  BorderRadius.circular(
                                      AppSize.s8),
                                  border: _selectedIndex == e
                                      ? Border.all(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color!,
                                      width: 2)
                                      : null,
                                  boxShadow: _selectedIndex == e
                                  ? [
                                  BoxShadow(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(.8),
                                    blurRadius: 8,
                                  )
                                  ]
                                      : [
                              BoxShadow(
                              color: Colors.grey
                                  .withOpacity(0.2),
                              blurRadius: 8,
                              offset: Offset(0, 5))
                        ]),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin:
                            const EdgeInsets.all(10),
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(
                                  AppSize.s20),
                            ),
                            child: SvgPicture.asset(
                                ImagesAssets
                                    .imagesInteractiveSessions[
                                homeProvider
                                    .sessionsToUser
                                    .indexOf(e)],
                                fit: BoxFit.fill),
                          ),
                        ),
                        if (homeProvider
                            .sessionsToUser[homeProvider
                            .sessionsToUser
                            .indexOf(e)]
                            .isSold)
                          Text(e.name,
                              style: getRegularStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                  fontSize: Sizer.getW(
                                      context) /
                                      24)),
                        _selectedIndex == e
                            ? ZoomIn(
                          child: Padding(
                            padding:
                            const EdgeInsets
                                .symmetric(
                                horizontal:
                                AppPadding
                                    .p10),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                FutureBuilder(
                                  future: homeProvider
                                      .fetchNameUser(
                                      context,
                                      idUser: e
                                          .doctorName),
                                  builder: (
                                      context,
                                      snapshot,
                                      ) {
                                    print(snapshot
                                        .error);
                                    if (snapshot
                                        .connectionState ==
                                        ConnectionState
                                            .waiting) {
                                      return Expanded(
                                          child: Const
                                              .SHOWLOADINGINDECATOR());
                                      //Const.CIRCLE(context);
                                    } else if (snapshot
                                        .connectionState ==
                                        ConnectionState
                                            .done) {
                                      if (snapshot
                                          .hasError) {
                                        return const Text(
                                            'Error');
                                      } else if (snapshot
                                          .hasData) {
                                        // Map<String,dynamic> data=snapshot.data as Map<String,dynamic>;
                                        //homeProvider.sessions=Sessions.fromJson(data['body']);
                                        return Text(
                                          "${tr(LocaleKeys.
                                          specialist)}:${snapshot.data}",
                                          style: getBoldStyle(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .color,
                                              fontSize:
                                              Sizer.getW(context) / 24),
                                        );
                                      } else {
                                        return const Text(
                                            'Empty data');
                                      }
                                    } else {
                                      return Text(
                                          'State: ${snapshot.connectionState}');
                                    }
                                  },
                                ),
                                TextButton(
                                    style: TextButton
                                        .styleFrom(
                                      backgroundColor:
                                      Theme.of(
                                          context)
                                          .primaryColor,
                                    ),
                                    onPressed:
                                        () async {
                                      await homeProvider
                                          .goToUrl(
                                          context,
                                          e.id_link);
                                    },
                                    child: Text(
                                      tr(LocaleKeys
                                          .go),
                                      style: getRegularStyle(
                                          color: ColorManager.white,
                                          fontSize:
                                          Sizer.getW(context) /
                                              30),
                                    ))
                              ],
                            ),
                          ),
                        )
                            : SizedBox()
                      ],
                    ),
                  ),
                  (!homeProvider
                      .sessionsToUser[homeProvider
                      .sessionsToUser
                      .indexOf(e)]
                      .isSold)
                      ? Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                        color: ColorManager
                            .blackGray
                            .withOpacity(.6),
                        borderRadius:
                        BorderRadius.circular(
                            AppSize.s14)),
                    child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.lock,
                          size:
                          Sizer.getH(context) *
                              0.15,
                        ),
                        Container(
                          margin:
                          const EdgeInsets.all(
                              AppMargin.m8),
                          padding:
                          const EdgeInsets.all(
                              AppPadding.p4),
                          width: double.infinity,
                          height:
                          Sizer.getW(context) *
                              0.2,
                          decoration: BoxDecoration(
                              color: Theme.of(
                                  context)
                                  .cardColor,
                              borderRadius:
                              BorderRadius
                                  .circular(
                                  AppSize
                                      .s14)),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment
                                .spaceEvenly,
                            children: [
                              Text(
                                " ${tr(LocaleKeys.price)} ${e.price} \$",
                                style: getLightStyle(
                                    color: Theme.of(
                                        context)
                                        .textTheme
                                        .bodyText1!
                                        .color,
                                    fontSize:
                                    Sizer.getW(
                                        context) /
                                        26),
                              ),
                              const Text("|"),
                              FutureBuilder(
                                future: homeProvider
                                    .fetchNameUser(
                                    context,
                                    idUser: e
                                        .doctorName),
                                builder: (
                                    context,
                                    snapshot,
                                    ) {
                                  print(snapshot
                                      .error);
                                  if (snapshot
                                      .connectionState ==
                                      ConnectionState
                                          .waiting) {
                                    return Expanded(
                                        child: Const
                                            .SHOWLOADINGINDECATOR());
                                    //Const.CIRCLE(context);
                                  } else if (snapshot
                                      .connectionState ==
                                      ConnectionState
                                          .done) {
                                    if (snapshot
                                        .hasError) {
                                      return const Text(
                                          'Error');
                                    } else if (snapshot
                                        .hasData) {
                                      // Map<String,dynamic> data=snapshot.data as Map<String,dynamic>;
                                      //homeProvider.sessions=Sessions.fromJson(data['body']);
                                      return Flexible(
                                        child: Text(
                                          "${snapshot.data}",
                                          // overflow: TextOverflow.ellipsis,
                                          //"${ fetchNameUser(context,e.doctorName,homeProvider)}",
                                          style: getLightStyle(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .color,
                                              fontSize:
                                              Sizer.getW(context) /
                                                  24),
                                        ),
                                      );
                                    } else {
                                      return const Text(
                                          'Empty data');
                                    }
                                  } else {
                                    return Text(
                                        'State: ${snapshot.connectionState}');
                                  }
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                      : SizedBox(),
                  ],
                ),
                ),
                );
              }).toList());
        },
      );
    }
  }
  circleWaitDoctors(setState2){
    if(homeProvider.doctors.users.length<=0){
      return Const.SHOWLOADINGINDECATOR();
    }else
    {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: homeProvider.doctors.users.length,
        itemBuilder: (_, index) {
          return InkWell(
            onTap: () async {
              // print(groupsProvider.groups.groups.length);
              //  print(profileProvider.paySession.toJson());
              // print("ame :${await homeProvider.fetchNameUser(context, idUser: profileProvider.user.id)}");
              print(homeProvider.sessionsToUser.length);
              // print(homeProvider.sessions.sessions.length);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => DoctorProfile(
                          doctor: homeProvider
                              .doctors.users[index])));
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.p10),
              margin: EdgeInsets.all(AppMargin.m4),
              width: Sizer.getW(context) / 2,
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .primaryColor.withOpacity(.7),
                borderRadius: BorderRadius.circular(AppSize.s14),
                boxShadow: [
                  BoxShadow(
                      color:
                      ColorManager.blackGray.withOpacity(.3),
                      blurRadius: 4),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(context).cardColor,
                    radius: Sizer.getW(context) * 0.08,
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      width: Sizer.getW(context) * 0.14,
                      height: Sizer.getW(context) * 0.14,
                      imageUrl:
                      // "${AppUrl.baseUrlImage}${widget.restaurant.imageLogo!}",
                      "${homeProvider.doctors.users[index].photoUrl}",
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
                    //FlutterLogo(),
                  ),
                  SizedBox(
                    width: AppSize.s4,
                  ),
                  Text(
                    homeProvider.doctors.users[index].name,
                    style: getRegularStyle(
                        color: ColorManager.white,
                        fontSize: Sizer.getW(context) / 26),
                  )
                ],
              ),
            ),
          );
        },
      );
    }
  }
///
}
