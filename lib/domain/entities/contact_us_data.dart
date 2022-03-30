import 'package:equatable/equatable.dart';

class ContactUsData extends Equatable {
  final OpeningHours openingHours;
  final String openingHoursString;
  final List<ContactOption> contactOptionsList;
  ContactUsData({
    required this.openingHours,
    required this.openingHoursString,
    required this.contactOptionsList,
  });

  @override
  List<Object> get props =>
      [openingHours, openingHoursString, contactOptionsList];

  @override
  String toString() =>
      'ContactUsata(openingHours: $openingHours, openingHoursString: $openingHoursString, contactOptions: $contactOptionsList)';
}

class OpeningHours extends Equatable {
  final DateTime startDate;
  final DateTime endDate;
  OpeningHours({
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object> get props => [startDate, endDate];

  @override
  String toString() => 'OpeningHours(startDate: $startDate, endDate: $endDate)';
}

class ContactOption extends Equatable {
  final String description;
  final String phoneNumber;
  final String agentCode;
  final String email;
  final String whatsAppLink;
  ContactOption({
    required this.description,
    required this.phoneNumber,
    required this.agentCode,
    required this.email,
    required this.whatsAppLink,
  });

  @override
  List<Object> get props {
    return [
      description,
      phoneNumber,
      agentCode,
      email,
      whatsAppLink,
    ];
  }

  @override
  String toString() {
    return 'ContactOption(description: $description, phoneNumber: $phoneNumber, agentCode: $agentCode, email: $email, whatsAppLink: $whatsAppLink)';
  }
}
