import 'package:salesforce.startup/core/asset_images.dart';
import 'package:salesforce.startup/core/mycolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LegalDocScreen extends StatefulWidget {
  const LegalDocScreen({Key? key, required this.legalDocLink, required this.callback, required this.buttonText}) : super(key: key);

  final Uri legalDocLink;
  final Future Function() callback;
  final String buttonText;

  @override
  State<LegalDocScreen> createState() => _LegalDocScreenState();
}

class _LegalDocScreenState extends State<LegalDocScreen> {
  WebViewController? webViewController;
  bool error = false;
  bool processing = false;

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
                      style: TextStyle(color: MyColors.blue_003E7E, fontSize: Get.width * 0.07, fontWeight: FontWeight.w500),
                    )),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
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
                Container(
                  height: Get.width * 0.015,
                  color: MyColors.white_F4F4F6,
                  width: Get.width,
                ),
                GestureDetector(
                  onTap: () async {
                    if (processing) return;
                    setState(() => processing = true);
                    await widget.callback();
                    setState(() => processing = false);
                  },
                  child: Container(
                    width: Get.width,
                    height: Get.width * 0.12,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: MyColors.blue_00458C, borderRadius: BorderRadius.circular(Get.width * 0.06)),
                    margin: EdgeInsets.symmetric(horizontal: Get.width * 0.05, vertical: Get.width * 0.05),
                    child: processing
                        ? CircularProgressIndicator()
                        : Text(
                            widget.buttonText.tr,
                            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: Get.width * 0.04),
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
                      decoration: BoxDecoration(color: Colors.blue[200], borderRadius: BorderRadius.circular(Get.width * 0.06)),
                      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03, vertical: Get.width * 0.03),
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
      height: Get.width * 0.25,
      decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [MyColors.blue_0D63BB, MyColors.blue_00458C])),
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
      child: Column(
        children: [
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'logo',
                child: Image.asset(
                  AssetImages.startupLogo,
                  width: Get.width * 0.25,
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
