import 'package:***REMOVED***/data/repositories/customers_repository.dart';
import 'package:***REMOVED***/domain/entities/customer.dart';
import 'package:***REMOVED***/domain/usecases/usecase.dart';

class GetCustomersAndCache
    implements UseCase<List<Customer>, GetCustomersAndCacheParams> {
  final CustomersRepository customersRepository;

  GetCustomersAndCache(this.customersRepository);

  @override
  Future<List<Customer>> call(params) async {
    try {
      List<Customer> remoteCustomersList = [];

      for (String sap in params.customersSAP) {
        try {
          Customer c = await customersRepository.getRemoteCustomerBySAP(
              customerSAP: sap);
          remoteCustomersList.add(c);
        } catch (e) {
          print(e);
        }
      }

      customersRepository.setCustomersListToCache(
          userId: params.userId, customers: remoteCustomersList);

      return remoteCustomersList;
    } catch (e) {
      print(e);
      return customersRepository.getCustomersListFromCache(
          userId: params.userId);
    }
  }
}

class GetCustomersAndCacheParams {
  final List<String> customersSAP;
  final String userId;
  GetCustomersAndCacheParams({
    required this.customersSAP,
    required this.userId,
  });
}
