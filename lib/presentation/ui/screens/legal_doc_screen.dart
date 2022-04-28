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
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Stack(
        children: [
          Column(
            children: [
              buildHeader(),
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
              GestureDetector(
                onTap: () => widget.callback(),
                child: Container(
                  width: Get.width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Color(0xff00458C),
                      borderRadius: BorderRadius.circular(Get.width * 0.06)),
                  padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.3, vertical: Get.width * 0.03),
                  margin: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.1, vertical: Get.width * 0.03),
                  child: Text(
                    widget.buttonText,
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
                        borderRadius: BorderRadius.circular(Get.width * 0.06)),
                    padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.03,
                        vertical: Get.width * 0.03),
                    child: Icon(Icons.replay_rounded)),
              ),
            )
        ],
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
              colors: [Color(0xff0D63BB), Color(0xff00458C)])),
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
      child: Column(
        children: [
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Hero(
                tag: 'contact_btn',
                child: Image.asset(
                  'assets/icons/contact.png',
                  width: Get.width * 0.05,
                ),
              ),
              Hero(
                tag: 'logo',
                child: Image.asset(
                  'assets/images/***REMOVED***_logo.png',
                  width: Get.width * 0.3,
                ),
              ),
              GestureDetector(
                onTap: () => widget.callback(),
                child: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.white,
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
