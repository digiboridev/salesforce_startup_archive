import 'package:***REMOVED***/domain/entities/contact_us_data.dart';
import 'package:***REMOVED***/domain/services/image_caching_service.dart';
import 'package:***REMOVED***/presentation/controllers/contactus_controller.dart';
import 'package:***REMOVED***/presentation/controllers/customer_controller.dart';
import 'package:***REMOVED***/presentation/controllers/search_controller.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/header/mainscreen_header_controller.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/header/mainscreen_header_states.dart';
import 'package:***REMOVED***/presentation/ui/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

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

  FocusNode searchFocusNode = FocusNode();
  bool searchHasFocus = false;

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          return AnimatedContainer(
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: 300),
            height: widget.headerHeight,
            color: Color(0xff00458C),
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
                        setState(() {
                          mainScreeenHeaderController.showContactus();
                          searchFocusNode.unfocus();
                        });
                      },
                      child: Hero(
                        tag: 'contact_btn',
                        child: Image.asset(
                          'assets/icons/contact.png',
                          width: Get.width * 0.05,
                        ),
                      ),
                    ),
                    Hero(
                      tag: 'logo',
                      child: Image.asset(
                        'assets/images/***REMOVED***_logo.png',
                        width: Get.width * 0.2,
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          Get.to(() => ProfileScreen(),
                              transition: Transition.cupertino);
                        },
                        child: Image.asset(
                          'assets/icons/settings.png',
                          width: Get.width * 0.05,
                        ))
                  ],
                ),
                Spacer(
                  flex: 1,
                ),
                searchBar(),
                Spacer(
                  flex: 1,
                ),
                AnimatedContainer(
                  curve: Curves.easeInOut,
                  duration: Duration(milliseconds: 300),
                  height:
                      mainScreeenHeaderController.enableBrunchSelection.value
                          ? Get.width * 0.05
                          : 0,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        mainScreeenHeaderController.showBrunchSelection();
                        searchFocusNode.unfocus();
                      });
                    },
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Obx(() => Text(
                            'Brunch: ' +
                                customerController
                                    .selectedCustomer!.customerName,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: Get.width * 0.035),
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.width * 0.04,
                ),
              ],
            ),
          );
        }),
        Expanded(
            child: Align(
          alignment: Alignment.topCenter,
          child: Stack(children: [
            Obx(() => AnimatedContainer(
                  decoration: BoxDecoration(color: Colors.transparent),
                  clipBehavior: Clip.antiAlias,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  height: mainScreeenHeaderController
                          .mainScreeenHeaderState.value is MSHShowSearch
                      ? Get.height
                      : 0,
                  child: OverflowBox(
                    minHeight: 0,
                    child: buildSearchResults(),
                  ),
                )),
            Obx(() => AnimatedContainer(
                  decoration: BoxDecoration(color: Colors.transparent),
                  clipBehavior: Clip.antiAlias,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  height: mainScreeenHeaderController
                          .mainScreeenHeaderState.value is MSHShowContactus
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
                      height: Get.width * 0.07,
                      child: Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/header_tile.png'),
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
                  crossFadeState:
                      mainScreeenHeaderController.enableBrunchSelection.value &&
                              mainScreeenHeaderController
                                  .mainScreeenHeaderState.value is MSHShowCommon
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                  duration: Duration(milliseconds: 010),
                  firstCurve: Curves.easeOut,
                  secondCurve: Curves.easeOut,
                  reverseDuration: Duration(milliseconds: 200),
                )),
          ]),
        )),
      ],
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
                  color: Color(0xffEEE4F2),
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
        Expanded(
          child: Container(
            height: Get.width * 0.1,
            decoration: BoxDecoration(
                color: Color(0xffEEE4F2),
                borderRadius: BorderRadius.circular(Get.width * 0.1)),
            child: Row(
              children: [
                SizedBox(
                  width: Get.width * 0.03,
                ),
                Image.asset(
                  'assets/icons/search.png',
                  width: Get.width * 0.04,
                ),
                SizedBox(
                  width: Get.width * 0.03,
                ),
                Expanded(
                    child: TextField(
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
                    labelStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
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
                  'assets/icons/barcode.png',
                  width: Get.width * 0.06,
                ),
                SizedBox(
                  width: Get.width * 0.03,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSearchResults() {
    return Container(
      width: Get.width,
      // height: Get.height,
      color: Color(0xff00458C),
      child: Column(
        children: [
          if (searchController.findedMaterials.isNotEmpty)
            Expanded(
              child: ListView(
                children: searchController.findedMaterials.map((element) {
                  return Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.05,
                          vertical: Get.width * 0.03),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(Get.width * 0.03),
                      ),
                      height: Get.height * 0.1,
                      child: Row(
                        children: [
                          CachedImage(
                              Url: element.ImageUrl,
                              width: Get.height * 0.075,
                              height: Get.height * 0.075),
                          Expanded(child: Text(element.Name)),
                        ],
                      ));
                }).toList(),
              ),
            ),
          if (searchController.findedMaterials.isEmpty &&
              searchController.findedSimilarMaterials.isNotEmpty)
            Padding(
              padding: EdgeInsets.all(Get.width * 0.05),
              child: Text(
                'No results were found for this product but we have similar products',
                style:
                    TextStyle(color: Colors.white, fontSize: Get.width * 0.04),
              ),
            ),
          if (searchController.findedMaterials.isEmpty &&
              searchController.findedSimilarMaterials.isNotEmpty)
            Container(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
              alignment: Alignment.centerLeft,
              child: Text(
                searchController
                    .getCatalog()!
                    .families
                    .firstWhere((element) =>
                        element.SFId ==
                        searchController.findedSimilarMaterials.first.FamilyId)
                    .Display,
                style:
                    TextStyle(color: Colors.white, fontSize: Get.width * 0.04),
              ),
            ),
          if (searchController.findedMaterials.isEmpty &&
              searchController.findedSimilarMaterials.isNotEmpty)
            Expanded(
              child: ListView(
                children:
                    searchController.findedSimilarMaterials.map((element) {
                  return Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.05,
                          vertical: Get.width * 0.03),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(Get.width * 0.03),
                      ),
                      height: Get.height * 0.1,
                      child: Row(
                        children: [
                          CachedImage(
                              Url: element.ImageUrl,
                              width: Get.height * 0.075,
                              height: Get.height * 0.075),
                          Expanded(child: Text(element.Name)),
                        ],
                      ));
                }).toList(),
              ),
            ),
          GestureDetector(
            onTap: () {
              searchController.showSearch.value = true;
              mainScreeenHeaderController.hide();
            },
            child: Padding(
              padding: EdgeInsets.all(Get.width * 0.05),
              child: Text(
                'More results'.tr,
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
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
                color: Color(0xff00458C),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Container(
                              height: Get.width * 0.2,
                              decoration: BoxDecoration(
                                  color: Color(0xff0250A0),
                                  borderRadius:
                                      BorderRadius.circular(Get.width * 0.02)),
                              margin: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.06),
                              padding: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.06),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        'Our focus is open',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        state.openingHoursString,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Get.width * 0.02,
                            ),
                            ...state.contactOptionsList.map((e) {
                              return Column(
                                children: [
                                  Container(
                                    height: Get.width * 0.25,
                                    decoration: BoxDecoration(
                                        color: Color(0xff0250A0),
                                        borderRadius: BorderRadius.circular(
                                            Get.width * 0.02)),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: Get.width * 0.06),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Get.width * 0.02),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: Get.width * 0.02),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              e.description,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                launch('mailto:${e.email}');
                                              },
                                              child: Image.asset(
                                                'assets/icons/contact_mail.png',
                                                width: Get.width * 0.15,
                                              ),
                                            ),
                                            SizedBox(
                                              width: Get.width * 0.05,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                launch('${e.whatsAppLink}');
                                              },
                                              child: Image.asset(
                                                'assets/icons/contact_messanger.png',
                                                width: Get.width * 0.15,
                                              ),
                                            ),
                                            SizedBox(
                                              width: Get.width * 0.05,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                launch('tel:${e.phoneNumber}');
                                              },
                                              child: Image.asset(
                                                'assets/icons/contact_phone.png',
                                                width: Get.width * 0.15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.width * 0.02,
                                  ),
                                ],
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
              GestureDetector(
                onTap: () => mainScreeenHeaderController.hide(),
                child: Container(
                  // color: Colors.red,
                  width: Get.width,
                  height: Get.width * 0.07,
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/header_tile.png'),
                        ],
                      ),
                      Positioned.fill(
                        top: -Get.width * 0.03,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
              )
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
          color: Color(0xff00458C),
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
        color: Color(0xff00458C),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget buildBranchSelection() {
    return Column(
      children: [
        Container(
          height: Get.width * 1 - Get.width * 0.07,
          color: Color(0xff00458C),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'All branches:',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: customerController.relatedConsumers.map((e) {
                    return Padding(
                      padding: EdgeInsets.all(Get.width * 0.01),
                      child: GestureDetector(
                        onTap: () {
                          customerController.switchCustomer(
                              customerSAP: e.customerSAPNumber);
                        },
                        child: Container(
                            padding: EdgeInsets.all(Get.width * 0.04),
                            decoration: BoxDecoration(
                                color: Colors.blue[800],
                                borderRadius:
                                    BorderRadius.circular(Get.width * 0.02)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e.customerId,
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  e.customerName,
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  e.customerAddress,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            )),
                      ),
                    );
                  }).toList(),
                ),
              )),
              // buildHideBottom(),
              SizedBox(
                height: Get.width * 0.03,
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () => mainScreeenHeaderController.hide(),
          child: Container(
            // color: Colors.red,
            width: Get.width,
            height: Get.width * 0.07,
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/header_tile.png'),
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
        )
      ],
    );
  }

  GestureDetector buildHideBottom() {
    return GestureDetector(
      onTap: () => mainScreeenHeaderController.hide(),
      child: Container(
        width: Get.width,
        // color: Colors.red,
        child: Icon(
          Icons.arrow_drop_up_outlined,
          color: Colors.white,
          size: Get.width * 0.08,
        ),
      ),
    );
  }
}
