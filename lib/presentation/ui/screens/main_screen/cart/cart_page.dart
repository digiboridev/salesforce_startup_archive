import 'package:***REMOVED***/core/colors.dart';
import 'package:***REMOVED***/presentation/controllers/cart_controller.dart';
import 'package:***REMOVED***/presentation/controllers/materials_catalog_controller.dart';
import 'package:***REMOVED***/presentation/controllers/materials_catalog_states.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/bottombar/bottom_bar_controller.dart';
import 'package:***REMOVED***/presentation/ui/widgets/material_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  final CartController cartController = Get.find();
  final MaterialsCatalogController materialsCatalogController = Get.find();
  final BottomBarController bottomBarController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffF4F4F6),
      width: Get.width,
      child: Column(
        children: [
          Container(
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    height: Get.width * 0.06,
                  ),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.06),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Shopping cart'.tr,
                                style: TextStyle(
                                    color: MyColors.blue_003E7E, fontSize: 24),
                              )
                            ],
                          ),
                          SizedBox(
                            height: Get.width * 0.04,
                          ),
                          Row(
                            children: [
                              Text(
                                "Next delivery".tr,
                                style: TextStyle(
                                    color: MyColors.blue_003E7E,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: Get.width * 0.04,
                              ),
                              Text(
                                "Wed 21/3/21",
                                style: TextStyle(
                                    color: MyColors.blue_003E7E, fontSize: 12),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.01),
                                width: 1,
                                height: Get.width * 0.04,
                                color: MyColors.blue_003E7E,
                              ),
                              Text(
                                "Frozen, Wednesday 21.3.21",
                                style: TextStyle(
                                    color: MyColors.blue_003E7E, fontSize: 12),
                              ),
                            ],
                          )
                        ],
                      )),
                  SizedBox(
                    height: Get.width * 0.05,
                  ),
                  buildActions(),
                  //buildSaveShoppingList(),
                  // buildCardControll(),
                  SizedBox(
                    height: Get.width * 0.03,
                  ),
                ],
              )),
          cartController.cartItems.isEmpty
              ? Expanded(
                  child: Center(
                  child:Container()
                  //buildEmptyCard(),
                ))
              : Expanded(
                  child: Container(
                  child: buildItemsList(),
                ))
        ],
      ),
    );
  }

  Widget buildEmptyCard() {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Get.width * 0.05, horizontal: Get.width * 0.05),
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: MyColors.blue_003E7E),
            child: Image.asset(
              "assets/icons/empty_cart.png",
              height: Get.width * 0.06,
              width: Get.width * 0.8,
            ),
          ),
          SizedBox(
            height: Get.width * 0.04,
          ),
          Text(
            "Your shopping cart is empty".tr,
            style: TextStyle(color: MyColors.blue_003E7E, fontSize: 24),
          ),
          SizedBox(
            height: Get.width * 0.04,
          ),
          Text(
            "To start an order from the recommended list".tr,
            style: TextStyle(
                color: MyColors.blue_003E7E,
                decoration: TextDecoration.underline,
                fontSize: 17),
          ),
          SizedBox(height: Get.width*0.06,),
          Container(
            width: Get.width,
            margin: EdgeInsets.symmetric(horizontal: Get.width*0.06,),
            padding: EdgeInsets.symmetric(horizontal: Get.width*0.05,
                vertical: Get.width*0.06),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text("Next delivery".tr, style: TextStyle(
                  color: MyColors.blue_003E7E,
                  fontSize: 20, fontWeight: FontWeight.bold),),
              SizedBox(height: Get.width*0.025,),
              Text("Wednesday 21.3.21", style: TextStyle(
                  color: MyColors.blue_003E7E,
                  fontSize: 17),),
                Text("Minimum order 1,500 NIS", style: TextStyle(
                    color: MyColors.blue_003E7E,
                    fontSize: 17),),
                SizedBox(height: Get.width*0.025,),
                Text("Frozen: Wednesday 21.3.21", style: TextStyle(
                    color: MyColors.blue_003E7E,
                    fontSize: 17),),
                Text("Minimum order 1,500 NIS", style: TextStyle(
                    color: MyColors.blue_003E7E,
                    fontSize: 17),),
                SizedBox(height: Get.width*0.025,),

            ],),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade300, spreadRadius: 1, blurRadius: 10)
            ]),
          ),
          SizedBox(height: Get.width*0.1,),

          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: Get.width*0.06),
            padding: EdgeInsets.symmetric(vertical: Get.width*0.025),
            width: MediaQuery.of(context).size.width,
            child: Text("Catalog".tr, style: TextStyle(color: Colors.white, fontSize: 22),),
            decoration: BoxDecoration(color: MyColors.blue_00458C,
                borderRadius: BorderRadius.circular(20)),)
        ],
      ),
    );
  }

  Widget buildItemsList() {
    return Obx(() {
      MaterialsCatalogState mcState =
          materialsCatalogController.materialsCatalogState.value;

      if (mcState is MCSCommon) {
        return ListView(
          physics: BouncingScrollPhysics(),
          children: [
            if (cartController.dryMaterials.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.06, vertical: Get.width * 0.06),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Dry'),
                    Text('Price: ' +
                        cartController.dryItemsPrice.toStringAsFixed(2) +
                        ' / ' +
                        cartController.totalPrice.toStringAsFixed(2))
                  ],
                ),
              ),
            ...cartController.dryMaterials
                .map((e) => MaterialCard(materiale: e)),
            if (cartController.frozenMaterials.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.06, vertical: Get.width * 0.06),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Frozen'),
                    Text('Price: ' +
                        cartController.frozenItemsPrice.toStringAsFixed(2) +
                        ' / ' +
                        cartController.totalPrice.toStringAsFixed(2))
                  ],
                ),
              ),
            ...cartController.frozenMaterials
                .map((e) => MaterialCard(materiale: e)),
          ],
        );
      } else {
        return Center(
          child: Text('No data'.tr),
        );
      }
    });
  }

  Widget buildActions() {
    List<String> imgList = [
      'assets/icons/deleted_list.png',
      'assets/icons/save_list.png',
      'assets/icons/add_product.png',
    ];
    List<String> descriptionList = [
      "Emptying All Basket".tr,
      "Save As a shopping list".tr,
      "Add Products From the catalog".tr
    ];
    return Container(
        margin: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(3, (index) {
            return Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Image.asset(
                    imgList[index],
                    height: 26,
                    width: 26,
                    color: MyColors.blue_0571E0,
                  ),
                  SizedBox(
                    height: Get.width * 0.01,
                  ),
                  Text(
                    descriptionList[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(color: MyColors.blue_003E83, fontSize: 12),
                  )
                ],
              ),
            );
          }),
        ));
  }

  Row buildCardControll() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
            onTap: () => cartController.cleanCart(), child: Text('Clear')),
        GestureDetector(
            onTap: () => Get.snackbar('Error', 'Not implemented'),
            child: Text('Save to fav')),
        GestureDetector(
            onTap: () => bottomBarController.changePage(newPageIndex: 4),
            child: Text('Add')),
      ],
    );
  }
  Widget buildSaveShoppingList(){
      return Container(
        padding: EdgeInsets.symmetric(horizontal: Get.width*0.06,
            vertical:Get.width*0.05),
        width: Get.width,
        decoration: BoxDecoration(

            boxShadow: [
              BoxShadow(color: Colors.grey.shade300,
                  spreadRadius: 1, blurRadius: 10)],
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25))
        ),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Saving as a shopping list".tr,
              style: TextStyle(color: MyColors.blue_003E7E,
                  fontSize: 26),),],),

          Text("The list will be kept in the preferred area".tr,
            style: TextStyle(
                color: MyColors.blue_003E7E,
                fontSize: 17),),

          SizedBox(height: Get.width*0.04,),
          Container(child:
          TextFormField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(

                hintStyle: TextStyle(color: MyColors.blue_003E7E,
                    fontSize: 18),
                hintText: "List Name".tr,
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color:
                    MyColors.blue_003E7E)),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:
                    MyColors.blue_003E7E)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:
                    MyColors.blue_003E7E))

            ),
          ),
          ),
          SizedBox(height: Get.width*0.1,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child:
              Container(

            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: Get.width*0.03,),
            decoration: BoxDecoration(color:
            MyColors.blue_00458C,
                borderRadius: BorderRadius.all(Radius.circular(27))),
            child: Text("Continue".tr, style: TextStyle(
                fontSize: 20, color: Colors.white
            ),),

          )),
              SizedBox(width: Get.width*0.02,),
              Flexible(child:

              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: Get.width*0.03, ),
                decoration: BoxDecoration(color:
                MyColors.blue_E8EEF6,
                    borderRadius: BorderRadius.all(Radius.circular(27))),
                child: Text("Cancellation".tr, style: TextStyle(
                    fontSize: 20, color: MyColors.blue_00458C
                ),),

              ))],)
        ],),);
  }
}
