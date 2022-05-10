import 'dart:convert';
import 'package:***REMOVED***/domain/entities/related_consumer.dart';

class RelatedConsumerModel extends RelatedConsumer {
  RelatedConsumerModel({
    required String lastOrderDate,
    required String customerSAPNumber,
    required String customerName,
    required String customerId,
    required String customerAddress,
  }) : super(
            lastOrderDate: lastOrderDate,
            customerSAPNumber: customerSAPNumber,
            customerName: customerName,
            customerId: customerId,
            customerAddress: customerAddress);

  Map<String, dynamic> toMap() {
    return {
      'LastOrderDate': lastOrderDate,
      'CustomerSAPNumber': customerSAPNumber,
      'CustomerName': customerName,
      'CustomerId': customerId,
      'CustomerAddress': customerAddress,
    };
  }

  factory RelatedConsumerModel.fromMap(Map<String, dynamic> map) {
    return RelatedConsumerModel(
      lastOrderDate: map['LastOrderDate'] ?? '',
      customerSAPNumber: map['CustomerSAPNumber'] ?? '',
      customerName: map['CustomerName'] ?? '',
      customerId: map['CustomerId'] ?? '',
      customerAddress: map['CustomerAddress'] ?? '',
    );
  }

  factory RelatedConsumerModel.fromEnitty(RelatedConsumer relatedConsumer) {
    return RelatedConsumerModel(
      lastOrderDate: relatedConsumer.lastOrderDate,
      customerSAPNumber: relatedConsumer.customerSAPNumber,
      customerName: relatedConsumer.customerName,
      customerId: relatedConsumer.customerId,
      customerAddress: relatedConsumer.customerAddress,
    );
  }

  String toJson() => json.encode(toMap());

  factory RelatedConsumerModel.fromJson(String source) =>
      RelatedConsumerModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RelatedConsumer(lastOrderDate: $lastOrderDate, customerSAPNumber: $customerSAPNumber, customerName: $customerName, customerId: $customerId, customerAddress: $customerAddress)';
  }
}
