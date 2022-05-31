import 'package:***REMOVED***/core/errors.dart';
import 'package:***REMOVED***/data/models/sync_data.dart';
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
      Customer cachedCustomer = await _loadCache(params: params);
      return cachedCustomer;
    } catch (e) {
      if (!params.hasConnetrion) {
        throw InternalException('No connection');
      }

      Customer remoteCustomer = await customersRepository
          .getRemoteCustomerBySAP(customerSAP: params.customerSAP);

      customersRepository.setLocalCustomerBySAP(
          customerSAP: params.customerSAP, customer: remoteCustomer);
      customersRepository.setCustomerSyncData(
          customerSAP: params.customerSAP,
          syncData:
              SyncData(syncDateTime: DateTime.now(), locale: params.locale));
      return remoteCustomer;
    }
  }

  Future<Customer> _loadCache(
      {required GetCustomerAndCacheParams params}) async {
    if (await _cacheValid(params: params)) {
      return customersRepository.getLocalCustomerBySAP(
          customerSAP: params.customerSAP);
    } else {
      throw InternalException('Unable to load that customer');
    }
  }

  Future<bool> _cacheValid({required GetCustomerAndCacheParams params}) async {
    try {
      SyncData syncData = await customersRepository.getCustomerSyncData(
          customerSAP: params.customerSAP);

      Duration diff = DateTime.now().difference(syncData.syncDateTime);

      if (diff.inMinutes < 30 && syncData.locale == params.locale) {
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
  final String locale;
  GetCustomerAndCacheParams({
    required this.customerSAP,
    required this.hasConnetrion,
    required this.locale,
  });
}
