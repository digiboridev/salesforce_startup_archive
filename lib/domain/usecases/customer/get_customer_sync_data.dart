import 'package:salesforce.startup/data/models/sync_data.dart';
import 'package:salesforce.startup/data/repositories/customers_repository.dart';
import 'package:salesforce.startup/domain/usecases/usecase.dart';

class GetCustomerSyncData implements UseCase<SyncData, String> {
  final CustomersRepository customersRepository;

  GetCustomerSyncData(this.customersRepository);

  @override
  Future<SyncData> call(customerSAP) async {
    SyncData d = await customersRepository.getCustomerSyncData(customerSAP: customerSAP);
    return d;
  }
}
