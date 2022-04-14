import 'package:***REMOVED***/domain/entities/materials/material.dart';
import 'package:***REMOVED***/presentation/controllers/material_count_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MaterialScreen extends StatelessWidget {
  final Materiale material;
  const MaterialScreen({
    Key? key,
    required this.material,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MaterialCountController materialCountController = Get.put(
        MaterialCountController(material: material),
        tag: material.hashCode.toString());

    return Scaffold(
      body: SafeArea(
          child: SizedBox.expand(
        child: Column(
          children: [buildHeader(), Text('data')],
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
                  Icons.arrow_back,
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
