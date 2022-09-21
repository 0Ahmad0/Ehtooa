
import 'package:ehtooa/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../view/resources/color_manager.dart';
import '../../view/resources/style_manager.dart';
import '../../view/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../view/widgets/custome_button.dart';
import 'sizer.dart';

class Const{
  static LOADIG(context){
    Get.dialog(Center(
      child: Container(
          alignment: Alignment.center,
          width: Sizer.getW(context) * 0.2,
          height: Sizer.getW(context) * 0.2,
          decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(AppSize.s8)),
          child: LoadingAnimationWidget.waveDots(
              color: ColorManager.primary,
              size: Sizer.getW(context) * 0.1)),
    ));
  }



  static TOAST(BuildContext context,{String textToast = "This Is Toast"}){
    showToast(
        textToast,
      context: context,
    animation:StyledToastAnimation.fadeScale,
      textStyle: getRegularStyle(color: ColorManager.white)
    );

  }

   static SHOWRATEDIALOOG(BuildContext context){
      Get.dialog(

        Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: AppMargin.m10,
                  vertical: AppMargin.m20),
              padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.p20,
                  vertical: AppPadding.p10),
              width: Sizer.getW(context),
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius:
                  BorderRadius.circular(AppSize.s14)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: AppSize.s30,),
                  Text(
                    tr(LocaleKeys.rate),
                    style: getRegularStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color,
                        fontSize: Sizer.getW(context) * 0.045
                    ),
                  ),
                  const SizedBox(height: AppSize.s40,),
                  RatingBar.builder(
                      initialRating: 3,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            return Icon(
                              Icons.sentiment_very_dissatisfied,
                              color: Colors.red,
                            );
                          case 1:
                            return Icon(
                              Icons.sentiment_dissatisfied,
                              color: Colors.redAccent,
                            );
                          case 2:
                            return Icon(
                              Icons.sentiment_neutral,
                              color: Colors.amber,
                            );
                          case 3:
                            return Icon(
                              Icons.sentiment_satisfied,
                              color: Colors.lightGreen,
                            );
                          case 4:
                            return Icon(
                              Icons.sentiment_very_satisfied,
                              color: Colors.green,
                            );
                        }
                        return SizedBox();
                      },
                      onRatingUpdate: (rating) {
                        print(rating);

                      }
                  ),
                  const SizedBox(height: AppSize.s20,),
                  ButtonApp(
                    text: tr(LocaleKeys.ok),
                    onTap: (){
                      Navigator.pop(context);
                      Const.TOAST(context,textToast: tr(LocaleKeys.thanks_for_rate));
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

  static SHOWDELETEDIALOOG(BuildContext context){
    Get.dialog(

      Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            margin: const EdgeInsets.symmetric(
                horizontal: AppMargin.m10,
                vertical: AppMargin.m20),
            padding: EdgeInsets.symmetric(
                horizontal: AppPadding.p20,
                vertical: AppPadding.p10),
            width: Sizer.getW(context),
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius:
                BorderRadius.circular(AppSize.s14)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: AppSize.s30,),
                Text(
                  tr(LocaleKeys.delete),
                  style: getRegularStyle(
                      color: Theme.of(context).textTheme.bodyText1!.color,
                      fontSize: Sizer.getW(context) * 0.045
                  ),
                ),
                const SizedBox(height: AppSize.s40,),
                Row(
                  children: [
                    ButtonApp(
                      text: tr(LocaleKeys.ok),
                      onTap: (){
                        Navigator.pop(context);
                        Const.TOAST(context,textToast: tr(LocaleKeys.rate));
                      },
                    ),
                    ButtonApp(
                      text: tr(LocaleKeys.no),
                      onTap: (){
                        Navigator.pop(context);
                        Const.TOAST(context,textToast: tr(LocaleKeys.rate));
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

    static SHOWLOADINGINDECATOR(){
      return Center(
        child: CircularProgressIndicator(
        ),
      );
    }

}