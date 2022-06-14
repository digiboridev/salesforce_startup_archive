import 'dart:ui';
import 'package:***REMOVED***/domain/entities/related_consumer.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/header/contact_option_tile.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/header/header_search_result.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/header/our_focus_head.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/header/related_customer_tile.dart';
import 'package:***REMOVED***/core/asset_images.dart';
import 'package:***REMOVED***/core/mycolors.dart';
import 'package:***REMOVED***/domain/entities/contact_us_data.dart';
import 'package:***REMOVED***/presentation/controllers/contactus_controller.dart';
import 'package:***REMOVED***/presentation/controllers/customer_controller.dart';
import 'package:***REMOVED***/presentation/controllers/search_controller.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/bottombar/bottom_bar_controller.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/favorites/favorites_page_controller.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/header/mainscreen_header_controller.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/header/mainscreen_header_states.dart';
import 'package:***REMOVED***/presentation/ui/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreenHeader extends StatefulWidget {
  final double headerHeight;
  const MainScreenHeader({Key? key, required this.headerHeight})
      : super(key: key);

  @override
  State<MainScreenHeader> createState() => _MainScreenHeaderState();
}

class _MainScreenHeaderState extends State<MainScreenHeader> {
  final MainScreeenHeaderController mainScreeenHeaderController =
      Get.put(MainScreeenHeaderController());
  final CustomerController customerController = Get.find();
  final ContactusController contactusController = Get.find();
  final SearchController searchController = Get.find();
  final BottomBarController bottomBarController = Get.find();

  FocusNode searchFocusNode = FocusNode();
  bool searchHasFocus = false;
  String searchBranchCondition = '';

  @override
  void initState() {
    super.initState();
    searchFocusNode.addListener(() {
      setState(() {
        searchHasFocus = searchFocusNode.hasFocus;
      });

      if (searchFocusNode.hasFocus) {
        if (!searchController.showSearch.value) {
          mainScreeenHeaderController.showSearch();
        }
      } else {
        mainScreeenHeaderController.hide();
      }
    });
  }

