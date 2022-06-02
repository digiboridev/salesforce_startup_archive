import 'package:***REMOVED***/core/mycolors.dart';
import 'package:***REMOVED***/domain/entities/materials/material.dart';
import 'package:***REMOVED***/domain/entities/materials/materials_catalog.dart';
import 'package:***REMOVED***/domain/services/connections_service.dart';
import 'package:***REMOVED***/domain/services/image_caching_service.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/bottombar/bottom_bar_controller.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/catalog/catalog_page_controller.dart';
import 'package:***REMOVED***/presentation/ui/screens/material_screen.dart';
import 'package:***REMOVED***/presentation/ui/widgets/material_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  final MaterialsCatalog materialsCatalog;

  HomePage({
    Key? key,
    required this.materialsCatalog,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ConnectionService connectionService = Get.find();
  final BottomBarController bottomBarController = Get.find();

  int dealsPosition = 0;
  Widget dealsCard = Container();

  @override
  Widget build(BuildContext context) {
    return buildBody();
  }

  List<Materiale> get getRecomendedProducts {
    return widget.materialsCatalog.materials
        .where((element) => element.IsRecommended)
        .toList();
  }

  List<Materiale> get getMissingProducts {
    return widget.materialsCatalog.materials
        .where((element) => element.RecommendationType == 5)
        .toList();
  }

  List<Materiale> get getNewProducts {
    return widget.materialsCatalog.materials
        .where((element) => element.IsNew)
        .toList();
  }

  List<Materiale> get getDeals {
    return widget.materialsCatalog.materials
        .where((element) => element.IsHotSale)
        .toList();
  }

  goToRecomended() async {
    await bottomBarController.goToCatalog();
    Get.find<CatalogPageController>().onDealsClick(forsed: true);
  }

  Widget buildBody() {
    return Container(
      width: Get.width,
      // color: Colors.white,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: Get.width * 0.1,
            ),
            if (getDeals.isNotEmpty)
              buildDeals(
                  materials: getDeals.take(4).toList(),
                  header: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Deals'.tr,
                        style: TextStyle(
                          color: MyColors.blue_003E7E,
                          fontSize: Get.width * 0.055,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => goToRecomended(),
                        child: Text(
                          'All Deals'.tr,
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: Get.width * 0.045,
                              color: Colors.blue),
                        ),
                      ),
                    ],
                  )),
            if (getRecomendedProducts.isNotEmpty)
              buildIItemsRow(
                  materials: getRecomendedProducts.take(4).toList(),
                  header: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recomended for you'.tr,
                        style: TextStyle(
                          color: MyColors.blue_003E7E,
                          fontSize: Get.width * 0.055,
                        ),
                      ),
                      Text(
                        'All recomended'.tr,
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: Get.width * 0.045,
                            color: Colors.blue),
                      ),
                    ],
                  )),
            if (getNewProducts.isNotEmpty)
              SizedBox(
                height: Get.width * 0.06,
              ),
            if (getNewProducts.isNotEmpty)
              buildIItemsRow(
                  materials: getNewProducts.take(4).toList(),
                  header: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'New Products'.tr,
                        style: TextStyle(
                          color: MyColors.blue_003E7E,
                          fontSize: Get.width * 0.055,
                        ),
                      ),
                      Text(
                        'To all newcomers'.tr,
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: Get.width * 0.045,
                            color: Colors.blue),
                      ),
                    ],
                  )),
            if (getMissingProducts.isNotEmpty)
              SizedBox(
                height: Get.width * 0.06,
              ),
            if (getMissingProducts.isNotEmpty)
              buildIItemsRow(
                  materials: getMissingProducts.take(4).toList(),
                  header: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'You may be missing'.tr,
                        style: TextStyle(
                          color: MyColors.blue_003E7E,
                          fontSize: Get.width * 0.055,
                        ),
                      ),
                      Text(
                        'List of deficiencies'.tr,
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: Get.width * 0.045,
                            color: Colors.blue),
                      ),
                    ],
                  )),
            SizedBox(
              height: Get.width * 0.2,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDeals(
      {required List<Materiale> materials, required Widget header}) {
    buildDealsCard(materiale: materials[dealsPosition]);
    return Container(
        color: Colors.white,
        child: Column(children: [
          SizedBox(
            height: Get.width * 0.05,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
            child: header,
          ),
          SizedBox(
            height: Get.width * 0.02,
          ),
          Divider(),
          SizedBox(
            height: Get.width * 0.02,
          ),
          SizedBox(
              width: Get.width,
              child: Container(
                  height: 108,
                  width: Get.width * 0.2,
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: materials.length,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(left: 8.0),
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Container(
                                padding: EdgeInsets.only(
                                    left: Get.width * 0.02,
                                    right: Get.width * 0.02,
                                    top: Get.width * 0.02),
                                width: Get.width / 4,
                                child: InkWell(
                                    onTap: () {
                                      dealsPosition = index;
                                      buildDealsCard(
                                          materiale: materials[index]);
                                      setState(() {
                                        dealsPosition;
                                        dealsCard;
                                      });
                                    },
                                    child: Container(
                                      height: Get.width * 0.2,
                                      width: Get.width * 0.2,
                                      decoration: BoxDecoration(
                                          border: dealsPosition == index
                                              ? Border.all(
                                                  color: MyColors.blue_00458C)
                                              : Border.all(
                                                  color: MyColors.blue_00458C
                                                      .withAlpha(0)),
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                              Get.width * 0.02),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.15),
                                                blurRadius: Get.width * 0.01,
                                                spreadRadius: 1)
                                          ]),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CachedImage(
                                              Url: materials[index].ImageUrl,
                                              width: Get.width * 0.15,
                                              height: Get.width * 0.15),
                                        ],
                                      ),
                                    ))),
                            Visibility(
                                visible: index == dealsPosition,
                                child: ClipPath(
                                    clipper: CustomTriangleClipper(),
                                    child: Container(
                                      width: 15,
                                      height: 10,
                                      decoration: BoxDecoration(
                                          color: MyColors.blue_00458C),
                                    )))
                          ],
                        );
                      }))),
          dealsCard,
          SizedBox(
            height: Get.width * 0.02,
          ),
        ]));
  }

  void buildDealsCard({required Materiale materiale}) {
    dealsCard = Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: Get.width * 0.07,
              spreadRadius: 1)
        ]),
        child: MaterialCard(
          materiale: materiale,
        ));
  }

  Widget buildIItemsRow(
      {required List<Materiale> materials, required Widget header}) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: Get.width * 0.05,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
            child: header,
          ),
          SizedBox(
            height: Get.width * 0.02,
          ),
          Divider(),
          SizedBox(
            height: Get.width * 0.02,
          ),
          SizedBox(
            width: Get.width,
            child: Wrap(
              runSpacing: Get.width * 0.05,
              alignment: WrapAlignment.spaceEvenly,
              runAlignment: WrapAlignment.spaceEvenly,
              children: materials.map((e) {
                return GestureDetector(
                  onTap: () {
                    Get.to(
                        () => MaterialScreen(
                              material: e,
                            ),
                        transition: Transition.cupertino);
                  },
                  child: Container(
                    height: Get.width / 2,
                    width: Get.width * 0.42,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(Get.width * 0.02),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: Get.width * 0.03)
                        ]),
                    child: Column(
                      children: [
                        CachedImage(
                            Url: e.ImageUrl,
                            width: Get.width * 0.3,
                            height: Get.width * 0.3),
                        Expanded(
                            child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(Get.width * 0.02),
                            child: Text(
                              e.Name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: Get.width * 0.035,
                                  color: MyColors.blue_0050A2),
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(
            height: Get.width * 0.05,
          )
        ],
      ),
    );
  }
}

class CustomTriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width / 2, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
