import 'package:***REMOVED***/core/colors.dart';
import 'package:***REMOVED***/domain/entities/materials/alternative_item.dart';
import 'package:***REMOVED***/domain/entities/materials/material.dart';
import 'package:***REMOVED***/domain/entities/materials/unit_types.dart';
import 'package:***REMOVED***/presentation/controllers/favorites_controller.dart';
import 'package:***REMOVED***/presentation/controllers/materials_catalog_controller.dart';
import 'package:***REMOVED***/presentation/controllers/materials_catalog_states.dart';
import 'package:***REMOVED***/presentation/ui/widgets/material_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:***REMOVED***/domain/entities/favorites/favorite_list.dart';
import 'package:***REMOVED***/presentation/controllers/customer_controller.dart';

class FavoritesPage extends StatefulWidget {
  final List<FavoriteList> favoriteLists;

  FavoritesPage({
    Key? key,
    required this.favoriteLists,
  }) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final CustomerController customerController = Get.find();
  final MaterialsCatalogController materialsCatalogController = Get.find();
  final FavoritesController favoritesController = Get.find();
  final List<String> belongsList = ["Vegan",
  "Frozen", "Just vegetables",
    "Frozen Products",
    "Breakfast Products",
    "Dinner",
    "Kosher"
  ];
  int? selectedListIndex;

  @override
  void initState() {
    super.initState();
    if (widget.favoriteLists.isNotEmpty) {
      selectedListIndex = 0;
    }
  }

  FavoriteList? get selectedList {
    if (selectedListIndex is int) {
      widget.favoriteLists.elementAt(selectedListIndex!);
    }
    return null;
  }

