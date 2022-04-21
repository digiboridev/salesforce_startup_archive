import 'package:***REMOVED***/core/colors.dart';
import 'package:***REMOVED***/domain/services/connections_service.dart';
import 'package:***REMOVED***/presentation/controllers/customer_controller.dart';
import 'package:***REMOVED***/presentation/controllers/user_data_controller.dart';
import 'package:***REMOVED***/presentation/ui/widgets/custom_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ChangePasswordPageState();
}

class ChangePasswordPageState extends State<ChangePasswordPage> {
  final CustomerController customerController = Get.find();
  final UserDataController userDataController = Get.find();
  final ConnectionService connectionService = Get.find();

  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _oldPass = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final UnderlineInputBorder fieldBorder = UnderlineInputBorder(
    borderSide: BorderSide(color: Color(0xff003E7E)),
  );
  String passError = '';
  bool showAsterisks = true;
  final String password_condition =
      'Password condition'.tr;

  @override
  Widget build(BuildContext context) {
    print(userDataController.avaliableLanguages);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Container(
                color: Colors.white,
                height: Get.height * 0.95,
                width: Get.width,
                child: Column(
                  children: [buildHeader(), buildBody(context)],
                ),
              ))),
    );
  }

  Widget buildBody(BuildContext context) {
    print(userDataController.currentLanguage);
    return Expanded(
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
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
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
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
                child: TextFormField(
                  maxLength: 20,
                  obscureText: showAsterisks,
                  validator: (val) {
                    return passIsCorrect(pass: val, field_type: 'Current'.tr)
                            .isEmpty
                        ? null
                        : '';
                  },
                  controller: _oldPass,
                  decoration: InputDecoration(
                      counterText: '',
                      errorText: '',
                      errorStyle: TextStyle(
                        color: Colors.transparent,
                        fontSize: 0,
                      ),
                      hintText: 'Current password'.tr,
                      enabledBorder: fieldBorder,
                      focusedBorder: fieldBorder,
                      errorBorder: fieldBorder,
                      focusedErrorBorder: fieldBorder),
                ),
              ),
              SizedBox(
                height: Get.width * 0.06,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
                child: TextFormField(
                  maxLength: 20,
                  obscureText: showAsterisks,
                  controller: _pass,
                  validator: (val) {
                    return passIsCorrect(pass: val, field_type: 'New'.tr).isEmpty
                        ? null
                        : '';
                  },
                  decoration: InputDecoration(
                      counterText: '',
                      errorText: '',
                      errorStyle: TextStyle(
                        color: Colors.transparent,
                        fontSize: 0,
                      ),
                      hintText: 'New password'.tr,
                      enabledBorder: fieldBorder,
                      focusedBorder: fieldBorder,
                      errorBorder: fieldBorder,
                      focusedErrorBorder: fieldBorder),
                ),
              ),
              SizedBox(
                height: Get.width * 0.06,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
                child: TextFormField(
                  maxLength: 20,
                  obscureText: showAsterisks,
                  controller: _confirmPass,
                  validator: (val) {
                    return passIsCorrect(pass: val, field_type: 'New'.tr).isEmpty
                        ? null
                        : '';
                  },
                  decoration: InputDecoration(
                      counterText: '',
                      errorText: '',
                      errorStyle: TextStyle(
                        color: Colors.transparent,
                        fontSize: 0,
                      ),
                      hintText: 'New password again'.tr,
                      enabledBorder: fieldBorder,
                      errorBorder: fieldBorder,
                      focusedBorder: fieldBorder,
                      focusedErrorBorder: fieldBorder),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: Get.width * 0.06,
                    right: Get.width * 0.06,
                    top: Get.width * 0.07),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Password display in asterisks'.tr,
                      style:
                          TextStyle(color: MyColors.blue_003E7E, fontSize: 20),
                    ),
                    CustomSwitch(
                        key: UniqueKey(),
                        value: showAsterisks,
                        enableColor: MyColors.blue_003E7E,
                        disableColor: MyColors.gray_707070,
                        width: Get.width * 0.1,
                        height: Get.width * 0.1,
                        switchHeight: Get.width * 0.05,
                        switchWidth: Get.width * 0.05,
                        onChanged: (value) {
                          setState(() {
                            showAsterisks = !showAsterisks;
                          });
                        })
                  ],
                ),
              ),
              Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(
                      width: Get.width,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                          left: Get.width * 0.06, right: Get.width * 0.06),
                      child: Center(
                          child: Visibility(
                              visible: passError.isNotEmpty,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.01,
                                  ),
                                  Container(
                                      width: Get.width * 0.6,
                                      child: Text(
                                        passError,
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 20),
                                      ))
                                ],
                              ))))),
              Padding(
                padding: EdgeInsets.only(
                    left: Get.width * 0.06,
                    right: Get.width * 0.06,
                    bottom: Get.width * 0.12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/phone.png',
                      width: Get.width * 0.03,
                      height: Get.width * 0.03,
                    ),
                    SizedBox(
                      width: Get.width * 0.01,
                    ),
                    Container(
                        child: Text(
                      'For details please contact the hotline'.tr,
                      style: TextStyle(color: MyColors.blue_003E7E),
                    ))
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                    left: Get.width * 0.06,
                    right: Get.width * 0.06,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          width: Get.width / 2.4,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: MyColors.gray_EAF2FA,
                              borderRadius:
                                  BorderRadius.circular(Get.width * 0.06)),
                          padding: EdgeInsets.symmetric(
                            vertical: Get.width * 0.03,
                          ),
                          child: Text(
                            'Cancel'.tr,
                            style: TextStyle(color: MyColors.blue_003E7E),
                          ),
                        ),
                      ),
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
                            if (validationPassForSave(
                                oldPass: _oldPass.text,
                                newPass: _pass.text,
                                confirmPass: _confirmPass.text)) {
                              closePassError();
                              // userDataController.changePassword(
                              //   oldPass: _oldPass.text, newPass: _pass.text);
                            }
                          }
                        },
                        child: Container(
                          width: Get.width / 2.4,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color(0xff00458C),
                              borderRadius:
                                  BorderRadius.circular(Get.width * 0.06)),
                          padding:
                              EdgeInsets.symmetric(vertical: Get.width * 0.03),
                          child: Text(
                            'Save'.tr,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: Get.width * 0.06,
              ),
            ],
          ),
        ),
      ),
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
                onTap: () {
                  Get.back();
                },
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

  bool validationPassword({required String? pass}) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    final RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(pass ?? ' ');
  }

  void showPassError({required String error}) {
    setState(() {
      passError = error;
    });
  }

  void closePassError() {
    setState(() {
      passError = '';
    });
  }

  String passIsCorrect({required String? pass, required String field_type}) {
    if (pass != null && pass.isNotEmpty) {
      if (validationPassword(pass: pass)) {
        return '';
      } else {
        showPassError(error: password_condition);
        return 'Error'.tr;
      }
    } else {
      showPassError(error: '${field_type} ${'password is empty'.tr}');
      return 'Error'.tr;
    }
  }

  bool validationPassForSave(
      {required oldPass, required newPass, required confirmPass}) {
    if (oldPass == newPass) {
      showPassError(error: 'Passwords must not match'.tr);
      return false;
    } else if (newPass != confirmPass) {
      showPassError(error: 'New password is not match'.tr);
      return false;
    } else {
      return true;
    }
  }
}
