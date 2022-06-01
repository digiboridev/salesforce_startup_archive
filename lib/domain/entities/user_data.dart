import 'package:***REMOVED***/domain/entities/related_consumer.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

class UserData extends Equatable {
  final String sFUserId;
  final String selectedLanguage;
  final bool requireLegalDocSign;
  final List<RelatedConsumer> relatedCustomers;
  final Uri legalDoc;
  final bool isSystemAdmin;
  final bool isStandardUser;
  final bool isSalesAdmin;
  final bool isMerchandiser;
  final String imageUrl;
  final bool hasAcceptedLegalDoc;
  final bool didChangePassword;
  final String defaultLanguage;
  final String currencyKey;
  final String country;
  final String contactName;
  final String contactMobile;
  final String contactLastName;
  final String contactId;
  final String contactFirstName;
  final String contactEmail;
  final String availableLanguages;
  UserData({
    required this.sFUserId,
    required this.selectedLanguage,
    required this.requireLegalDocSign,
    required this.relatedCustomers,
    required this.legalDoc,
    required this.isSystemAdmin,
    required this.isStandardUser,
    required this.isSalesAdmin,
    required this.isMerchandiser,
    required this.imageUrl,
    required this.hasAcceptedLegalDoc,
    required this.didChangePassword,
    required this.defaultLanguage,
    required this.currencyKey,
    required this.country,
    required this.contactName,
    required this.contactMobile,
    required this.contactLastName,
    required this.contactId,
    required this.contactFirstName,
    required this.contactEmail,
    required this.availableLanguages,
  });

  @override
  String toString() {
    return 'UserData(sFUserId: $sFUserId, selectedLanguage: $selectedLanguage, requireLegalDocSign: $requireLegalDocSign, relatedCustomers: $relatedCustomers, legalDoc: $legalDoc, isSystemAdmin: $isSystemAdmin, isStandardUser: $isStandardUser, isSalesAdmin: $isSalesAdmin, isMerchandiser: $isMerchandiser, imageUrl: $imageUrl, hasAcceptedLegalDoc: $hasAcceptedLegalDoc, didChangePassword: $didChangePassword, defaultLanguage: $defaultLanguage, currencyKey: $currencyKey, country: $country, contactName: $contactName, contactMobile: $contactMobile, contactLastName: $contactLastName, contactId: $contactId, contactFirstName: $contactFirstName, contactEmail: $contactEmail, availableLanguages: $availableLanguages)';
  }

  @override
  List<Object> get props {
    return [
      sFUserId,
      selectedLanguage,
      requireLegalDocSign,
      relatedCustomers,
      legalDoc,
      isSystemAdmin,
      isStandardUser,
      isSalesAdmin,
      isMerchandiser,
      imageUrl,
      hasAcceptedLegalDoc,
      didChangePassword,
      defaultLanguage,
      currencyKey,
      country,
      contactName,
      contactMobile,
      contactLastName,
      contactId,
      contactFirstName,
      contactEmail,
      availableLanguages,
    ];
  }

  RelatedConsumer? closestRelatedCustomer(
      {required double lattitude, required double longtitude}) {
    RelatedConsumer? closestCustomer;
    double minDistance = double.infinity;

    relatedCustomers.forEach((element) {
      double distance = Geolocator.distanceBetween(
          lattitude, longtitude, element.latitude, element.longitude);

      if (distance < minDistance) {
        minDistance = distance;
        closestCustomer = element;
      }
    });
    return closestCustomer;
  }
}
