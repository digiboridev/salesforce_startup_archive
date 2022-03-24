import 'package:***REMOVED***/domain/services/connections_service.dart';
import 'package:***REMOVED***/presentation/controllers/user_data_controller.dart';
import 'package:***REMOVED***/presentation/controllers/user_data_controller_states.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LegalDocView extends StatefulWidget {
  const LegalDocView({
    Key? key,
    required this.userDataState,
  }) : super(key: key);

  final UserDataAskLegalDocState userDataState;

  @override
  State<LegalDocView> createState() => _LegalDocViewState();
}

class _LegalDocViewState extends State<LegalDocView> {
  final UserDataController userDataController = Get.find();
  final ConnectionService connectionService = Get.find();
  WebViewController? webViewController;
  bool error = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Text('Diplomat Header'),
            Expanded(
                child: WebView(
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: widget.userDataState.legalDoc.toString(),
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
            )),
            Padding(
              padding: EdgeInsets.all(Get.width * 0.06),
              child: GestureDetector(
                onTap: () {
                  if (!connectionService.hasConnection) {
                    Get.snackbar('Error', 'No internet',
                        backgroundColor: Colors.amber);
                    return;
                  }

                  userDataController.acceptLegalDoc();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(Get.width * 0.06)),
                  padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.1, vertical: Get.width * 0.03),
                  child: Text('Understood'),
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
                      horizontal: Get.width * 0.03, vertical: Get.width * 0.03),
                  child: Icon(Icons.replay_rounded)),
            ),
          )
      ],
    );
  }
}
