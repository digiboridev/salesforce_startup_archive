import 'package:***REMOVED***/data/datasouces/cart_local_datasource.dart';
import 'package:***REMOVED***/data/models/cart_item_model.dart';
import 'package:***REMOVED***/domain/entities/cart_item.dart';

abstract class CartRepository {
  Future<List<CartItem>> getItemsByCustomer({required String customerSAP});
  Future setItemsByCustomer(
      {required String customerSAP, required List<CartItem> items});
}

class CartRepositoryImpl extends CartRepository {
  final CartLocalDatasource cartLocalDatasource;
  CartRepositoryImpl({
    required this.cartLocalDatasource,
  });

  Future<List<CartItem>> getItemsByCustomer({required String customerSAP}) =>
      cartLocalDatasource.getItemsByCustomer(customerSAP: customerSAP);

  Future setItemsByCustomer(
          {required String customerSAP, required List<CartItem> items}) =>
      cartLocalDatasource.setItemsByCustomer(
          customerSAP: customerSAP,
          items: items.map((e) => CartItemModel.fromEntity(e)).toList());
}
