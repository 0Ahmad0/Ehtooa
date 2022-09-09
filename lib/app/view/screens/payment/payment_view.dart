import 'dart:async';

import 'package:ehtooa/app/model/utils/const.dart';
import 'package:ehtooa/app/view/resources/assets_manager.dart';
import 'package:ehtooa/app/view/resources/consts_manager.dart';
import 'package:ehtooa/app/view/resources/style_manager.dart';
import 'package:ehtooa/app/view/resources/values_manager.dart';
import 'package:ehtooa/app/view/widgets/custome_textfiled.dart';
import 'package:ehtooa/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../model/utils/sizer.dart';
import '../../resources/color_manager.dart';
import '../../widgets/custome_button.dart';
class PaymentView extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final cardNumber = TextEditingController();
  final dateCard = TextEditingController(text: "${
      DateFormat.yM().format(DateTime.now())
  }");
  final cvv = TextEditingController();
  final name = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(LocaleKeys.payment)),
      ),
      body: Form(
        key: formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: Sizer.getW(context)/2,
                  padding: const EdgeInsets.only(
                      right: AppSize.s40
                  ),
                  child: SvgPicture.asset(
                      "assets/images/payment_back1.svg",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.p20,
                      vertical: AppPadding.p10
                  ),
                  child: Column(
                    children: [
                      CustomTextFiled(
                        maxLength: null,
                          controller: cardNumber,
                          validator: (String? val){
                            if(val!.trim().isEmpty){
                              return tr(LocaleKeys.field_required);
                            }else if(val.length != 16){
                              return tr(LocaleKeys.valid_card_number);
                            }else{
                              return null;
                            }
                          },
                          onChange: (val){},
                          prefixIcon: Icons.chrome_reader_mode,
                          hintText: tr(LocaleKeys.card_number)
                      ),
                      const SizedBox(height: AppSize.s10,),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFiled(
                                maxLength: null,
                                controller: cvv,
                                textInputType: TextInputType.number,
                                validator: (String? val){
                                  if(val!.trim().isEmpty){
                                    return tr(LocaleKeys.field_required);
                                  }else if(val.length != 3){
                                    return tr(LocaleKeys.valid_cvv);
                                  }else{
                                    return null;
                                  }
                                },
                                onChange: (val){},
                                prefixIcon: Icons.numbers,
                                hintText: tr(LocaleKeys.cvv)
                            ),
                          ),
                          const SizedBox(width: AppSize.s8,),
                          Expanded(
                            child: CustomTextFiled(
                              onTap: ()async{
                                await _selectDate(context);
                              },
                              readOnly: true,
                                maxLength: null,
                                controller: dateCard,
                                validator: (String? val){
                                  if(val!.trim().isEmpty){
                                    return tr(LocaleKeys.field_required);
                                  }
                                  else{
                                    return null;
                                  }
                                },
                                onChange: (val){},
                                prefixIcon: Icons.date_range,
                                hintText: tr(LocaleKeys.expiry)
                            ),
                          ),

                        ],
                      ),
                      const SizedBox(height: AppSize.s10,),
                      CustomTextFiled(
                          maxLength: null,
                          textInputAction: TextInputAction.done,
                          controller: name,
                          validator: (String? val){
                            if(val!.trim().isEmpty){
                              return tr(LocaleKeys.field_required);
                            }else {
                              return null;
                            }
                          },
                          onChange: (val){},
                          prefixIcon: Icons.person,
                          hintText: tr(LocaleKeys.name)
                      ),
                      const SizedBox(height: AppSize.s10,),
                      ButtonApp(
                        text: tr(LocaleKeys.payment),
                        onTap: (){
                          Const.LOADIG(context);
                          Timer(
                            Duration(seconds: AppConstants.splashDelay - 4),
                              (){
                              Navigator.pop(context);
                              Get.defaultDialog(
                                radius: AppSize.s14,
                                title: tr(LocaleKeys.done_payment),
                                titleStyle: getBoldStyle(
                                    color: Theme.of(context).textTheme.bodyText1!.color,
                                  fontSize: Sizer.getW(context) /20
                                ),
                                content: SvgPicture.asset(
                                    ImagesAssets.paymentDone,
                                  width: Sizer.getW(context)*0.35,
                                  height: Sizer.getW(context)*0.35,
                                ),
                                confirm:  TextButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor: Theme.of(context).primaryColor,
                                      minimumSize: Size(double.infinity, 60),

                                    ),
                                    onPressed: (){
                                      Navigator.pop(context);
                                    }, child: Text(
                                  tr(LocaleKeys.ok),
                                  style: getLightStyle(
                                      color: ColorManager.white,
                                      fontSize: Sizer.getW(context) / 26
                                  ),
                                ))
                              );
                              }
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  _selectDate(BuildContext context) async {
    var newSelectedDate = await showDatePicker(
      builder: (context, child) {
        return child!;
      },
      context: context,
      initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2027),
    );

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      dateCard
        ..text = DateFormat.yM().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: dateCard.text.length,
            affinity: TextAffinity.upstream)
        );
    }
  }
}
