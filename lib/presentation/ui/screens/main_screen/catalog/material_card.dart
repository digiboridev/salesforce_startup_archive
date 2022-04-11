import 'package:***REMOVED***/core/colors.dart';
import 'package:***REMOVED***/domain/entities/materials/material.dart';
import 'package:***REMOVED***/domain/services/image_caching_service.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/catalog/cart_top_icon.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/catalog/catalog_page_controller.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/catalog/material_card_component.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/catalog/material_card_controller.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/catalog/product_count.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/catalog/product_options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MaterialCard extends StatefulWidget {
  final Materiale materiale;
  final CatalogPageController controller;
  const MaterialCard({
    Key? key,
    required this.materiale,
    required this.controller
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => MaterialCardState();
}
class MaterialCardState extends State<MaterialCard>{
  late Materiale materiale;
  late CatalogPageController controller;
  bool isFocus = false;
  bool isCount = false;
  late String boxType;
  late int product_count;
  late MaterialCardController cardController;
  int productCount = 1;
  Widget componentItem = MaterialCardComponent(
      type: ComponentOutOfStockItem(isUpdate: false));

  Map<String, int> getTypeAndCount({required String salesUnit, required Materiale data}){
    switch(salesUnit){
      case "EA":
        return {"Unit": 1};
      case "ZIN":
        return {"Inner": data.InnerCount.toInt()};
      case "CAR":
        return {"Cartons": data.CartonCount.toInt()};
      case "PAL":
        return {"Pallets": data.PalletCount.toInt()};
      default: return {" ": 0};
    }
  }

  @override
  void initState() {
    materiale = widget.materiale;
    cardController = MaterialCardController(material: materiale);
    controller = widget.controller;


     boxType = getTypeAndCount(salesUnit: materiale.SalesUnit, data: materiale).keys.first;
     product_count  = getTypeAndCount(salesUnit: materiale.SalesUnit, data: materiale).values.first;

    cardController.product_count = 1.obs;
    cardController.box_type = boxType.obs;
    cardController.select_box_type = boxType.obs;
    cardController.unit_count = productCount.obs;
    cardController.setUnitCount(boxType: boxType);



    if(materiale.IsInStock){
      componentItem = getNormal(data: ComponentNormalItem(
          minimum: "${materiale.MinimumOrderQuantity} ${boxType}",
          recommended: "${materiale.AverageQty} ${boxType}"));
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {


    return  Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(Get.width * 0.04))),
      margin: EdgeInsets.only(
          bottom: Get.width * 0.025,
          left: Get.width * 0.025,
          top: Get.width * 0.05,
          right: Get.width * 0.025),
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
                      padding: EdgeInsets.all(Get.width * 0.01),
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
                      width: Get.width * 0.03,
                    ),
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                      Text(
                        materiale.Name,
                        style: TextStyle(color: MyColors.blue_003E7E),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Quantity",
                                style: TextStyle(color: MyColors.blue_0050A2, fontSize: 12),
                              ),
                              SizedBox(
                                height: Get.width * 0.02,
                              ),
                              Text(
                                "${product_count} units per ${boxType}",
                                style: TextStyle(color: MyColors.blue_0571E0, fontSize: 12),
                              )
                            ],
                          ),
                          Visibility(
                              visible: (materiale.UnitPrice != 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: Get.width * 0.04,
                                        right: Get.width * 0.04),
                                    height: Get.width * 0.09,
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Price per Unit׳",
                                          style: TextStyle(
                                              color: MyColors.blue_0050A2, fontSize: 12)),
                                      SizedBox(
                                        height: Get.width * 0.02,
                                      ),
                                      Row(children: [
                                        Text(
                                          "${materiale.UnitNetPrice}",
                                          style: TextStyle(
                                              color: MyColors.blue_0571E0, fontSize: 12),
                                        ),

                                        Container(
                                            width: 50,
                                            child: Stack(
                                              alignment: Alignment.topCenter,
                                              fit: StackFit.loose,
                                              children: [
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: Get.width * 0.00),
                                                    child: Text(
                                                      "${materiale.UnitPrice}",
                                                      style: TextStyle(
                                                          color: MyColors
                                                              .gray_8B9298),
                                                    )),
                                                Container(
                                                  alignment: Alignment.center,
                                                  height: 2.4,
                                                  //width: Get.width*0.11,
                                                  margin: EdgeInsets.only(
                                                      top: 7,
                                                      left: 5,
                                                      right: 5),
                                                  color: Colors.white,
                                                  child: Container(
                                                    height: 0.8,
                                                    // width: Get.width*0.13,
                                                    color: MyColors.gray_8B9298,
                                                    margin: EdgeInsets.all(0.5),
                                                  ),
                                                ),
                                              ],
                                            ))
                                      ]),
                                    ],
                                  ),
                                ],
                              ))
                        ],
                      )
                    ])),
                  ],
                ),
              ),
              SizedBox(
                height: Get.width * 0.05,
              ),
              Container(child: isFocus?getFocused(margin_bottom: 11):componentItem),
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
              child: CartTopIcon(
                type: CartTopIcon.menu_type,
              ),
            ),
          ),
          Positioned(
            top: Get.width * 0.08,
            left: (Get.width * 0.027),
            child: Container(
              // color: Colors.red,
              width: Get.width * 0.1,
              height: Get.width * 0.2,
              child: ProductOptions(
                  isHotSale: materiale.IsHotSale,
                  isNew: materiale.IsNew,
                  isFrozen: materiale.IsFrozen),
            ),
          )
        ],
      ),
    );
  }
  Widget getNormal({required ComponentNormalItem data}) {
    return Container(
      margin: EdgeInsets.only(left: Get.width*0.04, right: Get.width*0.03, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 24,
                width: Get.width*0.005,
                color: MyColors.blue_003E7E,
              ),
              Padding(
                  padding: EdgeInsets.only(left: Get.width*0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Recommended quantity: ",
                            style: TextStyle(color: MyColors.blue_003E83,
                                fontSize: 12),
                          ),
                          Text("${data.recommended}",
                              style: TextStyle(color: MyColors.blue_003E83,
                                  fontSize: 12))
                        ],
                      ),
                      Row(
                        children: [
                          Text("Minimum order: ",
                              style: TextStyle(color: MyColors.blue_003E83,
                                  fontSize: 12)),
                          Text("${data.minimum}",
                              style: TextStyle(color: MyColors.blue_003E83,
                                  fontSize: 12))
                        ],
                      )
                    ],
                  ))
            ],
          ),
          InkWell(
            onTap: (){
              setState(() {
                isFocus = !isFocus;
              });
            },
              child: Container(
            height: 44,
            width: Get.width*0.17,
            decoration: BoxDecoration(
                color: MyColors.blue_003E7E,
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ))
        ],
      ),
    );
  }


  Widget getFocused({required double margin_bottom}) {
    return Container(
      margin: EdgeInsets.only(left: Get.width*0.03, right: Get.width*0.03, bottom: margin_bottom),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: (){
              controller.showProductCountScreen(materiale: materiale,
                  value: true, cardController: cardController);

            },
              child: Container(
              height: 44,
              width: Get.width*0.45,
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: MyColors.blue_00458C,
                        style: BorderStyle.solid,
                        width: 0.80),
                  ),
                  child: Padding(padding: EdgeInsets.only(left: Get.width*0.04, right: Get.width*0.04 ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Obx(()=>Text("${cardController.product_count.value} ${cardController.select_box_type.value} ₪${materiale.UnitNetPrice.toInt()*cardController.unit_count.obs.value.value*cardController.product_count.value}",
                      style: TextStyle(
                        fontSize: 12,
                        color: MyColors.blue_00458C,
                      ),
                    )),
                    Icon(Icons.arrow_drop_down_outlined, color: MyColors.blue_00458C,)
                  ],))
                  ))),
          InkWell(
            onTap: (){
              cardController.increaseCount();
            },
            child:
          Container(
            height: 44,
            width: Get.width*0.17,
            decoration: BoxDecoration(
                color: MyColors.blue_007AFE,
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: Icon(
              Icons.add_outlined,
              color: Colors.white,
            ),
          ),),
    InkWell(
      onTap: (){
        cardController.decreaseCount();
      },
        child:
    Container(
            height: 44,
            width: Get.width*0.17,
            decoration: BoxDecoration(
                color: MyColors.blue_E8EEF6,
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: Icon(
              Icons.remove,
              color: MyColors.blue_00458C,
            ),
          ))
        ],
      ),
    );
  }

}
