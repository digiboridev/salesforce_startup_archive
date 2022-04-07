import 'package:***REMOVED***/core/colors.dart';
import 'package:***REMOVED***/domain/entities/materials/material.dart';
import 'package:***REMOVED***/domain/services/image_caching_service.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/catalog/material_card_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MaterialCard extends StatelessWidget {
  final Materiale materiale;
  const MaterialCard({
    Key? key,
    required this.materiale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(Get.width*0.04))),
      margin: EdgeInsets.only(
          bottom: Get.width * 0.025,
          left: Get.width * 0.025,
          top: Get.width * 0.05,
          right: Get.width * 0.05),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              SizedBox(
                height: Get.width * 0.05,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(Get.width*0.01),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(Get.width * 0.03),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 0,
                                blurRadius: 10)
                          ]),
                      child: CachedImage(
                        Url: materiale.ImageUrl,
                        width: Get.width * 0.25,
                        height: Get.width * 0.25,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.05,
                    ),
                    Expanded(child: Column(children: [
                      Text(
                        materiale.Name,
                      style: TextStyle(color: MyColors.blue_dark),
                    ),
                    SizedBox(height: 16,),
                    Row(
                      children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text("Quantity", style: TextStyle(
                        color: MyColors.blue_0050A2
                      ),),
                      SizedBox(height: Get.width*0.02,),
                      Text("units", style: TextStyle(color: MyColors.blue_0571E0),)],),

                      Visibility(
                          child: Row(children: [Container(
                        margin: EdgeInsets.only(left: Get.width*0.05,
                            right: Get.width*0.05),
                        height: Get.width*0.09,width: 1,
                        color: Colors.grey,),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text("Price", style: TextStyle(color: MyColors.blue_0050A2)),
                        SizedBox(height: Get.width*0.02,),
                        Row(children:[
                          Text("now ", style:TextStyle(color: MyColors.blue_0571E0),),
                          Text("old",
                            style:TextStyle(color: MyColors.gray_8B9298,decoration:
                            TextDecoration.lineThrough) ,),
                        ]),],), ],))],)])),
                  ],
                ),
              ),
              SizedBox(
                height: Get.width * 0.05,
              ),
              MaterialCardComponent(type: MaterialCardComponent.Type_Ouf_of_stock),
              SizedBox(
               // height: Get.width * 0.05,
              ),
            ],
          ),
          Positioned(
            top: -(Get.width * 0.025),
            right: -(Get.width * 0.025),
            child: Container(
              width: Get.width * 0.1,
              height: Get.width * 0.1,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Get.width * 0.1)),
              child: Icon(Icons.heart_broken_sharp),
            ),
          )
        ],
      ),
    );
  }
}
