import 'dart:convert';

import 'package:***REMOVED***/domain/entities/contact_us_data.dart';

class ContactUsataModel extends ContactUsData {
  @override
  final OpeningHoursModel openingHours;
  @override
  final List<ContactOptionModel> contactOptionsList;

  ContactUsataModel({
    required this.openingHours,
    required String openingHoursString,
    required this.contactOptionsList,
  }) : super(
            openingHours: openingHours,
            openingHoursString: openingHoursString,
            contactOptionsList: contactOptionsList);

  Map<String, dynamic> toMap() {
    return {
      'openingHours': openingHours.toMap(),
      'openingHoursString': openingHoursString,
      'contactOptionsList': contactOptionsList.map((x) => x.toMap()).toList(),
    };
  }

  factory ContactUsataModel.fromMap(Map<String, dynamic> map) {
    return ContactUsataModel(
      openingHours: OpeningHoursModel.fromMap(map['openingHours']),
      openingHoursString: map['openingHoursString'] ?? '',
      contactOptionsList: List<ContactOptionModel>.from(
          map['contactOptionsList']
                  ?.map((x) => ContactOptionModel.fromMap(x)) ??
              const []),
    );
  }

  factory ContactUsataModel.fromEntity(ContactUsData contactUsata) {
    return ContactUsataModel(
      openingHours: OpeningHoursModel.fromEntity(contactUsata.openingHours),
      openingHoursString: contactUsata.openingHoursString,
      contactOptionsList: contactUsata.contactOptionsList
          .map((e) => ContactOptionModel.fromEntity(e))
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactUsataModel.fromJson(String source) =>
      ContactUsataModel.fromMap(json.decode(source));
}

class OpeningHoursModel extends OpeningHours {
  OpeningHoursModel({
    required DateTime startDate,
    required DateTime endDate,
  }) : super(startDate: startDate, endDate: endDate);

  Map<String, dynamic> toMap() {
    return {
      'startDate': startDate.toString(),
      'endDate': endDate.toString(),
    };
  }

  factory OpeningHoursModel.fromMap(Map<String, dynamic> map) {
    return OpeningHoursModel(
      startDate: DateTime.parse(map['startDate']),
      endDate: DateTime.parse(map['endDate']),
    );
  }

  factory OpeningHoursModel.fromEntity(OpeningHours openingHours) {
    return OpeningHoursModel(
      startDate: openingHours.startDate,
      endDate: openingHours.endDate,
    );
  }

  String toJson() => json.encode(toMap());

  factory OpeningHoursModel.fromJson(String source) =>
      OpeningHoursModel.fromMap(json.decode(source));
}

class ContactOptionModel extends ContactOption {
  ContactOptionModel({
    required String description,
    required String phoneNumber,
    required String agentCode,
    required String email,
    required String whatsAppLink,
  }) : super(
            description: description,
            phoneNumber: phoneNumber,
            agentCode: agentCode,
            email: email,
            whatsAppLink: whatsAppLink);

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'phoneNumber': phoneNumber,
      'agentCode': agentCode,
      'email': email,
      'whatsAppLink': whatsAppLink,
    };
  }

  factory ContactOptionModel.fromMap(Map<String, dynamic> map) {
    return ContactOptionModel(
      description: map['description'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      agentCode: map['agentCode'] ?? '',
      email: map['email'] ?? '',
      whatsAppLink: map['whatsAppLink'] ?? '',
    );
  }

  factory ContactOptionModel.fromEntity(ContactOption contactOption) {
    return ContactOptionModel(
      description: contactOption.description,
      phoneNumber: contactOption.phoneNumber,
      agentCode: contactOption.agentCode,
      email: contactOption.email,
      whatsAppLink: contactOption.whatsAppLink,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactOptionModel.fromJson(String source) =>
      ContactOptionModel.fromMap(json.decode(source));
}
