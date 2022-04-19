import 'package:***REMOVED***/core/errors.dart';
import 'package:***REMOVED***/data/repositories/customers_repository.dart';
import 'package:***REMOVED***/domain/entities/customer.dart';
import 'package:***REMOVED***/domain/usecases/usecase.dart';

class GetCustomerAndCache
    implements UseCase<Customer, GetCustomerAndCacheParams> {
  final CustomersRepository customersRepository;

  GetCustomerAndCache(this.customersRepository);

  @override
  Future<Customer> call(params) async {
    if (params.hasConnetrion) {
      try {
        Customer remoteCustomer = await customersRepository
            .getRemoteCustomerBySAP(customerSAP: params.customerSAP);

        customersRepository.setLocalCustomerBySAP(
            customerSAP: params.customerSAP, customer: remoteCustomer);
        customersRepository.setCustomerSyncTime(
            customerSAP: params.customerSAP, dateTime: DateTime.now());
        return remoteCustomer;
      } catch (e) {
        return _loadCache(customerSAP: params.customerSAP);
      }
    } else {
      return _loadCache(customerSAP: params.customerSAP);
    }
  }

  Future<Customer> _loadCache({required String customerSAP}) async {
    if (await _cacheUpToDate(customerSAP: customerSAP)) {
      return customersRepository.getLocalCustomerBySAP(
          customerSAP: customerSAP);
    } else {
      throw InternalException('Unable to load that customer');
    }
  }

  Future<bool> _cacheUpToDate({required String customerSAP}) async {
    try {
      DateTime lastSync = await customersRepository.getCustomerSyncTime(
          customerSAP: customerSAP);
      Duration diff = DateTime.now().difference(lastSync);

      if (diff.inMinutes < 30) {
        return true;
      }
    } catch (e) {
      print('No user data cache');
    }
    return false;
  }
}

class GetCustomerAndCacheParams {
  final String customerSAP;
  final bool hasConnetrion;
  GetCustomerAndCacheParams({
    required this.customerSAP,
    required this.hasConnetrion,
  });
}
