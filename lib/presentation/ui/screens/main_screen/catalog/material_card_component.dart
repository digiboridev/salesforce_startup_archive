import 'package:***REMOVED***/core/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

abstract class ComponentItem {}

class ComponentNormalItem extends ComponentItem {
  final String recommended;
  final String minimum;
  ComponentNormalItem({required this.recommended, required this.minimum});
}

class ComponentOutOfStockItem extends ComponentItem {
  final bool isUpdate;
  ComponentOutOfStockItem({required this.isUpdate});
}

class MaterialCardComponent extends StatefulWidget {
  static const String Type_Normal = "Normal";
  static const String Type_Focused = "Focused";
  static const String Type_Insight = "Insight";
  static const String Type_upSale = "upSale";
  static const String Type_Success = "Success";
  static const String Type_Ouf_of_stock = "Ouf of stock";
  static const String Type_Alternate_Product = "Alternate Product";
  static const String Type_Shopping_Cart_View = "Shopping Cart View";
  static const String Type_Order_Tracking_Supply = "Order Tracking Supply";
  static const String Type_System_Error = "System Error";
  static const String Type_User_Error = "User_Error";
  static const String Type_Partial_Supply = "Partial Supply";
  static const String Type_Favoriats = "Favoriats";
  final ComponentItem type;
  MaterialCardComponent({required this.type});

  @override
  State<StatefulWidget> createState() => MaterialCardComponentState();
}

class MaterialCardComponentState extends State<MaterialCardComponent> {
  late ComponentItem type;

  @override
  void initState() {
    type = widget.type;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (type is ComponentOutOfStockItem) {
      return getOufOfStock(
          isUpdate: (type as ComponentOutOfStockItem).isUpdate);
    }
    if (type is ComponentNormalItem) {
      return getNormal(data: type as ComponentNormalItem);
    } else {
      return getNormal(data: type as ComponentNormalItem);
    }
    /* switch (type) {
      case ComponentNormalItem:
        return getNormal();
      case MaterialCardComponent.Type_Focused:
        return getFocused(margin_bottom: 15);
      case MaterialCardComponent.Type_Insight:
        return getInsight();
      case MaterialCardComponent.Type_upSale:
        return getUpSale();
      case MaterialCardComponent.Type_Success:
        return getSuccess();
      case MaterialCardComponent.Type_Ouf_of_stock:
        return getOufOfStock(isUpdate: true);
      case MaterialCardComponent.Type_Alternate_Product:
        return getAlternateProduct(isOriginal: false);
      case MaterialCardComponent.Type_Order_Tracking_Supply:
        return getOrderTracking();
      case MaterialCardComponent.Type_System_Error:
        return getSystemError();
      case MaterialCardComponent.Type_User_Error:
        return getUserError();
      case MaterialCardComponent.Type_Partial_Supply:
        return getPartialSupply();
      default:
        return Container();
    }

    */
  }

