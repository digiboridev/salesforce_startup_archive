import 'package:***REMOVED***/core/assets.dart';
import 'package:***REMOVED***/core/colors.dart';
import 'package:***REMOVED***/domain/services/connections_service.dart';
import 'package:***REMOVED***/presentation/controllers/customer_controller.dart';
import 'package:***REMOVED***/presentation/controllers/user_data_controller.dart';
import 'package:***REMOVED***/presentation/ui/widgets/custom_switch.dart';
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
    borderSide: BorderSide(color: MyColors.blue_003E7E),
  );
  String passError = '';
  bool showAsterisks = true;
  final String password_condition = 'Password condition'.tr;

  @override
  Widget build(BuildContext context) {
    print(userDataController.avaliableLanguages);
    return Scaffold(
      backgroundColor: MyColors.blue_003E7E,
      body: SafeArea(
          child: Container(
        color: MyColors.white_F4F4F6,
        child: SizedBox.expand(
          child: Column(
            children: [buildHeader(), buildBody(context)],
          ),
        ),
      )),
    );
  }

  Widget buildBody(BuildContext context) {
    print(userDataController.currentLanguage);
    return Expanded(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          width: Get.width,
          height: Get.height - Get.width * 0.4,
          color: Colors.white,
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
                  child: Text(
                    'Password change'.tr,
                    style: TextStyle(
                      color: MyColors.blue_003E7E,
                      fontSize: Get.width * 0.08,
                    ),
                  ),
                ),
                Spacer(
                  flex: 2,
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
                        hintStyle: TextStyle(
                            fontSize: Get.width * 0.042,
                            color: MyColors.blue_003E7E),
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
                      return passIsCorrect(pass: val, field_type: 'New'.tr)
                              .isEmpty
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
                        hintStyle: TextStyle(
                            fontSize: Get.width * 0.042,
                            color: MyColors.blue_003E7E),
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
                      return passIsCorrect(pass: val, field_type: 'New'.tr)
                              .isEmpty
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
                        hintStyle: TextStyle(
                            fontSize: Get.width * 0.042,
                            color: MyColors.blue_003E7E),
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
                        style: TextStyle(
                            color: MyColors.blue_003E7E, fontSize: 20),
                      ),
                      CustomSwitch(
                          key: UniqueKey(),
                          value: showAsterisks,
                          enableColor: MyColors.blue_003E7E,
                          disableColor: MyColors.white_F4F4F6,
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
                    flex: 4,
                    fit: FlexFit.tight,
                    child: Container(
                        width: Get.width,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                            left: Get.width * 0.06,
                            right: Get.width * 0.06),

                            child: Visibility(
                                visible: passError.isNotEmpty,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                        Icon(
                                          Icons.error,
                                          color: Colors.red,
                                        ),
                                    SizedBox(width:
                                    Get.width*0.01,),

                                    Flexible(child:Container(
                                       // width: Get.width * 0.8,
                                        child:
                                         Text(
                                          passError,
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 17),
                                        )))
                                  ],
                                )))),
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
                              'Cancellation'.tr,
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
                                userDataController.changePassword(
                                    oldPass: _oldPass.text,
                                    newPass: _pass.text);
                              }
                            }
                          },
                          child: Container(
                            width: Get.width / 2.4,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: MyColors.blue_00458C,
                                borderRadius:
                                    BorderRadius.circular(Get.width * 0.06)),
                            padding: EdgeInsets.symmetric(
                                vertical: Get.width * 0.03),
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
      ),
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
      if (field_type == 'Current'.tr) {
        return '';
      }
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
