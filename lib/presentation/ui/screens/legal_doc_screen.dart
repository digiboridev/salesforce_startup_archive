import 'package:***REMOVED***/core/assets.dart';
import 'package:***REMOVED***/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LegalDocScreen extends StatefulWidget {
  const LegalDocScreen(
      {Key? key,
      required this.legalDocLink,
      required this.callback,
      required this.buttonText})
      : super(key: key);

  final Uri legalDocLink;
  final Function callback;
  final String buttonText;

  @override
  State<LegalDocScreen> createState() => _LegalDocScreenState();
}

class _LegalDocScreenState extends State<LegalDocScreen> {
  WebViewController? webViewController;
  bool error = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.blue_003E7E,
      body: SafeArea(
          child: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildHeader(),
                SizedBox(
                  height: Get.width * 0.1,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                    child: Text(
                      'Terms of Use'.tr,
                      style: TextStyle(
                              color: MyColors.blue_003E7E,
                              fontSize: 26,),
                    )),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.all(Get.width * 0.06),
                  child: WebView(
                    zoomEnabled: false,
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: widget.legalDocLink.toString(),
                    onPageFinished: (url) {
                      print(url);
                    },
                    onPageStarted: (url) {
                      print(url);
                    },
                    onProgress: (progress) {
                      print(progress);
                    },
                    onWebResourceError: (e) {
                      print(e);
                      setState(() => error = true);
                    },
                    onWebViewCreated: (controller) {
                      webViewController = controller;
                    },
                  ),
                )),
                Container(height: Get.width*0.015,
                color: MyColors.white_F4F4F6,
                width: Get.width,),
                GestureDetector(
                  onTap: () => widget.callback(),
                  child: Container(
                    width: Get.width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: MyColors.blue_00458C,
                        borderRadius: BorderRadius.circular(Get.width * 0.06)),
                    padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.3,
                        vertical: Get.width * 0.03),
                    margin: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.1,
                        vertical: Get.width * 0.03),
                    child: Text(
                      widget.buttonText.tr,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            if (error)
              Positioned(
                right: Get.width * 0.06,
                bottom: Get.width * 0.3,
                child: GestureDetector(
                  onTap: () {
                    if (webViewController != null) {
                      setState(() => error = false);
                      webViewController!.reload();
                    }
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue[200],
                          borderRadius:
                              BorderRadius.circular(Get.width * 0.06)),
                      padding: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.03,
                          vertical: Get.width * 0.03),
                      child: Icon(Icons.replay_rounded)),
                ),
              )
          ],
        ),
      )),
    );
  }

  Container buildHeader() {
    return Container(
      height: Get.width * 0.3,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [MyColors.blue_0D63BB, MyColors.blue_00458C])),
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
      child: Column(
        children: [
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Directionality.of(context) ==
                      TextDirection.rtl ?
                  Icons.keyboard_arrow_right
                      : Icons.keyboard_arrow_left,
                  color: Colors.white,
                ),
              ),

              Hero(
                tag: 'logo',
                child: Image.asset(
                  AssetImages.***REMOVED***Logo,
                  width: Get.width * 0.3,
                ),
              ),

              Hero(
                tag: 'contact_btn',
                child: Image.asset(
                  AssetImages.contactButton,
                  width: Get.width * 0.05,
                ),
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}
