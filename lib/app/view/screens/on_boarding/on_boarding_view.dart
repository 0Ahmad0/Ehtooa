import 'package:ehtooa/app/controller/on_boarding_provider.dart';
import 'package:ehtooa/app/model/utils/local/change_theme.dart';
import 'package:ehtooa/app/model/utils/sizer.dart';
import 'package:ehtooa/app/view/resources/assets_manager.dart';
import 'package:ehtooa/app/view/resources/color_manager.dart';
import 'package:ehtooa/app/view/resources/consts_manager.dart';
import 'package:ehtooa/app/view/resources/style_manager.dart';
import 'package:ehtooa/app/view/resources/theme_manager.dart';
import 'package:ehtooa/app/view/resources/values_manager.dart';
import 'package:ehtooa/app/view/screens/login/login_view.dart';
import 'package:ehtooa/app/view/widgets/custome_button.dart';
import 'package:ehtooa/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingView extends StatelessWidget {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OnBoardingProvider>(
        create: (_) => OnBoardingProvider(),
        child: Consumer<OnBoardingProvider>(builder: (ctx, onBoarding, child) {
          return Scaffold(
              body: Container(
                  padding: EdgeInsets.only(bottom: AppSize.s80),
                  child: PageView.builder(
                    itemCount: onBoarding.onBoardingList.length,
                    onPageChanged: (index) {
                      onBoarding.isLastIndex(index);
                      print("hh${onBoarding.isLastPage}");
                    },
                    controller: controller,
                    itemBuilder: (_, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FadeInUp(
                              child: SvgPicture.asset(
                                  onBoarding.onBoardingList[index].image)),
                          SizedBox(
                            height: AppSize.s20,
                          ),
                          Text(
                            tr(onBoarding.onBoardingList[index].text),
                            textAlign: TextAlign.center,
                            style: getRegularStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color,
                                fontSize: Sizer.getW(context) / 18),
                          )
                        ],
                      );
                    },
                  )),
              bottomSheet: onBoarding.isLastPage
                  ? TextButton(
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          primary: Theme.of(context).textTheme.bodySmall!.color,
                          backgroundColor: Theme.of(context).primaryColor,
                          minimumSize: Size.fromHeight(AppSize.s80)),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (ctx) => LoginView()));
                      },
                      child: Text(
                        tr(LocaleKeys.get_started),
                        style: getRegularStyle(
                            color: Theme.of(context).textTheme.bodyText1!.color,
                            fontSize: Sizer.getW(context) / 22
                        ),
                      ))
                  : Container(
                      height: AppSize.s80,
                      padding: EdgeInsets.symmetric(horizontal: AppPadding.p8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () => controller.jumpToPage(2),
                              child: Text(tr(LocaleKeys.skip),style: getLightStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: Sizer.getW(context) / 24
                              ),)),
                          Center(
                            child: SmoothPageIndicator(
                              effect: SwapEffect(
                                  activeDotColor:
                                      Theme.of(context).primaryColor,
                                  dotWidth: AppSize.s12,
                                  dotHeight: AppSize.s12,
                                  type: SwapType.yRotation),
                              controller: controller,
                              count: 3,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                controller.nextPage(
                                    duration: Duration(
                                        milliseconds:
                                            AppConstants.onBoardingDelay),
                                    curve: Curves.easeInOut);
                              },
                              child: Text(tr(LocaleKeys.next),style: getLightStyle(
                                  color: Theme.of(context).primaryColor,
                                fontSize: Sizer.getW(context) / 24
                              ),
                              ))
                        ],
                      ),
                    ));
        }));
  }
}
