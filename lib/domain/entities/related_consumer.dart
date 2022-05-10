import 'package:equatable/equatable.dart';

class RelatedConsumer extends Equatable {
  final String lastOrderDate;
  final String customerSAPNumber;
  final String customerName;
  final String customerId;
  final String customerAddress;
  RelatedConsumer({
    required this.lastOrderDate,
    required this.customerSAPNumber,
    required this.customerName,
    required this.customerId,
    required this.customerAddress,
  });

  @override
  List<Object> get props {
    return [
      lastOrderDate,
      customerSAPNumber,
      customerName,
      customerId,
      customerAddress,
    ];
  }

  @override
  String toString() {
    return 'RelatedConsumer(lastOrderDate: $lastOrderDate, customerSAPNumber: $customerSAPNumber, customerName: $customerName, customerId: $customerId, customerAddress: $customerAddress)';
  }
}
