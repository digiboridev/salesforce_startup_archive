import 'package:***REMOVED***/domain/entities/materials/material.dart';
import 'package:***REMOVED***/presentation/controllers/material_count_controller.dart';
import 'package:***REMOVED***/presentation/ui/widgets/material_components/focused_material_component.dart';
import 'package:***REMOVED***/presentation/ui/widgets/material_components/normal_material_component.dart';
import 'package:***REMOVED***/presentation/ui/widgets/material_components/outstock_material_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MaterialScreen extends StatefulWidget {
  final Materiale material;

  MaterialScreen({
    Key? key,
    required this.material,
  }) : super(key: key);

  @override
  State<MaterialScreen> createState() => _MaterialScreenState();
}

class _MaterialScreenState extends State<MaterialScreen> {
  late MaterialCountController materialCountController;

  @override
  void initState() {
    super.initState();
    materialCountController = Get.put(
        MaterialCountController(material: widget.material),
        tag: widget.material.hashCode.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF4F4F6),
      body: SafeArea(
          child: SizedBox.expand(
        child: Column(
          children: [buildHeader(), Expanded(child: buildBody())],
        ),
      )),
    );
  }

  Widget buildBody() {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        SizedBox(
          height: Get.width * 0.06,
        ),
        buildMaterial(),
        SizedBox(
          height: Get.width * 0.06,
        ),
        buildSuggestions(),
        SizedBox(
          height: Get.width * 0.06,
        ),
      ],
    );
  }

  Widget buildSuggestions() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
      color: Colors.red,
      width: Get.width,
      height: Get.width * 0.75,
    );
  }

  Widget getMaterialComponent() {
    return Obx(() {
      print(materialCountController.unit_count);
      if (!widget.material.IsInStock) {
        return OutStockMaterialComponent(
          isUpdate: widget.material.didSubscribedToInventoryAlert,
        );
      }
      if (materialCountController.unit_count > 0) {
        return FocusedMaterialComponent(
            materialCountController: materialCountController,
            materiale: widget.material);
      } else {
        return NormalMaterialComponent(
            materiale: widget.material,
            materialCountController: materialCountController);
      }
    });
  }

  Container buildMaterial() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
      color: Colors.white,
      width: Get.width,
      height: Get.width * 1.6,
      child: Column(
        children: [
          Text(widget.material.SFId),
          Text(widget.material.Barcode),
          Text('Minimum' +
              widget.material.MinimumOrderQuantity.toString() +
              widget.material.salesUnitType.text),
          Text(widget.material.ProductDescription ?? 'No Description'),
          getMaterialComponent()
        ],
      ),
    );
  }

  Widget buildHeader() {
    return Container(
      height: Get.width * 0.3,
      color: Color(0xff00458C),
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
      child: Column(
        children: [
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Hero(
                tag: 'contact_btn',
                child: Image.asset(
                  'assets/icons/contact.png',
                  width: Get.width * 0.05,
                ),
              ),
              Hero(
                tag: 'logo',
                child: Image.asset(
                  'assets/images/***REMOVED***_logo.png',
                  width: Get.width * 0.3,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}
