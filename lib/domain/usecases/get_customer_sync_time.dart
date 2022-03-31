import 'package:***REMOVED***/data/repositories/customers_repository.dart';
import 'package:***REMOVED***/data/repositories/user_data_repository.dart';
import 'package:***REMOVED***/domain/usecases/usecase.dart';

class GetCustomerSyncTime implements UseCase<DateTime, String> {
  final CustomersRepository customersRepository;

  GetCustomerSyncTime(this.customersRepository);

  @override
  Future<DateTime> call(customerSAP) async {
    try {
      DateTime d = await customersRepository.getCustomerSyncTime(
          customerSAP: customerSAP);
      return d;
    } catch (e) {
      return DateTime(1994);
    }
  }
}