  goToRecomended() async {
    await bottomBarController.goToFavorites();
    Get.find<FavoritesPageController>().selectRecomended();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        head(),
        Expanded(child: expandableContent()),
      ],
    );
  }

  Widget head() {
    return Obx(() {
      return AnimatedContainer(
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 300),
        height: mainScreeenHeaderController.mainScreeenHeaderState.value
                is! MSHShowContactus
            ? widget.headerHeight
            : widget.headerHeight / 1.5,
        // color: Colors.red,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [MyColors.blue_0D63BB, MyColors.blue_00458C])),
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
        child: Column(
          children: [
            Spacer(
              flex: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Get.to(() => ProfileScreen(),
                          transition: Transition.cupertino);
                    },
                    child: Image.asset(
                      AssetImages.settings,
                      width: Get.width * 0.05,
                    )),
                Hero(
                  tag: 'logo',
                  child: Image.asset(
                    AssetImages.***REMOVED***Logo,
                    width: Get.width * 0.2,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      mainScreeenHeaderController.showContactus();
                      searchFocusNode.unfocus();
                    });
                  },
                  child: Hero(
                    tag: 'contact_btn',
                    child: Image.asset(
                      AssetImages.contactButton,
                      width: Get.width * 0.05,
                    ),
                  ),
                ),
              ],
            ),
            Spacer(
              flex: 1,
            ),
            if (mainScreeenHeaderController.mainScreeenHeaderState.value
                is! MSHShowContactus)
              searchBar(),
            Spacer(
              flex: 1,
            ),
            if (mainScreeenHeaderController.mainScreeenHeaderState.value
                is! MSHShowContactus)
              AnimatedContainer(
                curve: Curves.easeInOut,
                duration: Duration(milliseconds: 300),
                height: mainScreeenHeaderController.enableBrunchSelection.value
                    ? Get.width * 0.08
                    : 0,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      searchBranchCondition = '';
                      mainScreeenHeaderController.showBrunchSelection();
                      searchFocusNode.unfocus();
                    });
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Obx(() => Text(
                              customerController.selectedCustomer!.customerName,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Get.width * 0.035,
                              ),
                              overflow: TextOverflow.ellipsis,
                            )),
                      ),
                      if (mainScreeenHeaderController
                          .mainScreeenHeaderState.value is! MSHShowBrunch)
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Get.width * 0.03),
                              border: Border.all(
                                  width: Get.width * 0.001,
                                  color: Colors.white)),
                          padding: EdgeInsets.symmetric(
                              vertical: Get.width * 0.005,
                              horizontal: Get.width * 0.03),
                          child: GestureDetector(
                            onTap: () => goToRecomended(),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Recomended List'.tr,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: Get.width * 0.035),
                                ),
                                SizedBox(
                                  width: Get.width * 0.015,
                                ),
                                Image.asset(
                                  AssetImages.recomended_list,
                                  width: Get.width * 0.03,
                                )
                              ],
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            SizedBox(
              height: Get.width * 0.04,
            ),
          ],
        ),
      );
    });
  }

  Widget expandableContent() {
    return Align(
      alignment: Alignment.topCenter,
      child: Stack(children: [
        Obx(() {
          if (mainScreeenHeaderController.mainScreeenHeaderState.value
              is! MSHShowCommon) {
            return Positioned(
                child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  color: Colors.black.withAlpha(100),
                ),
              ),
            ));
          } else {
            return SizedBox();
          }
        }),
        Obx(() => AnimatedContainer(
              decoration: BoxDecoration(color: Colors.transparent),
              clipBehavior: Clip.antiAlias,
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              height: mainScreeenHeaderController.mainScreeenHeaderState.value
                      is MSHShowSearch
                  ? Get.height
                  : 0,
              child: OverflowBox(
                minHeight: 0,
                child: HeaderSearchResult(
                    searchController: searchController,
                    mainScreeenHeaderController: mainScreeenHeaderController),
              ),
            )),
        Obx(() => AnimatedContainer(
              decoration: BoxDecoration(color: Colors.transparent),
              clipBehavior: Clip.antiAlias,
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              height: mainScreeenHeaderController.mainScreeenHeaderState.value
                      is MSHShowContactus
                  ? Get.width
                  : 0,
              child: OverflowBox(
                minHeight: 0,
                child: buildContact(),
              ),
            )),
        Obx(
          () => AnimatedContainer(
            decoration: BoxDecoration(color: Colors.transparent),
            clipBehavior: Clip.antiAlias,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            height: mainScreeenHeaderController.mainScreeenHeaderState.value
                    is MSHShowBrunch
                ? Get.width
                : 0,
            child: OverflowBox(
              minHeight: 0,
              child: Column(
                children: [
                  buildBranchSelection(),
                ],
              ),
            ),
          ),
        ),
        Obx(() => AnimatedCrossFade(
              firstChild: GestureDetector(
                onTap: () {
                  setState(() {
                    mainScreeenHeaderController.showBrunchSelection();
                    searchFocusNode.unfocus();
                  });
                },
                child: Container(
                  // color: Colors.red,
                  width: Get.width,
                  height: Get.width * 0.06,
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AssetImages.header_tile,
                            width: Get.width * 0.4,
                          ),
                        ],
                      ),
                      Positioned.fill(
                        top: -Get.width * 0.03,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                              size: Get.width * 0.08,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              secondChild: SizedBox(),
              crossFadeState: mainScreeenHeaderController
                          .enableBrunchSelection.value &&
                      mainScreeenHeaderController.mainScreeenHeaderState.value
                          is MSHShowCommon
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: Duration(milliseconds: 010),
              firstCurve: Curves.easeOut,
              secondCurve: Curves.easeOut,
              reverseDuration: Duration(milliseconds: 200),
            )),
      ]),
    );
  }

  Row searchBar() {
    return Row(
      children: [
        if (searchHasFocus)
          GestureDetector(
            onTap: () {
              searchFocusNode.unfocus();
              mainScreeenHeaderController.hide();
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(Get.width * 0.1)),
              width: Get.width * 0.1,
              height: Get.width * 0.1,
              child: Icon(Icons.close),
            ),
          ),
        if (searchHasFocus)
          SizedBox(
            width: Get.width * 0.015,
          ),
        if (mainScreeenHeaderController.mainScreeenHeaderState.value
            is MSHShowBrunch)
          buildBrunchSearchField(),
        if (mainScreeenHeaderController.mainScreeenHeaderState.value
            is! MSHShowBrunch)
          buildMaterialsSearchField(),
      ].reversed.toList(),
    );
  }

  Widget buildContact() {
    return contactusController.obx(
      (state) {
        if (state is ContactUsData) {
          return Column(
            children: [
              Container(
                height: Get.width - Get.width * 0.07,
                color: MyColors.blue_00458C,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            OurFocusHead(
                              contactUsData: state,
                            ),
                            SizedBox(
                              height: Get.width * 0.02,
                            ),
                            ...state.contactOptionsList.map((e) {
                              return ContactOptionTile(
                                contactOption: e,
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                    // buildHideBottom()
                  ],
                ),
              ),
              buildHideBottom()
            ],
          );
        } else {
          return SizedBox();
        }
      },
      onError: (error) {
        return Container(
          width: Get.width,
          height: Get.width,
          color: MyColors.blue_00458C,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Contact Us loaing error',
                  style: TextStyle(color: Colors.white)),
              SizedBox(height: Get.width * 0.06),
              GestureDetector(
                  onTap: () {
                    contactusController.load();
                  },
                  child: Text('Reload', style: TextStyle(color: Colors.white))),
            ],
          ),
        );
      },
      onLoading: Container(
        width: Get.width,
        height: Get.width,
        color: MyColors.blue_00458C,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget buildBranchSelection() {
    ScrollController _scrollController = ScrollController();
    return Column(
      children: [
        Container(
          height: Get.width * 1 - Get.width * 0.07,
          color: MyColors.blue_00458C,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
            margin: EdgeInsets.only(bottom: Get.width * 0.02),
            color: MyColors.blue_00458C,
            child: Theme(
              data: ThemeData(
                  scrollbarTheme: ScrollbarThemeData(
                thumbColor: MaterialStateProperty.all(MyColors.blue_5584B2),
                radius: const Radius.circular(10),
              )),
              child: Scrollbar(
                isAlwaysShown: true,
                controller: _scrollController,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: BouncingScrollPhysics(),
                  child: Column(children: [
                    if (customerController.closestRelatedConsumer
                        is RelatedConsumer)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.03,
                        ),
                        child: Row(
                          children: [
                            Text(
                              '${'Nearest Brunch'.tr}',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white.withOpacity(0.77)),
                            ),
                          ],
                        ),
                      ),
                    if (customerController.closestRelatedConsumer
                        is RelatedConsumer)
                      RelatedCustomerTile(
                        ontap: () {
                          customerController
                              .switchCustomer(
                                  customerSAP: customerController
                                      .closestRelatedConsumer!
                                      .customerSAPNumber)
                              .then((value) =>
                                  mainScreeenHeaderController.hide());
                        },
                        relatedConsumer:
                            customerController.closestRelatedConsumer!,
                      ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.03,
                      ),
                      child: Row(
                        children: [
                          Text(
                            '${'All brunches'.tr}',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withOpacity(0.77)),
                          ),
                        ],
                      ),
                    ),
                    ...customerController.relatedConsumers
                        .where((element) => element.customerName
                            .toLowerCase()
                            .contains(searchBranchCondition.toLowerCase()))
                        .map((e) {
                      return RelatedCustomerTile(
                        ontap: () {
                          customerController
                              .switchCustomer(customerSAP: e.customerSAPNumber)
                              .then((value) =>
                                  mainScreeenHeaderController.hide());
                        },
                        relatedConsumer: e,
                      );
                    }).toList()
                  ]),
                ),
              ),
            ),
          ),
        ),
        buildHideBottom()
      ],
    );
  }

  GestureDetector buildHideBottom() {
    return GestureDetector(
      onTap: () => mainScreeenHeaderController.hide(),
      child: Container(
        // color: Colors.red,
        width: Get.width,
        height: Get.width * 0.06,
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AssetImages.header_tile,
                  width: Get.width * 0.4,
                ),
              ],
            ),
            Positioned.fill(
              top: -Get.width * 0.03,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.keyboard_arrow_up,
                    color: Colors.white,
                    size: Get.width * 0.08,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildBrunchSearchField() {
    return Expanded(
      child: Container(
        height: Get.width * 0.1,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(Get.width * 0.1)),
        child: Row(
          children: [
            SizedBox(
              width: Get.width * 0.03,
            ),
            Image.asset(
              AssetImages.search,
              width: Get.width * 0.04,
            ),
            SizedBox(
              width: Get.width * 0.03,
            ),
            Expanded(
                child: TextField(
              key: Key('searchbranch'),
              keyboardType: TextInputType.name,
              onChanged: (value) {
                setState(() {
                  searchBranchCondition = value;
                });
              },
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                isCollapsed: true,
                //isDense: true,
                alignLabelWithHint: true,

                labelText: 'Search branch'.tr,
                labelStyle:
                    TextStyle(color: MyColors.blue_00458C, fontSize: 16),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: InputBorder.none,

                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,

                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.all(0),
              ),
            )),
            SizedBox(
              width: Get.width * 0.03,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMaterialsSearchField() {
    return Expanded(
      child: Container(
        height: Get.width * 0.1,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(Get.width * 0.1)),
        child: Row(
          children: [
            SizedBox(
              width: Get.width * 0.03,
            ),
            Image.asset(
              AssetImages.search,
              width: Get.width * 0.04,
            ),
            SizedBox(
              width: Get.width * 0.03,
            ),
            Expanded(
                child: TextField(
              key: Key('searchproduct'),
              controller: searchController.textEditingController,
              focusNode: searchFocusNode,
              keyboardType: TextInputType.name,
              onChanged: (value) {},
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                isCollapsed: true,
                //isDense: true,
                alignLabelWithHint: true,

                labelText: 'Search product'.tr,
                labelStyle:
                    TextStyle(color: MyColors.blue_00458C, fontSize: 16),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.all(0),
              ),
            )),
            Image.asset(
              AssetImages.barcode,
              width: Get.width * 0.06,
            ),
            SizedBox(
              width: Get.width * 0.03,
            ),
          ],
        ),
      ),
    );
  }
}
