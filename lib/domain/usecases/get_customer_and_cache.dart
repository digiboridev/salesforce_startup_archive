import 'package:***REMOVED***/data/repositories/customers_repository.dart';
import 'package:***REMOVED***/domain/entities/customer.dart';
import 'package:***REMOVED***/domain/usecases/usecase.dart';

class GetCustomerAndCache
    implements UseCase<Customer, GetCustomerAndCacheParams> {
  final CustomersRepository customersRepository;

  GetCustomerAndCache(this.customersRepository);

  @override
  Future<Customer> call(params) async {
    try {
      Customer remoteCustomer = await customersRepository
          .getRemoteCustomerBySAP(customerSAP: params.customerSAP);

      customersRepository.setLocalCustomerBySAP(
          customerSAP: params.customerSAP, customer: remoteCustomer);
      return remoteCustomer;
    } catch (e) {
      print(e);
      return customersRepository.getLocalCustomerBySAP(
          customerSAP: params.customerSAP);
    }
  }
}

class GetCustomerAndCacheParams {
  final String customerSAP;
  GetCustomerAndCacheParams({
    required this.customerSAP,
  });
}