  Widget getNormal({required ComponentNormalItem data}) {
    return Container(
      margin: EdgeInsets.only(
          left: Get.width * 0.04, right: Get.width * 0.03, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 24,
                width: Get.width * 0.005,
                color: MyColors.blue_003E7E,
              ),
              Padding(
                  padding: EdgeInsets.only(left: Get.width * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Recommended quantity: ",
                            style: TextStyle(
                                color: MyColors.blue_003E83, fontSize: 12),
                          ),
                          Text("${data.recommended}",
                              style: TextStyle(
                                  color: MyColors.blue_003E83, fontSize: 12))
                        ],
                      ),
                      Row(
                        children: [
                          Text("Minimum order: ",
                              style: TextStyle(
                                  color: MyColors.blue_003E83, fontSize: 12)),
                          Text("${data.minimum}",
                              style: TextStyle(
                                  color: MyColors.blue_003E83, fontSize: 12))
                        ],
                      )
                    ],
                  ))
            ],
          ),
          Container(
            height: 44,
            width: Get.width * 0.17,
            decoration: BoxDecoration(
                color: MyColors.blue_003E7E,
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Widget getFocused({required double margin_bottom}) {
    return Container(
      margin: EdgeInsets.only(
          left: Get.width * 0.03,
          right: Get.width * 0.03,
          bottom: margin_bottom),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              height: 44,
              width: Get.width * 0.45,
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: MyColors.blue_00458C,
                        style: BorderStyle.solid,
                        width: 0.80),
                  ),
                  child: DropdownButton<String>(
                    onChanged: (value) {},
                    underline: SizedBox.shrink(),
                    alignment: Alignment.bottomCenter,
                    dropdownColor: Colors.white,
                    isExpanded: true,
                    icon: Padding(
                        padding: EdgeInsets.only(
                            left: Get.width * 0.03, right: Get.width * 0.03),
                        child: Icon(Icons.keyboard_arrow_down,
                            color: MyColors.blue_00458C)),
                    items: [
                      DropdownMenuItem(
                          child: Padding(
                              padding: EdgeInsets.only(left: Get.width * 0.03),
                              child: Text(
                                "12 box ₪3,500",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: MyColors.blue_00458C,
                                ),
                              )))
                    ],
                  ))),
          Container(
            height: 44,
            width: Get.width * 0.17,
            decoration: BoxDecoration(
                color: MyColors.blue_007AFE,
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: Icon(
              Icons.add_outlined,
              color: Colors.white,
            ),
          ),
          Container(
            height: 44,
            width: Get.width * 0.17,
            decoration: BoxDecoration(
                color: MyColors.blue_E8EEF6,
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: Icon(
              Icons.remove,
              color: MyColors.blue_00458C,
            ),
          )
        ],
      ),
    );
  }

  Widget getInsight() {
    return Container(
      margin: EdgeInsets.only(
          left: Get.width * 0.04, right: Get.width * 0.04, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 24,
                width: Get.width * 0.005,
                color: MyColors.blue_003E7E,
              ),
              Padding(
                  padding: EdgeInsets.only(
                    left: Get.width * 0.01,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Recommended quantity: ",
                            style: TextStyle(
                                color: MyColors.blue_003E83, fontSize: 12),
                          ),
                          Text("value",
                              style: TextStyle(
                                  color: MyColors.blue_003E83, fontSize: 12))
                        ],
                      ),
                      Row(
                        children: [
                          Text("Minimum order: ",
                              style: TextStyle(
                                  color: MyColors.blue_003E83, fontSize: 12)),
                          Text("value",
                              style: TextStyle(
                                  color: MyColors.blue_003E83, fontSize: 12))
                        ],
                      )
                    ],
                  ))
            ],
          ),
          Container(
            height: 30,
            decoration: BoxDecoration(
                color: MyColors.pink_FF268E,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Padding(
                padding:
                    EdgeInsets.only(left: 12, right: 12, top: 3, bottom: 3),
                child: Text(
                  "You may be\nmissing!",
                  style: TextStyle(color: Colors.white, fontSize: 10),
                )),
          ),
          Container(
            height: 44,
            width: Get.width * 0.17,
            decoration: BoxDecoration(
                color: MyColors.blue_003E7E,
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Widget getUpSale() {
    return Container(
        child: Column(
      children: [
        getFocused(margin_bottom: 11),
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

  Widget getSuccess() {
    return Container(
        child: Column(
      children: [
        getFocused(margin_bottom: 11),
        Container(
          height: 43,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15)),
              gradient: LinearGradient(
                  colors: [MyColors.green_49D84C, MyColors.green_37C33A],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Padding(
            padding: EdgeInsets.only(
                left: Get.width * 0.05,
                right: Get.width * 0.05,
                bottom: 5,
                top: 5),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  "assets/images/success_back.png",
                  height: 32,
                ),
                Text(
                  "Two free pallets added!",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }

  Widget getOufOfStock({required bool isUpdate}) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                left: Get.width * 0.05, right: Get.width * 0.05, bottom: 15),
            alignment: Alignment.center,
            height: 44,
            decoration: BoxDecoration(
                color: isUpdate ? MyColors.blue_007AFE : MyColors.blue_003E83,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: isUpdate
                ? Padding(
                    padding: EdgeInsets.only(
                        left: Get.width * 0.05, right: Get.width * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "We'll update as soon as it's back in stock",
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ],
                    ))
                : Text(
                    "Not in stock, update when he gets back?",
                    style: TextStyle(color: Colors.white),
                  ),
          )
        ],
      ),
    );
  }

  Widget getAlternateProduct({required bool isOriginal}) {
    return Column(
      children: [
        //Container(child: isOriginal?getOufOfStock(isUpdate: false):getNormal(data: )),
        Container(
            alignment: Alignment.center,
            width: Get.width,
            height: 43,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
                color: MyColors.blue_E8EEF6),
            child: isOriginal
                ? Text(
                    "Alternative product",
                    style: TextStyle(color: MyColors.blue_37C33A, fontSize: 18),
                  )
                : Padding(
                    padding: EdgeInsets.only(
                        left: Get.width * 0.05, right: Get.width * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Back to original product",
                          style: TextStyle(
                              color: MyColors.blue_37C33A, fontSize: 18),
                        ),
                        SizedBox(
                          width: Get.width * 0.01,
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: MyColors.blue_37C33A,
                        )
                      ],
                    )))
      ],
    );
  }

  Widget getOrderTracking() {
    return Container(
        child: Column(
      children: [
        getFocused(margin_bottom: 11),
        Container(
          height: 43,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15)),
              gradient: LinearGradient(
                  colors: [MyColors.green_49D84C, MyColors.green_37C33A],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Padding(
            padding: EdgeInsets.only(
                left: Get.width * 0.05,
                right: Get.width * 0.05,
                bottom: 5,
                top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 18,
                    ),
                    SizedBox(
                      width: Get.width * 0.01,
                    ),
                    Text(
                      "Supplied!",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "price",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    Text(
                      "count",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    ));
  }

  Widget getSystemError() {
    return Container(
        height: 43,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(15),
                bottomLeft: Radius.circular(15)),
            gradient: LinearGradient(
                colors: [MyColors.blue_3B99FF, MyColors.blue_027BFE],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Padding(
            padding: EdgeInsets.only(
                left: Get.width * 0.05,
                right: Get.width * 0.05,
                bottom: 5,
                top: 5),
            child: Row(
              children: [
                Image.asset(
                  "assets/icons/error.png",
                  height: 24,
                ),
                SizedBox(
                  width: Get.width * 0.04,
                ),
                Text(
                  "This product was partially supplied, supplied:\n300 out of 600 units",
                  maxLines: 2,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                )
              ],
            )));
  }

  Widget getUserError() {
    return Container(
        alignment: Alignment.center,
        width: Get.width,
        height: 43,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(15),
                bottomLeft: Radius.circular(15)),
            gradient: LinearGradient(
                colors: [MyColors.red_EF6262, MyColors.red_C82B2B],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Padding(
            padding: EdgeInsets.only(
                left: Get.width * 0.05,
                right: Get.width * 0.05,
                bottom: 5,
                top: 5),
            child: Text(
              "Here will come an error message",
              maxLines: 2,
              style: TextStyle(color: Colors.white, fontSize: 16),
            )));
  }

  Widget getPartialSupply() {
    return Container(
      child: Column(
        children: [getOufOfStock(isUpdate: true), getSystemError()],
      ),
    );
  }
}
