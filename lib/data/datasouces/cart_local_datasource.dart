import 'package:***REMOVED***/core/errors.dart';
import 'package:***REMOVED***/data/models/cart_item_model.dart';
import 'package:get_storage/get_storage.dart';

abstract class CartLocalDatasource {
  Future<List<CartItemModel>> getItemsByCustomer({required String customerSAP});
  Future setItemsByCustomer(
      {required String customerSAP, required List<CartItemModel> items});
}

class CartLocalDatasourceImpl extends CartLocalDatasource {
  final cartBox = GetStorage('cartBox');

  Future<List<CartItemModel>> getItemsByCustomer(
      {required String customerSAP}) async {
    List? data = cartBox.read(customerSAP);

    if (data == null) {
      throw CacheException('No cached cart data for $customerSAP');
    }

    return data.map((e) => CartItemModel.fromJson(e)).toList();
  }

  Future setItemsByCustomer(
      {required String customerSAP, required List<CartItemModel> items}) async {
    await cartBox.write(customerSAP, items.map((e) => e.toJson()).toList());
  }
}
