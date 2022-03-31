import 'package:***REMOVED***/data/datasouces/contact_us_local_datasource.dart';
import 'package:***REMOVED***/data/datasouces/contact_us_remote_datasource.dart';
import 'package:***REMOVED***/data/models/contact_us_data_model.dart';
import 'package:***REMOVED***/domain/entities/contact_us_data.dart';

abstract class ContactUsRepository {
  Future<ContactUsData> get getRemoteContactUs;
  Future<ContactUsData> get getLocalContactUs;
  Future setLocalContactUs({required ContactUsData contactUsData});
}

class ContactUsRepositoryImpl extends ContactUsRepository {
  final ContactUsRemoteDatasource contactUsRemoteDatasource;
  final ContactUsLocalDatasource contactUsLocalDatasource;

  ContactUsRepositoryImpl({
    required this.contactUsRemoteDatasource,
    required this.contactUsLocalDatasource,
  });

  Future<ContactUsData> get getRemoteContactUs =>
      contactUsRemoteDatasource.getContactUs;

  Future<ContactUsData> get getLocalContactUs =>
      contactUsLocalDatasource.getContactUs;

  Future setLocalContactUs({required ContactUsData contactUsData}) =>
      contactUsLocalDatasource.setContactUs(
          contactUsataModel: ContactUsataModel.fromEntity(contactUsData));
}
