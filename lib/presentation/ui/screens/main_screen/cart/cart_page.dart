import 'package:***REMOVED***/presentation/controllers/cart_controller.dart';
import 'package:***REMOVED***/presentation/controllers/materials_catalog_controller.dart';
import 'package:***REMOVED***/presentation/controllers/materials_catalog_states.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/bottombar/bottom_bar_controller.dart';
import 'package:***REMOVED***/presentation/ui/widgets/material_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  CartPage({Key? key}) : super(key: key);

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
          SizedBox(
            height: Get.width * 0.06,
          ),
          Text('Shopping cart'),
          SizedBox(
            height: Get.width * 0.03,
          ),
          buildCardControll(),
          SizedBox(
            height: Get.width * 0.03,
          ),
          cartController.cartItems.isEmpty
              ? Expanded(
                  child: Center(
                  child: Text('Cart empty'),
                ))
              : Expanded(
                  child: Container(
                  child: buildItemsList(),
                ))
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
          child: Text('No data'),
        );
      }
    });
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
}
