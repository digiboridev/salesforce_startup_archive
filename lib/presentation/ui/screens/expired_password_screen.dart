import 'package:***REMOVED***/core/asset_images.dart';
import 'package:***REMOVED***/core/colors.dart';
import 'package:***REMOVED***/domain/services/connections_service.dart';
import 'package:***REMOVED***/presentation/controllers/customer_controller.dart';
import 'package:***REMOVED***/presentation/controllers/user_data_controller.dart';
import 'package:***REMOVED***/presentation/ui/widgets/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpiredPasswordScreen extends StatefulWidget {
  ExpiredPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ExpiredPasswordScreen> createState() => _ExpiredPasswordScreenState();
}

class _ExpiredPasswordScreenState extends State<ExpiredPasswordScreen> {
  final CustomerController customerController = Get.find();
  final UserDataController userDataController = Get.find();
  final ConnectionService connectionService = Get.find();

  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final UnderlineInputBorder fieldBorder = UnderlineInputBorder(
    borderSide: BorderSide(color: MyColors.blue_003E7E),
  );
  String passError = '';
  bool showAsterisks = true;
  bool isCorrect = false;
  final String password_condition = 'Password condition'.tr;

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
        validationPassForSave(
            confirmPass: _confirmPass.text, newPass: _pass.text);
        return '';
      }
      if (validationPassword(pass: pass)) {
        validationPassForSave(
            confirmPass: _confirmPass.text, newPass: _pass.text);
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

  bool validationPassForSave({required newPass, required confirmPass}) {
    if (newPass != confirmPass) {
      showPassError(error: 'New password is not match'.tr);
      setState(() {
        isCorrect = false;
      });
      return false;
    } else {
      closePassError();
      setState(() {
        isCorrect = true;
      });
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.blue_003E7E,
      resizeToAvoidBottomInset: false,
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
                  '🌞Good morning,'.tr,
                  style: TextStyle(
                    fontSize: Get.width * 0.06,
                  ),
                ),
              ),
              SizedBox(
                height: Get.width * 0.01,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
                child: Text(
                  'The password you entered is expired'.tr,
                  style: TextStyle(
                    fontSize: Get.width * 0.04,
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
                  controller: _pass,
                  onChanged: (text) {
                    passIsCorrect(pass: text, field_type: 'New'.tr).isEmpty;
                  },
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
                  onChanged: (text) {
                    passIsCorrect(pass: text, field_type: 'Confirm'.tr).isEmpty;
                  },
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
              Container(
                width: Get.width,
                alignment: Alignment.center,
                child: GestureDetector(
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
                          newPass: _pass.text,
                          confirmPass: _confirmPass.text)) {
                        closePassError();
                        userDataController.changePassword(
                            oldPass: '', newPass: _pass.text, onlogin: true);
                      }
                    }
                  },
                  child: Container(
                    width: Get.width / 1.4,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: isCorrect
                            ? MyColors.blue_00458C
                            : MyColors.blue_D5DDE5,
                        borderRadius: BorderRadius.circular(Get.width * 0.06)),
                    padding: EdgeInsets.symmetric(vertical: Get.width * 0.03),
                    child: Text(
                      'Send'.tr,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Get.width * 0.04,
              ),
              Container(
                width: Get.width,
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    userDataController.logout();
                  },
                  child: Container(
                    width: Get.width / 2.4,
                    alignment: Alignment.center,
                    // decoration: BoxDecoration(
                    //     color: MyColors.gray_EAF2FA,
                    //     borderRadius: BorderRadius.circular(Get.width * 0.06)),
                    padding: EdgeInsets.symmetric(
                      vertical: Get.width * 0.03,
                    ),
                    child: Text(
                      'Back to the login screen'.tr,
                      style: TextStyle(color: MyColors.blue_003E7E),
                    ),
                  ),
                ),
              ),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'logo',
                child: Image.asset(
                  AssetImages.***REMOVED***Logo,
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
