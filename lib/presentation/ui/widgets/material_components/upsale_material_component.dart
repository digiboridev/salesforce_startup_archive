import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../core/colors.dart';

class UpsaleMaterialComponent extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => UpsaleMaterialComponentState();

}
class UpsaleMaterialComponentState extends State<UpsaleMaterialComponent>{
  @override
  Widget build(BuildContext context) {
    return Container(
         child: Column(
       children: [
         Container(
           height: 43,
           decoration: BoxDecoration(
               borderRadius: BorderRadius.only(
                   bottomRight: Radius.circular(15),
                   bottomLeft: Radius.circular(15)),
               gradient: LinearGradient(
                   colors: [MyColors.yellow_FF268E, MyColors.orange_FF8800],
                   begin: Alignment.topCenter,
                   end: Alignment.bottomCenter)),
           child: Padding(
             padding: EdgeInsets.only(
                 left: Get.width * 0.04, right: Get.width * 0.03),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text(
                   "SALE!",
                   style: TextStyle(color: Colors.white, fontSize: 16),
                 ),
                 Padding(
                     padding: EdgeInsets.only(top: 3),
                     child: Image.asset(
                       "assets/icons/sale.png",
                       height: 18,
                       width: Get.width * 0.07,
                     )),
                 Text(
                   "Buy 2 cartons Get the third one free!",
                   style: TextStyle(color: Colors.white, fontSize: 14),
                 ),
                 Icon(
                   Icons.close,
                   color: Colors.white,
                   size: 15,
                 )
               ],
             ),
           ),
         )
       ],
     ));
  }

}