import 'dart:math';

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

  double distanceTo({required double lattitude, required double longtitude}) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((this.latitude - lattitude) * p) / 2 +
        c(lattitude * p) *
            c(this.latitude * p) *
            (1 - c((this.longitude - longtitude) * p)) /
            2;
    double distance = 12742 * asin(sqrt(a));

    return distance;
  }

  @override
  String toString() {
    return 'RelatedConsumer(lastOrderDate: $lastOrderDate, customerSAPNumber: $customerSAPNumber, customerName: $customerName, customerId: $customerId, customerAddress: $customerAddress, latitude: $latitude, longitude: $longitude)';
  }
}
