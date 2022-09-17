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
import '../../../../model/utils/sizer.dart';
import '../list_sessions/list_sessions_view.dart';


class CreateSessionsView extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final link = TextEditingController();
  final sessionName = TextEditingController();
  final sessionDate = TextEditingController();
  final sessionTime = TextEditingController();
  final sessionGroup = TextEditingController();
  final sessionDoctor = TextEditingController();
  final price = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(tr(LocaleKeys.create_session)),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (ctx)=>ListSessionsView(
              sessions: [
                InteractiveSessions(
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
            key: formKey,
            child: Column(
              children: [
                SvgPicture.asset(
                  ImagesAssets.backgroundSessionInteractive,
                  height: Sizer.getW(context) * 0.5,
                ),
                SizedBox(height: AppSize.s10,),
                CustomTextFiled(
                    controller: sessionName,
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
                    controller: link,
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
                    items: List.generate(4, (index) => DropdownMenuItem(
                      child: Text("Groups" + index.toString()),
                      value: index,
                    )),
                    onChanged: (val){
                      sessionGroup.text = val.toString();
                    }
                ),
                SizedBox(height: AppSize.s10,),
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
                    items: List.generate(100, (index) => DropdownMenuItem(
                      child: Text("Doctor" + index.toString()),
                      value: index,
                    )),
                    onChanged: (val){
                      sessionDoctor.text = val.toString();
                    }
                ),
                SizedBox(height: AppSize.s10,),
                Row(
                  children: [
                    Expanded(child:CustomTextFiled(
                        readOnly: true,
                        onTap: ()async{
                          await _selectDate(context);
                        },
                        controller: sessionDate,
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
                        controller: sessionTime,
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
                    controller: price,
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
                ButtonApp(text: tr(LocaleKeys.create_session), onTap: (){
                  if(formKey.currentState!.validate()){

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
      sessionDate
        ..text = DateFormat.yMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: sessionDate.text.length,
            affinity: TextAffinity.upstream));
    }
  }
  _selectTime(TimeOfDay time,BuildContext context) async {
    _selectedTime = time;
    sessionTime.text =  _selectedTime.format(
      context,
    );
    }


}
