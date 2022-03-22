import 'dart:convert';
import 'package:***REMOVED***/domain/entities/user_data.dart';

class UserDataModel extends UserData {
  UserDataModel({
    required String sFUserId,
    required String selectedLanguage,
    required bool requireLegalDocSign,
    required List relatedCustomers,
    required Uri legalDoc,
    required bool isSystemAdmin,
    required bool isStandardUser,
    required bool isSalesAdmin,
    required bool isMerchandiser,
    required String imageUrl,
    required bool hasAcceptedLegalDoc,
    required bool didChangePassword,
    required String defaultLanguage,
    required String currencyKey,
    required String country,
    required String contactName,
    required String contactMobile,
    required String contactLastName,
    required String contactId,
    required String contactFirstName,
    required String contactEmail,
    required String availableLanguages,
  }) : super(
          sFUserId: sFUserId,
          selectedLanguage: selectedLanguage,
          requireLegalDocSign: requireLegalDocSign,
          relatedCustomers: relatedCustomers,
          legalDoc: legalDoc,
          isSystemAdmin: isSystemAdmin,
          isStandardUser: isStandardUser,
          isSalesAdmin: isSalesAdmin,
          isMerchandiser: isMerchandiser,
          imageUrl: imageUrl,
          hasAcceptedLegalDoc: hasAcceptedLegalDoc,
          didChangePassword: didChangePassword,
          defaultLanguage: defaultLanguage,
          currencyKey: currencyKey,
          country: country,
          contactName: contactName,
          contactMobile: contactMobile,
          contactLastName: contactLastName,
          contactId: contactId,
          contactFirstName: contactFirstName,
          contactEmail: contactEmail,
          availableLanguages: availableLanguages,
        );

  Map<String, dynamic> toMap() {
    return {
      'sFUserId': sFUserId,
      'selectedLanguage': selectedLanguage,
      'requireLegalDocSign': requireLegalDocSign,
      'relatedCustomers': relatedCustomers,
      'legalDoc': legalDoc.toString(),
      'isSystemAdmin': isSystemAdmin,
      'isStandardUser': isStandardUser,
      'isSalesAdmin': isSalesAdmin,
      'isMerchandiser': isMerchandiser,
      'imageUrl': imageUrl,
      'hasAcceptedLegalDoc': hasAcceptedLegalDoc,
      'didChangePassword': didChangePassword,
      'defaultLanguage': defaultLanguage,
      'currencyKey': currencyKey,
      'country': country,
      'contactName': contactName,
      'contactMobile': contactMobile,
      'contactLastName': contactLastName,
      'contactId': contactId,
      'contactFirstName': contactFirstName,
      'contactEmail': contactEmail,
      'availableLanguages': availableLanguages,
    };
  }

  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    return UserDataModel(
      sFUserId: map['SFUserId'] ?? '',
      selectedLanguage: map['SelectedLanguage'] ?? '',
      requireLegalDocSign: map['RequireLegalDocSign'] ?? false,
      relatedCustomers: List.from(map['RelatedCustomers'] ?? const []),
      legalDoc: Uri.parse(map['LegalDoc']),
      isSystemAdmin: map['isSystemAdmin'] ?? false,
      isStandardUser: map['isStandardUser'] ?? false,
      isSalesAdmin: map['isSalesAdmin'] ?? false,
      isMerchandiser: map['isMerchandiser'] ?? false,
      imageUrl: map['ImageUrl'] ?? '',
      hasAcceptedLegalDoc: map['HasAcceptedLegalDoc'] ?? false,
      didChangePassword: map['DidChangePassword'] ?? false,
      defaultLanguage: map['DefaultLanguage'] ?? '',
      currencyKey: map['CurrencyKey'] ?? '',
      country: map['Country'] ?? '',
      contactName: map['ContactName'] ?? '',
      contactMobile: map['ContactMobile'] ?? '',
      contactLastName: map['ContactLastName'] ?? '',
      contactId: map['ContactId'] ?? '',
      contactFirstName: map['ContactFirstName'] ?? '',
      contactEmail: map['ContactEmail'] ?? '',
      availableLanguages: map['AvailableLanguages'] ?? '',
    );
  }

  factory UserDataModel.fromEnitty(UserData userData) {
    return UserDataModel(
      sFUserId: userData.sFUserId,
      selectedLanguage: userData.selectedLanguage,
      requireLegalDocSign: userData.requireLegalDocSign,
      relatedCustomers: userData.relatedCustomers,
      legalDoc: userData.legalDoc,
      isSystemAdmin: userData.isSystemAdmin,
      isStandardUser: userData.isStandardUser,
      isSalesAdmin: userData.isSalesAdmin,
      isMerchandiser: userData.isMerchandiser,
      imageUrl: userData.imageUrl,
      hasAcceptedLegalDoc: userData.hasAcceptedLegalDoc,
      didChangePassword: userData.didChangePassword,
      defaultLanguage: userData.defaultLanguage,
      currencyKey: userData.currencyKey,
      country: userData.country,
      contactName: userData.contactName,
      contactMobile: userData.contactMobile,
      contactLastName: userData.contactLastName,
      contactId: userData.contactId,
      contactFirstName: userData.contactFirstName,
      contactEmail: userData.contactEmail,
      availableLanguages: userData.availableLanguages,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDataModel.fromJson(String source) =>
      UserDataModel.fromMap(json.decode(source));
}
