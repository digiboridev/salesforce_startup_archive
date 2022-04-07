import 'package:***REMOVED***/core/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  final String type;
  MaterialCardComponent({required this.type});

  @override
  State<StatefulWidget> createState() => MaterialCardComponentState();
}

class MaterialCardComponentState extends State<MaterialCardComponent> {
  late String type;

  @override
  void initState() {
    type = widget.type;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case MaterialCardComponent.Type_Normal:
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
        return getOufOfStock();
      default:
        return Container();
    }
  }

  Widget getNormal() {
    return Container(
      margin: EdgeInsets.only(left: 14, right: 12, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 24,
                width: 2,
                color: MyColors.blue_dark,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 4),
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
                          Text("quantity value",
                              style: TextStyle(color: MyColors.blue_003E83,
                                  fontSize: 12))
                        ],
                      ),
                      Row(
                        children: [
                          Text("Minimum order: ",
                              style: TextStyle(color: MyColors.blue_003E83,
                                  fontSize: 12)),
                          Text("order value",
                              style: TextStyle(color: MyColors.blue_003E83,
                                  fontSize: 12))
                        ],
                      )
                    ],
                  ))
            ],
          ),
          Container(
            height: 44,
            width: 66,
            decoration: BoxDecoration(
                color: MyColors.blue_dark,
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
      margin: EdgeInsets.only(left: 15, right: 15, bottom: margin_bottom),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              height: 44,
              width: 180,
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
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Icon(Icons.keyboard_arrow_down,
                            color: MyColors.blue_00458C)),
                    items: [
                      DropdownMenuItem(
                          child: Padding(
                              padding: EdgeInsets.only(left: 15),
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
            width: 66,
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
            width: 66,
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
      margin: EdgeInsets.only(left: 14, right: 12, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 24,
                width: 2,
                color: MyColors.blue_dark,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 4),
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
                          Text("value",
                              style: TextStyle(color: MyColors.blue_003E83,
                                  fontSize: 12))
                        ],
                      ),
                      Row(
                        children: [
                          Text("Minimum order: ",
                              style: TextStyle(color: MyColors.blue_003E83,
                                  fontSize: 12)),
                          Text("value",
                              style: TextStyle(color: MyColors.blue_003E83,
                                  fontSize: 12))
                        ],
                      )
                    ],
                  ))
            ],
          ),
          Container(
            height: 30,
            decoration: BoxDecoration(color: MyColors.pink_FF268E,
            borderRadius: BorderRadius.only(topRight: Radius.circular(20),
            bottomRight: Radius.circular(20))),
            child: Padding(padding: EdgeInsets.only(left: 12, right: 12,
                top: 3, bottom: 3),
            child: Text("You may be\nmissing!", style: TextStyle(
              color: Colors.white, fontSize: 10
            ),)),
          ),
          Container(
            height: 44,
            width: 66,
            decoration: BoxDecoration(
                color: MyColors.blue_dark,
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

  Widget getUpSale(){
    return Container(child:Column(children: [
      getFocused(margin_bottom: 11),
      Container(
        height: 43,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),
              bottomLeft: Radius.circular(15)) ,
            gradient: LinearGradient(colors: [
        MyColors.yellow_FF268E,
        MyColors.orange_FF8800
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: Padding(padding: EdgeInsets.only(left: 16, right: 11),child: 
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Text("SALE!", style: TextStyle(color: Colors.white, fontSize: 16),),

          Padding(padding: EdgeInsets.only(top: 3),child:
          Image.asset("assets/icons/sale.png", height: 18,width: 18,)),
            Text("Buy 2 cartons Get the third one free!", style: TextStyle(color: Colors.white,
            fontSize: 14),),
            Padding(padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.close, color: Colors.white,size: 15,),)

        ],),),)

    ],));
  }
  Widget getSuccess(){
    return Container(
      child: Column(children: [
        getFocused(margin_bottom: 11),
        Container(
          height: 43,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15)) ,
              gradient: LinearGradient(colors: [
                MyColors.green_49D84C,
                MyColors.green_37C33A
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: Padding(padding: EdgeInsets.only(left: 18, right: 18, bottom: 5, top: 5),child:
          Stack(
            alignment: Alignment.center,

            children: [
              Image.asset("assets/images/success_back.png", height: 32,),

              Text("Two free pallets added!", style: TextStyle(color: Colors.white,
                  fontSize: 18),),

            ],),),)

      ],)
    );

  }
  Widget getOufOfStock(){
    return Container(
      child: Column(children: [
        Container(
          margin: EdgeInsets.only(left: 21, right: 21, bottom: 15),
          alignment: Alignment.center,
          height: 44,
          decoration: BoxDecoration(color: MyColors.blue_003E83,
          borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Text("Not in stock, update when he gets back?",
            style: TextStyle(color: Colors.white) ,),)
      ],),

    );
  }


}
