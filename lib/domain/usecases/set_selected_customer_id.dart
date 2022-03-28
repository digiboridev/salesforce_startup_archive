import 'package:***REMOVED***/data/repositories/customers_repository.dart';
import 'package:***REMOVED***/domain/usecases/usecase.dart';

class SetSelectedCustomerId
    implements UseCase<void, SetSelectedCustomerIdParams> {
  final CustomersRepository customersRepository;

  SetSelectedCustomerId(this.customersRepository);

  @override
  Future<void> call(params) async {
    return customersRepository.setSelectedCustomerId(
        userId: params.userId, consumerId: params.customerId);
  }
}

class SetSelectedCustomerIdParams {
  final String userId;
  final String customerId;
  SetSelectedCustomerIdParams({
    required this.userId,
    required this.customerId,
  });
}
