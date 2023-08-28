import 'dart:convert';
import 'package:salesforce.startup/domain/entities/cart_item.dart';

class CartItemModel extends CartItem {
  CartItemModel({required String materialNumber, required String unit, required num quantity})
      : super(materialNumber: materialNumber, unit: unit, quantity: quantity);

  Map<String, dynamic> toMap() {
    return {
      'materialNumber': materialNumber,
      'unit': unit,
      'quantity': quantity,
    };
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      materialNumber: map['materialNumber'],
      unit: map['unit'],
      quantity: map['quantity'],
    );
  }
  factory CartItemModel.fromEntity(CartItem cartItem) {
    return CartItemModel(
      materialNumber: cartItem.materialNumber,
      unit: cartItem.unit,
      quantity: cartItem.quantity,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItemModel.fromJson(String source) => CartItemModel.fromMap(json.decode(source));
}
