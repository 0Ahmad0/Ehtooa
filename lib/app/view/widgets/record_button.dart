
import 'dart:async';
import 'dart:io';

import 'package:ehtooa/app/model/utils/sizer.dart';
import 'package:ehtooa/app/view/resources/values_manager.dart';
import 'package:ehtooa/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:record/record.dart';
import 'package:easy_localization/easy_localization.dart';
import '../resources/audio_state.dart';
import '../resources/color_manager.dart';
import '../resources/globals.dart';
import '../resources/style_manager.dart';
import 'flow_shader.dart';
import 'lottie_animation.dart';

class RecordButton extends StatefulWidget {
  const RecordButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final AnimationController controller;

  @override
  State<RecordButton> createState() => _RecordButtonState();
}

class _RecordButtonState extends State<RecordButton> {
  static const double size = 55;

  final double lockerHeight = 200;
  double timerWidth = 0;

  late Animation<double> buttonScaleAnimation;
  late Animation<double> timerAnimation;
  late Animation<double> lockerAnimation;

  DateTime? startTime;
  Timer? timer;
  String recordDuration = "00:00";
  late Record record;

  bool isLocked = false;
  bool showLottie = false;

  @override
  void initState() {
    super.initState();
    buttonScaleAnimation = Tween<double>(begin: 1, end: 2).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticInOut),
      ),
    );
    widget.controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    timerWidth =
        MediaQuery.of(context).size.width - 2 * Globals.defaultPadding - 4;
    timerAnimation =
        Tween<double>(begin: timerWidth + Globals.defaultPadding, end: 0)
            .animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: const Interval(0.2, 1, curve: Curves.easeIn),
      ),
    );
    lockerAnimation =
        Tween<double>(begin: lockerHeight + Globals.defaultPadding, end: 0)
            .animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: const Interval(0.2, 1, curve: Curves.easeIn),
      ),
    );
  }

  @override
  void dispose() {
    record.dispose();
    timer?.cancel();
    timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        lockSlider(),
        cancelSlider(),
        audioButton(),
        if (isLocked) timerLocked(),
      ],
    );
  }

  Widget lockSlider() {
    return Positioned(
      bottom: -lockerAnimation.value,
      child: Container(
        height: lockerHeight,
        width: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Globals.borderRadius),
          color: ColorManager.lightGray.withOpacity(.3),
        ),
        padding: const EdgeInsets.symmetric(vertical: AppPadding.p14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const FaIcon(FontAwesomeIcons.lock, size: AppSize.s20),
            const SizedBox(height: AppSize.s8),
            FlowShader(
              direction: Axis.vertical,
              child: Column(
                children: const [
                  Icon(Icons.keyboard_arrow_up),
                  Icon(Icons.keyboard_arrow_up),
                  Icon(Icons.keyboard_arrow_up),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cancelSlider() {
    return Positioned(
      right: -timerAnimation.value,
      child: Container(
        height: size,
        width: timerWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Globals.borderRadius),
          color: Theme.of(context).primaryColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              showLottie ? const LottieAnimation() : Text(recordDuration),
              const SizedBox(width: size),
              FlowShader(
                child: Row(
                  children:  [
                    Icon(Icons.keyboard_arrow_left),
                    Text(tr(LocaleKeys.slide_to_cancle),style:
                      getRegularStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color
                      )
                      ,)
                  ],
                ),
                duration: const Duration(seconds: 2),
                flowColors: const [Colors.white, Colors.grey],
              ),
              const SizedBox(width: size),
            ],
          ),
        ),
      ),
    );
  }

  Widget timerLocked() {
    return Container(
      height: size+AppSize.s6,
      width: timerWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Globals.borderRadius),
        color: ColorManager.lightGray,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 25),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () async {
            Vibrate.feedback(FeedbackType.success);
            timer?.cancel();
            timer = null;
            startTime = null;
            recordDuration = "00:00";
            var filePath = await Record().stop();
            AudioState.files.add(filePath!);
            Globals.audioListKey.currentState!
                .insertItem(AudioState.files.length - 1);
            debugPrint(filePath);
            setState(() {
              isLocked = false;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(recordDuration,style: getRegularStyle(
                color: Theme.of(context).textTheme.bodyText1!.color,
                fontSize: Sizer.getW(context) / 30
              ),),
              FlowShader(
                child:  Text(
                  tr(LocaleKeys.tab_to_stop),
                  style: getRegularStyle(
                    color: Theme.of(context).textTheme.bodyText1!.color,
                    fontSize: Sizer.getW(context) / 28
                  ),
                ),
                duration: const Duration(seconds: 2),
                flowColors: const [Colors.white, Colors.grey],
              ),
               Center(
                child: FaIcon(
                  Icons.send,
                  size: 18,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget audioButton() {
    return GestureDetector(
      child: Transform.scale(
        scale: buttonScaleAnimation.value,
        child: Container(
          child: const Icon(Icons.mic,color: ColorManager.white,),
          height: size,
          width: size,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      onLongPressDown: (_) {
        debugPrint("onLongPressDown");
        widget.controller.forward();
      },
      onLongPressEnd: (details) async {
        debugPrint("onLongPressEnd");

        if (isCancelled(details.localPosition, context)) {
          Vibrate.feedback(FeedbackType.heavy);

          timer?.cancel();
          timer = null;
          startTime = null;
          recordDuration = "00:00";

          setState(() {
            showLottie = true;
          });

          Timer(const Duration(milliseconds: 1440), () async {
            widget.controller.reverse();
            debugPrint("Cancelled recording");
            var filePath = await record.stop();
            debugPrint(filePath);
            File(filePath!).delete();
            debugPrint("Deleted $filePath");
            showLottie = false;
          });
        } else if (checkIsLocked(details.localPosition)) {
          widget.controller.reverse();

          Vibrate.feedback(FeedbackType.heavy);
          debugPrint("Locked recording");
          debugPrint(details.localPosition.dy.toString());
          setState(() {
            isLocked = true;
          });
        } else {
          widget.controller.reverse();

          Vibrate.feedback(FeedbackType.success);

          timer?.cancel();
          timer = null;
          startTime = null;
          recordDuration = "00:00";

          var filePath = await Record().stop();
          AudioState.files.add(filePath!);
          Globals.audioListKey.currentState!
              .insertItem(AudioState.files.length - 1);
          debugPrint(filePath);
        }
      },
      onLongPressCancel: () {
        debugPrint("onLongPressCancel");
        widget.controller.reverse();
      },
      onLongPress: () async {
        debugPrint("onLongPress");
        Vibrate.feedback(FeedbackType.success);
        if (await Record().hasPermission()) {
          record = Record();
          await record.start(
            path: Globals.documentPath +
                "audio_${DateTime.now().millisecondsSinceEpoch}.m4a",
            bitRate: 128000,
            samplingRate: 44100,
          );
          startTime = DateTime.now();
          timer = Timer.periodic(const Duration(seconds: 1), (_) {
            final minDur = DateTime.now().difference(startTime!).inMinutes;
            final secDur = DateTime.now().difference(startTime!).inSeconds % 60;
            String min = minDur < 10 ? "0$minDur" : minDur.toString();
            String sec = secDur < 10 ? "0$secDur" : secDur.toString();
            setState(() {
              recordDuration = "$min:$sec";
            });
          });
        }
      },
    );
  }

  bool checkIsLocked(Offset offset) {
    return (offset.dy < -35);
  }

  bool isCancelled(Offset offset, BuildContext context) {
    return (offset.dx < -(MediaQuery.of(context).size.width * 0.2));
  }
}
