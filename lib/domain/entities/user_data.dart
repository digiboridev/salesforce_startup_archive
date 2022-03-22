import 'package:flutter/foundation.dart';

class UserData {
  final String sFUserId;
  final String selectedLanguage;
  final bool requireLegalDocSign;
  final List relatedCustomers;
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
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserData &&
        other.sFUserId == sFUserId &&
        other.selectedLanguage == selectedLanguage &&
        other.requireLegalDocSign == requireLegalDocSign &&
        listEquals(other.relatedCustomers, relatedCustomers) &&
        other.legalDoc == legalDoc &&
        other.isSystemAdmin == isSystemAdmin &&
        other.isStandardUser == isStandardUser &&
        other.isSalesAdmin == isSalesAdmin &&
        other.isMerchandiser == isMerchandiser &&
        other.imageUrl == imageUrl &&
        other.hasAcceptedLegalDoc == hasAcceptedLegalDoc &&
        other.didChangePassword == didChangePassword &&
        other.defaultLanguage == defaultLanguage &&
        other.currencyKey == currencyKey &&
        other.country == country &&
        other.contactName == contactName &&
        other.contactMobile == contactMobile &&
        other.contactLastName == contactLastName &&
        other.contactId == contactId &&
        other.contactFirstName == contactFirstName &&
        other.contactEmail == contactEmail &&
        other.availableLanguages == availableLanguages;
  }

  @override
  int get hashCode {
    return sFUserId.hashCode ^
        selectedLanguage.hashCode ^
        requireLegalDocSign.hashCode ^
        relatedCustomers.hashCode ^
        legalDoc.hashCode ^
        isSystemAdmin.hashCode ^
        isStandardUser.hashCode ^
        isSalesAdmin.hashCode ^
        isMerchandiser.hashCode ^
        imageUrl.hashCode ^
        hasAcceptedLegalDoc.hashCode ^
        didChangePassword.hashCode ^
        defaultLanguage.hashCode ^
        currencyKey.hashCode ^
        country.hashCode ^
        contactName.hashCode ^
        contactMobile.hashCode ^
        contactLastName.hashCode ^
        contactId.hashCode ^
        contactFirstName.hashCode ^
        contactEmail.hashCode ^
        availableLanguages.hashCode;
  }

  @override
  String toString() {
    return 'UserData(sFUserId: $sFUserId, selectedLanguage: $selectedLanguage, requireLegalDocSign: $requireLegalDocSign, relatedCustomers: $relatedCustomers, legalDoc: $legalDoc, isSystemAdmin: $isSystemAdmin, isStandardUser: $isStandardUser, isSalesAdmin: $isSalesAdmin, isMerchandiser: $isMerchandiser, imageUrl: $imageUrl, hasAcceptedLegalDoc: $hasAcceptedLegalDoc, didChangePassword: $didChangePassword, defaultLanguage: $defaultLanguage, currencyKey: $currencyKey, country: $country, contactName: $contactName, contactMobile: $contactMobile, contactLastName: $contactLastName, contactId: $contactId, contactFirstName: $contactFirstName, contactEmail: $contactEmail, availableLanguages: $availableLanguages)';
  }
}
