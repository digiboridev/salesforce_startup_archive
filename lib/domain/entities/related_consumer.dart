import 'package:equatable/equatable.dart';

class RelatedConsumer extends Equatable {
  final String lastOrderDate;
  final String customerSAPNumber;
  final String customerName;
  final String customerId;
  final String customerAddress;
  final double latitude;
  final double longitude;
  RelatedConsumer({
    required this.lastOrderDate,
    required this.customerSAPNumber,
    required this.customerName,
    required this.customerId,
    required this.customerAddress,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object> get props {
    return [
      lastOrderDate,
      customerSAPNumber,
      customerName,
      customerId,
      customerAddress,
      latitude,
      longitude,
    ];
  }

  @override
  String toString() {
    return 'RelatedConsumer(lastOrderDate: $lastOrderDate, customerSAPNumber: $customerSAPNumber, customerName: $customerName, customerId: $customerId, customerAddress: $customerAddress, latitude: $latitude, longitude: $longitude)';
  }
}
