import 'package:***REMOVED***/domain/services/connections_service.dart';
import 'package:***REMOVED***/presentation/controllers/user_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpiredPasswordScreen extends StatelessWidget {
  ExpiredPasswordScreen({Key? key}) : super(key: key);

  final UserDataController userDataController = Get.find();
  final ConnectionService connectionService = Get.find();

  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _oldPass = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox.expand(
        child: Column(
          children: [
            buildHeader(),
            Expanded(
              child: Container(
                width: Get.width,
                color: Colors.white,
                child: Form(
                  key: _form,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Get.width * 0.06,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.06),
                        child: Text(
                          'Password change'.tr,
                          style: TextStyle(
                            fontSize: Get.width * 0.05,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.width * 0.06,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.06),
                        child: TextFormField(
                          validator: (val) {
                            if (val == null || val.isEmpty) return 'Empty'.tr;
                            return null;
                          },
                          controller: _oldPass,
                          decoration: InputDecoration(
                            hintText: 'Current password'.tr,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff003E7E)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff003E7E)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.width * 0.06,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.06),
                        child: TextFormField(
                          controller: _pass,
                          validator: (val) {
                            if (val == null || val.isEmpty) return 'Empty'.tr;
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'New password'.tr,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff003E7E)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff003E7E)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.width * 0.06,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.06),
                        child: TextFormField(
                          controller: _confirmPass,
                          validator: (val) {
                            if (val == null || val.isEmpty) return 'Empty'.tr;
                            if (val != _pass.text)
                              return 'Passwords are not the same'.tr;
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'New password again'.tr,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff003E7E)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff003E7E)),
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              bool valid = _form.currentState!.validate();
                              if (!connectionService.hasConnection) {
                                Get.snackbar(
                                    'Error'.tr, 'Restricted for offline mode'.tr);
                                return;
                              }
                              if (valid) {
                                userDataController.changePassword(
                                    oldPass: _oldPass.text,
                                    newPass: _pass.text,
                                    onlogin: true);
                              }
                            },
                            child: Container(
                              width: Get.width * 0.3,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Color(0xff00458C),
                                  borderRadius:
                                      BorderRadius.circular(Get.width * 0.06)),
                              padding: EdgeInsets.symmetric(
                                  vertical: Get.width * 0.03),
                              child: Text(
                                'Change'.tr,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Get.width * 0.06,
                      ),
                    ],
                  ),
                ),
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
      color: Color(0xff00458C),
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
                  'assets/images/***REMOVED***_logo.png',
                  width: Get.width * 0.3,
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
