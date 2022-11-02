import 'package:day_night_time_picker/lib/constants.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:ehtooa/app/model/models.dart';
import 'package:ehtooa/app/view/resources/assets_manager.dart';
import 'package:ehtooa/app/view/resources/values_manager.dart';
import 'package:ehtooa/app/view/widgets/custome_button.dart';
import 'package:ehtooa/app/view/widgets/custome_textfiled.dart';
import 'package:ehtooa/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../../controller/create_sessions_provider.dart';
import '../../../../controller/home_provider.dart';
import '../../../../controller/profile_provider.dart';
import '../../../../model/utils/const.dart';
import '../../../../model/utils/sizer.dart';
import '../../bottom_nav_bar/bottom_nav_bar_view.dart';
import '../list_sessions/list_sessions_view.dart';

import 'package:provider/provider.dart';

class CreateSessionsView extends StatelessWidget {
  var createSessionsProvider;
  /*
  final formKey = GlobalKey<FormState>();
  final link = TextEditingController();
  final sessionName = TextEditingController();
  final sessionDate = TextEditingController();
  final sessionTime = TextEditingController();
  final sessionGroup = TextEditingController();
  final sessionDoctor = TextEditingController();
  final price = TextEditingController();
  */
  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final homeProvider = Provider.of<HomeProvider>(context);
     createSessionsProvider = Provider.of<CreateSessionsProvider>(context);
    return  Scaffold(
      appBar: AppBar(
        title: Text(tr(LocaleKeys.create_session)),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (ctx)=>ListSessionsView(
              sessions: [
                InteractiveSessions(
                  idGroup: "idGroup",
                    name: "name",
                    id_link: "id_link",
                    isSold: true,
                    doctorName: "doctorName",
                    price: "price")
              ],
            )));
          }
              , icon: Icon(Icons.connected_tv))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p20,
            vertical: AppPadding.p10,
          ),
          child: Form(
            key: createSessionsProvider.formKey,
            child: Column(
              children: [
                SvgPicture.asset(
                  ImagesAssets.backgroundSessionInteractive,
                  height: Sizer.getW(context) * 0.5,
                ),
                SizedBox(height: AppSize.s10,),
                CustomTextFiled(
                    controller: createSessionsProvider.sessionName,
                    validator: (String? val){
                      if(val!.isEmpty){
                        return tr(LocaleKeys.field_required);
                      }
                      else{
                        return null;
                      }
                    },
                    onChange: (String? val){},
                    prefixIcon: Icons.numbers_rounded,
                    maxLength: null,
                    hintText: tr(LocaleKeys.session_name)
                ),
                SizedBox(height: AppSize.s10,),
                CustomTextFiled(
                    controller: createSessionsProvider.link,
                    validator: (String? val){
                      if(val!.isEmpty){
                        return tr(LocaleKeys.field_required);
                      }else if(!val.isURL){
                        return tr(LocaleKeys.valid_session);

                      }
                        else{
                        return null;
                      }
                    },
                    onChange: (String? val){},
                    prefixIcon: Icons.online_prediction,
                    maxLength: null,
                    hintText: tr(LocaleKeys.session_link)),
                SizedBox(height: AppSize.s10,),

                FutureBuilder(
                  future: homeProvider.fetchGroups(context),
                  builder: (
                      context, snapshot,) {
                    //  print(snapshot.error);
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return  DropdownButtonFormField(
                          validator: (val){
                            if(val == null){
                              return tr(LocaleKeys.field_required);
                            }
                          },
                          decoration: InputDecoration(
                              hintText: tr(LocaleKeys.session_group),
                              prefixIcon: Icon(Icons.groups)
                          ),
                          items: List.generate(0, (index) => DropdownMenuItem(
                            child: Text(""),
                            value: index,
                          )),
                          onChanged: (val){
                            createSessionsProvider.sessionGroup.text = val.toString();
                          }
                      );
                      //Const.CIRCLE(context);
                    } else if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return const Text('Error');
                      } else if (snapshot.hasData) {
                        Map<String,dynamic> data=snapshot.data as Map<String,dynamic>;
                        homeProvider.groups=Groups.fromJson(data['body']);
                        return
                          DropdownButtonFormField(
                              validator: (val){
                                if(val == null){
                                  return tr(LocaleKeys.field_required);
                                }
                              },
                              decoration: InputDecoration(
                                  hintText: tr(LocaleKeys.session_group),
                                  prefixIcon: Icon(Icons.groups)
                              ),
                              items: List.generate(homeProvider.groups.groups.length, (index) => DropdownMenuItem(
                                ///@Hariri Fixed Error DropDown
                                child: Flexible(child: Text(!(Advance.language)?homeProvider.groups.groups[index].nameAr:homeProvider.groups.groups[index].nameEn)),
                                value: index,
                              )),
                              onChanged: (val){
                                createSessionsProvider.sessionGroup.text = val.toString();
                              }
                          );
                      } else {
                        return const Text('Empty data');
                      }
                    } else {
                      return Text('State: ${snapshot.connectionState}');
                    }
                  },
                ),
                SizedBox(height: AppSize.s10,),
               FutureBuilder(
                  future: homeProvider.fetchDoctors(context),
                  builder: (
                      context, snapshot,) {
                    //  print(snapshot.error);
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return  DropdownButtonFormField(
                          validator: (val){
                            if(val == null){
                              return tr(LocaleKeys.field_required);
                            }
                          },
                          decoration: InputDecoration(
                              hintText: tr(LocaleKeys.session_doctor_name),
                              prefixIcon: Icon(FontAwesomeIcons.userDoctor)
                          ),
                          items: List.generate(0, (index) => DropdownMenuItem(
                            child: Text(""),
                            value: index,
                          )),
                          onChanged: (val){
                            createSessionsProvider.sessionDoctor.text = val.toString();
                          }
                      );
                      //Const.CIRCLE(context);
                    } else if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return const Text('Error');
                      } else if (snapshot.hasData) {
                        Map<String,dynamic> data=snapshot.data as Map<String,dynamic>;
                        homeProvider.doctors=Users.fromJson(data['body']);
                        return
                           DropdownButtonFormField(
                                  validator: (val){
                                    if(val == null){
                                      return tr(LocaleKeys.field_required);
                                    }
                                  },
                                  decoration: InputDecoration(
                                      hintText: tr(LocaleKeys.session_doctor_name),
                                      prefixIcon: Icon(FontAwesomeIcons.userDoctor)
                                  ),
                                  items: List.generate(homeProvider.doctors.users.length, (index) => DropdownMenuItem(
                                    child: Text(
                                        homeProvider.doctors.users[index].name,
                                      /**"Doctor" + index.toString()**/),
                                    value: index,
                                  )),
                                  onChanged: (val){
                                    createSessionsProvider.sessionDoctor.text = val.toString();
                                  }
                              );
                      } else {
                        return const Text('Empty data');
                      }
                    } else {
                      return Text('State: ${snapshot.connectionState}');
                    }
                  },
                ),

                SizedBox(height: AppSize.s10,),
                Row(
                  children: [
                    Expanded(child:CustomTextFiled(
                        readOnly: true,
                        onTap: ()async{
                          await _selectDate(context);
                        },
                        controller: createSessionsProvider.sessionDate,
                        validator: (String? val){
                          if(val!.isEmpty){
                            return tr(LocaleKeys.field_required);
                          }
                          else{
                            return null;
                          }
                        },
                        onChange: (String? val){},
                        prefixIcon: Icons.date_range,
                        maxLength: null,
                        hintText: tr(LocaleKeys.session_date)
                    )),
                    SizedBox(width: AppSize.s10,),
                    Expanded(child:CustomTextFiled(
                        readOnly: true,
                        onTap: ()async{
                          await  Navigator.of(context).push(
                            showPicker(
                              context: context,
                              value: _selectedTime,
                              onChange: (time){
                                _selectTime(time, context);
                              },
                              minuteInterval: MinuteInterval.FIVE,
                              is24HrFormat: false,
                            ),
                          );
                        },
                        controller: createSessionsProvider.sessionTime,
                        validator: (String? val){
                          if(val!.isEmpty){
                            return tr(LocaleKeys.field_required);
                          }
                          else{
                            return null;
                          }
                        },
                        onChange: (String? val){},
                        prefixIcon: Icons.timer,
                        maxLength: null,
                        hintText: tr(LocaleKeys.session_time)
                    )),

                  ],
                ),
                SizedBox(height: AppSize.s10,),
                CustomTextFiled(
                    controller: createSessionsProvider.price,
                    validator: (String? val){
                      if(val!.isEmpty){
                        return tr(LocaleKeys.field_required);
                      }
                      else{
                        return null;
                      }
                    },
                    onChange: (String? val){},
                    prefixIcon: Icons.monetization_on,
                    maxLength: null,
                    textInputType: TextInputType.number,
                    hintText: tr(LocaleKeys.price)),
                SizedBox(height: AppSize.s10,),
                ButtonApp(text: tr(LocaleKeys.create_session), onTap: () async {
                  //print(int.parse(createSessionsProvider.sessionGroup.text));
                 // print(homeProvider.groups.groups[int.parse(createSessionsProvider.sessionGroup.text)].id);
                  if(createSessionsProvider.formKey.currentState!.validate()){
                    Const.LOADIG(context);
                    final result =await createSessionsProvider.createSession(context, idAmin: profileProvider.user.id,
                        idDoctor: homeProvider.doctors.users[int.parse(createSessionsProvider.sessionDoctor.text)].id,
                        idGroup: homeProvider.groups.groups[int.parse(createSessionsProvider.sessionGroup.text)].id);
                    Navigator.of(context).pop();
                    if(result['status']){
                      createSessionsProvider.clean();
                      homeProvider.setState3((){});
                      Navigator.of(context).pop();
                    }
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  _selectDate(BuildContext context) async {
    var newSelectedDate = await showDatePicker(
      builder: (context, child) {
        return child!;
      },
      context: context,
      initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2040),
    );

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      createSessionsProvider.date= newSelectedDate;
      createSessionsProvider.sessionDate
        ..text = DateFormat.yMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: createSessionsProvider.sessionDate.text.length,
            affinity: TextAffinity.upstream));
    }
  }
  _selectTime(TimeOfDay time,BuildContext context) async {
    _selectedTime = time;
    createSessionsProvider.time= time;
    createSessionsProvider.sessionTime.text=  _selectedTime.format(context);
    }


}