  @override
  void didUpdateWidget(covariant FavoritesPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (selectedListIndex != null) {
      if (selectedListIndex! > widget.favoriteLists.length - 1) {
        if (widget.favoriteLists.isNotEmpty) {
          selectedListIndex = 0;
        } else {
          selectedListIndex = null;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: Get.width,
      child: Column(
        children: [
          SizedBox(
            height: Get.width * 0.04,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Favorites',
                style: TextStyle(fontSize: 24,
                    color: MyColors.blue_003E7E),),
                Image.asset("assets/icons/favorites_list.png",
                  width: Get.width*0.06, height:Get.width*0.06,)],
            ),
          ),
          SizedBox(
            height: Get.width * 0.01,
          ),
          buildListsRow(),
          SizedBox(
            height: Get.width * 0.01,
          ),
          selectedListIndex is int
              ? Expanded(
            child: Column(
              children: [
                buildListControll(),
                SizedBox(
                  height: Get.width * 0.01,
                ),
                Expanded(
                    child:
                   Container(
                      child:
                    //  buildHaveNewList()
                      //buildBelongsList()
                       // buildNoProducts()
                      //buildNewList()
                      buildItemsList(),
                    )
          ),
              ],
            ),
          )
              : Expanded(
              child: Center(
                child: Text('Select list'),
              ))
        ],
      ),
    );
  }

  Padding buildListControll() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
      child:
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [Image.asset("assets/icons/favorites_cart.png",
              width: Get.width * 0.07, height: Get.width * 0.07,),
              Padding(padding: EdgeInsets.symmetric(horizontal:
              Get.width * 0.01),
                  child: Text("Add the entire list to cart",
                    style: TextStyle(color: MyColors.blue_003E83,
                        fontSize: 14),))
            ],),
            Row(children: [
              Padding(padding: EdgeInsets.symmetric(horizontal:
              Get.width * 0.01),
                  child: Image.asset("assets/icons/favorites_sort.png",
                    width: Get.width * 0.06, height: Get.width * 0.06,
                  )),
              Text("Sorting",
                style: TextStyle(color: MyColors.blue_003E83,
                    fontSize: 16),)

            ],)

          ],),),

    );
  }

  Widget buildItemsList() {
    return Obx(() {
      MaterialsCatalogState mcState =
          materialsCatalogController.materialsCatalogState.value;

      if (mcState is MCSCommon) {
        FavoriteList listToShow =
        widget.favoriteLists.elementAt(selectedListIndex!);

        if (listToShow.favoriteItems.isEmpty) {
          return Center(
            child: Text('Empty list'),
          );
        }

        return ListView(
          physics: BouncingScrollPhysics(),
          children: listToShow.favoriteItems.map((e) {
            Materiale? m = mcState.catalog.materials.firstWhereOrNull(
                  (element) => element.MaterialNumber == e.materialNumber,
            );

            if (m is Materiale) {
              return MaterialCard(
                materiale: m,
                insideFavorites: true,
              );
            } else {
              return Text('INVALID MATERIAL');
            }
          }).toList(),
        );
      } else {
        return Center(
          child: Text('Waiting catalog'),
        );
      }
    });
  }






  Widget buildListsRow() {
    return Padding(padding: EdgeInsets.symmetric(horizontal:
    Get.width * 0.025), child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
        children:[ Container(
            height: Get.width * 0.15,
    child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.favoriteLists.map((e) {
                return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedListIndex = widget.favoriteLists.indexOf(e);
                      });
                    },
                    child: Stack(
                      fit: StackFit.loose,

                      children: [

                        Row(children: [
                          SizedBox(width: 10,), Container(

                              decoration: BoxDecoration(
                                  color: selectedListIndex ==
                                      widget.favoriteLists.indexOf(e)
                                      ? Color(0xff00458C)
                                      : Color(0xff00458C).withOpacity(0.2),
                                  borderRadius:
                                  BorderRadius.circular(Get.width * 0.04)),
                              margin:
                              EdgeInsets.only(
                                  left: Get.width * 0.01,
                                  right: Get.width * 0.01,
                                  top: 10),
                              padding: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.035,
                                  vertical: Get.width * 0.025),
                              child: Text(e.listName,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: selectedListIndex ==
                                        widget.favoriteLists.indexOf(e)
                                        ? Colors.white
                                        : Color(0xff003E7E),
                                  )))
                        ],),
                        Container(


                          padding: EdgeInsets.symmetric(horizontal: 9,
                              vertical: 6),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(color:
                              MyColors.blue_00458C)
                          ),

                          child: Text("${e.favoriteItems.length}",
                            style: TextStyle(
                                fontSize: 12,
                                color: MyColors.blue_00458C
                            ),),
                        ),




                      ],)
                );
              }).toList(),
            )))]));
  }

  Widget buildBelongsList(){
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.grey.shade300,
              spreadRadius: 1, blurRadius: 10)],
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25))
      ),
      child: Column(children:
    [
      Container(
        padding: EdgeInsets.symmetric(horizontal:
        Get.width*0.06,
        vertical:Get.width*0.05),

    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
      Text("Belongs on the list",
      style: TextStyle(color: MyColors.blue_003E7E,
      fontSize: 24),),
      Text("Jacobs Kosher Passover Nescafe with Kernels",
        style: TextStyle(color: MyColors.blue_003E7E,
            fontSize: 17),),
          SizedBox(height: 10,),

          Container(
            width: Get.width,
              child: Wrap(
            direction: Axis.horizontal,
          spacing: 5,
          runSpacing: 10,
          children:
            belongsList.map((e){
              return
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                    decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(20)),
                border: Border.all(
                    color:MyColors.blue_00458C)
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 10,
              vertical: 10),
              child: Text("${e}",
              style: TextStyle(fontSize: 16,
                  color: MyColors.blue_00458C)),),]);
    }).toList())),

    ])),
      SizedBox(height: 43,),
      Expanded(child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Get.width*0.06),
        color: MyColors.blue_E8EEF6,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
            padding: EdgeInsets.symmetric(
                horizontal: Get.width*0.1,
            vertical: Get.width*0.025),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: MyColors.blue_00458C,
          ),
          child: Text("Save", style: TextStyle(
            color: Colors.white,
            fontSize: 22
          ),),
        ),
          Row(children: [Image.asset("assets/icons/deleted_list.png",
            color: Colors.red,
          width: Get.width*0.07,height: Get.width*0.07,),
          Text("Remove from favorites",
          style: TextStyle(color:Colors.red, fontSize: 17),)],)],) ,))],),);
  }


  Widget buildNoProducts(){
    return ListView(children: [Padding(padding:
    EdgeInsets.symmetric(horizontal: Get.width*0.06,),
    child:Column(children: [
      Container(
        padding: EdgeInsets.symmetric(vertical: Get.width*0.05,
            horizontal: Get.width*0.05),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: MyColors.blue_003E7E
        ),
        child: Image.asset("assets/icons/no_products.png",
          height: Get.width*0.06,width: Get.width*0.8,
        ),),
      SizedBox(height: Get.width*0.03,),
      Text("No product transfer yet\nTo this list",
        textAlign: TextAlign.center,
        style:
        TextStyle(color: MyColors.blue_003E7E,
        fontSize: Get.width*0.06),),
      SizedBox(height: Get.width*0.03,),

      Text("Save your products on the page\nFavorites by clicking on -",
        textAlign: TextAlign.center,
        style:
        TextStyle(color: MyColors.blue_003E7E,
            fontSize: Get.width*0.04),),

      SizedBox(height: Get.width*0.03,),
      Container(
        padding: EdgeInsets.symmetric(vertical: Get.width*0.025,
            horizontal: Get.width*0.025),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: MyColors.blue_003E7E
        ),
        child: Image.asset("assets/icons/favorite_no_product.png"),
          height: Get.width*0.09,width: Get.width*0.1,
        ),
      SizedBox(height: Get.width*0.03,),

      Text("On the favorites page, click on -",
        textAlign: TextAlign.center,
        style:
        TextStyle(color: MyColors.blue_003E7E,
            fontSize: Get.width*0.04),),

      SizedBox(height: Get.width*0.03,),
      Container(
        padding: EdgeInsets.symmetric(vertical: Get.width*0.025,
            horizontal: Get.width*0.025),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: MyColors.blue_003E7E
        ),
        child: Icon(Icons.more_vert, color: Colors.white,
          size: Get.width*0.04,),

      ),

      SizedBox(height: Get.width*0.03,),

      Text("Let you move the\nproduct\nTo one of the lists you opened",
        textAlign: TextAlign.center,
        style:
        TextStyle(color: MyColors.blue_003E7E,
            fontSize: Get.width*0.04),),
      SizedBox(height: Get.width*0.03,),
       Row(
            crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
        Image.asset("assets/icons/deleted_list.png",
        width: Get.width*0.03,
          height: Get.width*0.03,),
        Text("Delete the list", style: TextStyle(
            color: MyColors.blue_00458C,
            fontSize: Get.width*0.03,
        decoration: TextDecoration.underline),)
      ],)

    ],))],);
  }


  Widget buildNewList(){
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text("New shopping list",
      style: TextStyle(color: MyColors.blue_003E7E,
      fontSize: 26),),
      Image.asset("assets/icons/close.png",
      width: Get.width*0.05,height: Get.width*0.05,)],),
      SizedBox(height: Get.width*0.02,),
      Container(child:
        TextFormField(
          decoration: InputDecoration(
            labelText: "List Name",
            labelStyle: TextStyle(color: MyColors.blue_003E7E,
            fontSize: 17),
            hintStyle: TextStyle(color: MyColors.blue_003E7E,
            fontSize: 20),
            hintText: "Sample: Breakfast products",
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
      Container(
        width: Get.width,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: Get.width*0.03),
        decoration: BoxDecoration(color:
        MyColors.blue_00458C,
        borderRadius: BorderRadius.all(Radius.circular(27))),
        
        child: Text("Save", style: TextStyle(
        fontSize: 20, color: Colors.white
      ),),

      )
    ],),);
  }

  Widget buildHaveNewList(){
    return Container(

      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey.shade300,
        spreadRadius: 1, blurRadius: 5)],
        borderRadius: BorderRadius.circular(10)
      ),
      margin:  EdgeInsets.symmetric(
          horizontal: Get.width*0.05,
          vertical: Get.width*0.05),
      child:
    Column(
      mainAxisSize: MainAxisSize.min,
      children: [
     Container(
       padding: EdgeInsets.symmetric(horizontal: Get.width*0.05,
       vertical: Get.width*0.05),
       decoration: BoxDecoration(
           borderRadius: BorderRadius.only(topRight: Radius.circular(10),
               topLeft:Radius.circular(10) ),
         gradient: LinearGradient(
           colors: [
             MyColors.green_49D84C,
             MyColors.green_37C33A
           ]
         )
       ),
         child:  Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
           Image.asset("assets/icons/have_new_list.png",
           width: Get.width*0.07, height: Get.width*0.07,),
           Text("Good, you've made a new list!",
           style: TextStyle(color: Colors.white,
           fontSize: 18),),
           Image.asset("assets/icons/have_new_list.png",
             width: Get.width*0.07, height: Get.width*0.07,),
         ],)),
      SizedBox(height: Get.width*0.05,),
      Container(
        margin: EdgeInsets.only(bottom: Get.width*0.1),
        child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        Text("Breakfast Products",
        style: TextStyle(color: MyColors.blue_003E7E,
        fontSize: 16, fontWeight: FontWeight.bold),),
          SizedBox(height: Get.width*0.05,),
        Text("To fill out the list click on the three\npoints on the left side of the product",
          style:TextStyle(color: MyColors.blue_003E7E,
              fontSize: 16,)
        )
      ],),)
    ],),);
  }

}

