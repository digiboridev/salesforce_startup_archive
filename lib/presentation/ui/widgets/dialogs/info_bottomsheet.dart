import 'dart:ui';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salesforce.startup/core/mycolors.dart';

class InfoAction extends Equatable {
  final String text;
  final Function callback;
  InfoAction({
    required this.text,
    required this.callback,
  });

  @override
  List<Object> get props => [text, callback];

  @override
  String toString() => 'InfoAction(text: $text, callback: $callback)';
}

class InfoBottomSheet extends StatelessWidget {
  final String headerIconPath;
  final List<InfoAction> actions;
  final bool withCloseBtn;
  final String headerText;
  final String mainText;
  const InfoBottomSheet(
      {Key? key, required this.actions, required this.headerIconPath, required this.headerText, required this.mainText, this.withCloseBtn = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.width * (withCloseBtn ? 0.9 : 0.75),
      width: Get.width,
      child: Stack(
        children: [
          BackdropFilter(filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), child: Container()),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (withCloseBtn)
                  GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        height: Get.width * 0.1,
                        width: Get.width * 0.1,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                        child: Icon(
                          Icons.clear,
                          color: MyColors.gray_979797,
                        ),
                      )),
                if (withCloseBtn)
                  SizedBox(
                    height: Get.width * 0.05,
                  ),
                SizedBox(
                  height: Get.width * 0.115,
                ),
                Expanded(
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            opacity: 1, fit: BoxFit.fitWidth, alignment: Alignment.topCenter, image: AssetImage('assets/images/bottombar.png'))),
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            top: Get.width * (withCloseBtn ? 0.15 : 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Get.width * 0.16,
                  height: Get.width * 0.16,
                  decoration: BoxDecoration(
                    color: MyColors.blue_003E7E,
                    borderRadius: BorderRadius.circular(Get.width * 0.16),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(Get.width * 0.035),
                    child: Image.asset(
                      headerIconPath,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
              top: Get.width * 0.22,
              child: Container(
                // color: Colors.red,
                child: Column(
                  children: [
                    if (withCloseBtn)
                      SizedBox(
                        height: Get.width * 0.15,
                      ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
                      child: Text(
                        headerText,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade,
                        style: TextStyle(color: MyColors.blue_003E7E, fontWeight: FontWeight.w600, fontSize: Get.width * 0.06),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
                        child: Text(
                          mainText,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.fade,
                          style: TextStyle(color: MyColors.blue_003E7E, fontWeight: FontWeight.w400, fontSize: Get.width * 0.05),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.width * 0.06,
                    ),
                    if (actions.length == 1)
                      GestureDetector(
                        onTap: () => actions.first.callback(),
                        child: Container(
                            width: Get.width * 0.75,
                            padding: EdgeInsets.symmetric(
                              vertical: Get.width * 0.025,
                            ),
                            decoration: BoxDecoration(color: MyColors.blue_003E7E, borderRadius: BorderRadius.circular(Get.width * 0.06)),
                            alignment: Alignment.center,
                            child: Text(actions.first.text, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: Get.width * 0.05))),
                      ),
                    if (actions.length > 1)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: actions.map((e) {
                          return GestureDetector(
                            onTap: () => e.callback(),
                            child: Container(
                                width: Get.width * 0.35,
                                padding: EdgeInsets.symmetric(
                                  vertical: Get.width * 0.025,
                                ),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(color: MyColors.blue_003E7E, borderRadius: BorderRadius.circular(Get.width * 0.06)),
                                child: Text(e.text, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: Get.width * 0.05))),
                          );
                        }).toList(),
                      ),
                    SizedBox(
                      height: Get.width * 0.06,
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
