import 'package:***REMOVED***/data/models/sync_data.dart';
import 'package:***REMOVED***/data/repositories/customers_repository.dart';
import 'package:***REMOVED***/domain/usecases/usecase.dart';

class GetCustomerSyncData implements UseCase<SyncData, String> {
  final CustomersRepository customersRepository;

  GetCustomerSyncData(this.customersRepository);

  @override
  Future<SyncData> call(customerSAP) async {
    SyncData d =
        await customersRepository.getCustomerSyncData(customerSAP: customerSAP);
    return d;
  }
}
