import 'package:equatable/equatable.dart';

class Customer extends Equatable {
  final String customerSAPNumber;
  final String customerName;
  final String customerId;
  final String customerAddress;
  final num vat;
  final bool showPriceWithVAT;
  final String salesOrganization;
  final bool returnEnabled;
  final String plantCode;
  final String paymentMethod;
  final DateTime? nextDeliveryFrozen;
  final DateTime nextDelivery;
  final DateTime nextCutOff;
  final num minimumOrderAmountFrozen;
  final num? minimumOrderAmount;
  final num? maximumReturnItems;
  final num maximumLinesInOrder;
  final String industryKey;
  final bool hidePrices;
  final bool hasUnpaidInvoice;
  final bool forceMinimum;
  final bool financialExportEnabled;
  final num distributionType;
  final String cutOffTime;
  final List creditCards;
  final String customerGroup;
  final List customerLineItems;
  final String countryKey;
  final String country;
  Customer({
    required this.customerSAPNumber,
    required this.customerName,
    required this.customerId,
    required this.customerAddress,
    required this.vat,
    required this.showPriceWithVAT,
    required this.salesOrganization,
    required this.returnEnabled,
    required this.plantCode,
    required this.paymentMethod,
    required this.nextDeliveryFrozen,
    required this.nextDelivery,
    required this.nextCutOff,
    required this.minimumOrderAmountFrozen,
    required this.minimumOrderAmount,
    required this.maximumReturnItems,
    required this.maximumLinesInOrder,
    required this.industryKey,
    required this.hidePrices,
    required this.hasUnpaidInvoice,
    required this.forceMinimum,
    required this.financialExportEnabled,
    required this.distributionType,
    required this.cutOffTime,
    required this.creditCards,
    required this.customerGroup,
    required this.customerLineItems,
    required this.countryKey,
    required this.country,
  });

  @override
  List<Object?> get props {
    return [
      customerSAPNumber,
      customerName,
      customerId,
      customerAddress,
      vat,
      showPriceWithVAT,
      salesOrganization,
      returnEnabled,
      plantCode,
      paymentMethod,
      nextDeliveryFrozen,
      nextDelivery,
      nextCutOff,
      minimumOrderAmountFrozen,
      minimumOrderAmount,
      maximumReturnItems,
      maximumLinesInOrder,
      industryKey,
      hidePrices,
      hasUnpaidInvoice,
      forceMinimum,
      financialExportEnabled,
      distributionType,
      cutOffTime,
      creditCards,
      customerGroup,
      customerLineItems,
      countryKey,
      country,
    ];
  }

  @override
  String toString() {
    return 'Customer(customerSAPNumber: $customerSAPNumber, customerName: $customerName, customerId: $customerId, customerAddress: $customerAddress, vat: $vat, showPriceWithVAT: $showPriceWithVAT, salesOrganization: $salesOrganization, returnEnabled: $returnEnabled, plantCode: $plantCode, paymentMethod: $paymentMethod, nextDeliveryFrozen: $nextDeliveryFrozen, nextDelivery: $nextDelivery, nextCutOff: $nextCutOff, minimumOrderAmountFrozen: $minimumOrderAmountFrozen, minimumOrderAmount: $minimumOrderAmount, maximumReturnItems: $maximumReturnItems, maximumLinesInOrder: $maximumLinesInOrder, industryKey: $industryKey, hidePrices: $hidePrices, hasUnpaidInvoice: $hasUnpaidInvoice, forceMinimum: $forceMinimum, financialExportEnabled: $financialExportEnabled, distributionType: $distributionType, cutOffTime: $cutOffTime, creditCards: $creditCards, customerGroup: $customerGroup, customerLineItems: $customerLineItems, countryKey: $countryKey, country: $country)';
  }
}
