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
}
