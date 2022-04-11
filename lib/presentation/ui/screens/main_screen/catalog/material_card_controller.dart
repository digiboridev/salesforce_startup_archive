import 'package:***REMOVED***/domain/entities/materials/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class MaterialCardController extends GetxController{
  final Materiale material;
  MaterialCardController({required this.material});
  RxInt product_count = RxInt(0);
  RxString box_type = ''.obs;
  RxInt unit_count = 1.obs;
  RxString select_box_type = ''.obs;

  void increaseCount(){
    (product_count.value += 1);
    update();
  }

  void decreaseCount(){
    if(product_count.value == 0){return;}
    (product_count.value -= 1);
    update();
  }
  void setUnitCount({required String boxType}){

    if(boxType == "Unit"){
      unit_count.value = 1;
    }
    if(boxType == "Pallets"){
      unit_count.value = material.PalletCount.toInt();
    }
    if(boxType == "Cartons"){
      unit_count.value = material.CartonCount.toInt();
    }
    if(boxType == "Inner"){
      unit_count.value = material.InnerCount.toInt();
    }
  }


  @override
  void onInit() {
    setUnitCount(boxType: box_type.value);
    super.onInit();

  }

}