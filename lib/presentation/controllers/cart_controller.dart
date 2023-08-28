import 'package:salesforce.startup/domain/entities/cart_item.dart';
import 'package:salesforce.startup/domain/entities/materials/material.dart';
import 'package:salesforce.startup/domain/entities/materials/unit_types.dart';
import 'package:salesforce.startup/domain/usecases/cart/get_cart_items.dart';
import 'package:salesforce.startup/domain/usecases/cart/set_cart_items.dart';
import 'package:salesforce.startup/presentation/controllers/customer_controller.dart';
import 'package:salesforce.startup/presentation/controllers/materials_catalog_controller.dart';
import 'package:salesforce.startup/presentation/controllers/materials_catalog_states.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  // dependency
  CustomerController _customerController = Get.find();
  MaterialsCatalogController _materialsCatalogController = Get.find();

  // usecases
  GetCartItems _getCartItems = Get.find();
  SetCartItems _setCartItems = Get.find();

  // variables
  RxList<CartItem> _cartItems = RxList([]);
  List<CartItem> get cartItems => _cartItems;
  Stream<List<CartItem>> get cartItemsStream => _cartItems.stream;

  @override
  void onReady() {
    super.onReady();
    load();
    // Listen to customer changes
    _customerController.selectedCustomerSAPStream.listen((String? customerSAP) {
      load();
    });
  }

  Future load() async {
    if (_customerController.selectedCustomerSAP == null) {
      _cartItems.clear();
      return;
    }

    try {
      List<CartItem> data = await _getCartItems.call(GetCartItemsParams(customerSAP: _customerController.selectedCustomerSAP!));

      _cartItems.value = List<CartItem>.of(data);
    } catch (e) {
      print(e);
    }
  }

  Future save() async {
    await _setCartItems.call(SetCartItemsParams(customerSAP: _customerController.selectedCustomerSAP!, items: _cartItems));
  }

  CartItem? getItemByNumber({required String materialNumber}) {
    int existIndex = _cartItems.indexWhere((element) => element.materialNumber == materialNumber);

    if (existIndex != -1) {
      return _cartItems.elementAt(existIndex);
    } else {
      return null;
    }
  }

  setItem({
    required String materialNumber,
    required UnitType unit,
    required int quantity,
  }) {
    int existIndex = _cartItems.indexWhere((element) => element.materialNumber == materialNumber);

    if (existIndex != -1) {
      _cartItems[existIndex] = CartItem(materialNumber: materialNumber, unit: unit.salesUnitString, quantity: quantity);
    } else {
      _cartItems.add(CartItem(materialNumber: materialNumber, unit: unit.salesUnitString, quantity: quantity));
    }
    save();
  }

  removeItem({required String materialNumber}) {
    int existIndex = _cartItems.indexWhere((element) => element.materialNumber == materialNumber);

    if (existIndex != -1) {
      _cartItems.removeAt(existIndex);
      save();
    }
  }

  cleanCart() {
    _cartItems.clear();
    save();
  }

  List<Materiale> get frozenMaterials {
    List<Materiale> frozenMaterials = [];

    MaterialsCatalogState mcState = _materialsCatalogController.materialsCatalogState.value;

    if (mcState is MCSCommon) {
      cartItems.forEach((e) {
        Materiale? m = mcState.catalog.materials.firstWhereOrNull(
          (element) => element.MaterialNumber == e.materialNumber,
        );

        if (m is Materiale && m.IsFrozen) {
          frozenMaterials.add(m);
        }
      });
    }

    return frozenMaterials;
  }

  List<Materiale> get dryMaterials {
    List<Materiale> dryMaterials = [];

    MaterialsCatalogState mcState = _materialsCatalogController.materialsCatalogState.value;

    if (mcState is MCSCommon) {
      cartItems.forEach((e) {
        Materiale? m = mcState.catalog.materials.firstWhereOrNull(
          (element) => element.MaterialNumber == e.materialNumber,
        );

        if (m is Materiale && !m.IsFrozen) {
          dryMaterials.add(m);
        }
      });
    }

    return dryMaterials;
  }

  double get dryItemsPrice {
    double dryPrice = 0;

    MaterialsCatalogState mcState = _materialsCatalogController.materialsCatalogState.value;

    if (mcState is MCSCommon) {
      cartItems.forEach((e) {
        Materiale? m = mcState.catalog.materials.firstWhereOrNull(
          (element) => element.MaterialNumber == e.materialNumber,
        );

        if (m is Materiale && !m.IsFrozen) {
          dryPrice += m.UnitNetPrice * m.countByUnitType(e.salesUnitType) * e.quantity;
          ;
        }
      });
    }

    return dryPrice;
  }

  double get frozenItemsPrice {
    double frozenPrice = 0;

    MaterialsCatalogState mcState = _materialsCatalogController.materialsCatalogState.value;

    if (mcState is MCSCommon) {
      cartItems.forEach((e) {
        Materiale? m = mcState.catalog.materials.firstWhereOrNull(
          (element) => element.MaterialNumber == e.materialNumber,
        );

        if (m is Materiale && m.IsFrozen) {
          frozenPrice += m.UnitNetPrice * m.countByUnitType(e.salesUnitType) * e.quantity;
          ;
        }
      });
    }

    return frozenPrice;
  }

  double get totalPrice => frozenItemsPrice + dryItemsPrice;
}
