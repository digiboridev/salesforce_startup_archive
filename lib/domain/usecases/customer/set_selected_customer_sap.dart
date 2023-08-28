import 'package:salesforce.startup/data/repositories/customers_repository.dart';
import 'package:salesforce.startup/domain/usecases/usecase.dart';

class SetSelectedCustomerSAP implements UseCase<void, SetSelectedCustomerSAPParams> {
  final CustomersRepository customersRepository;

  SetSelectedCustomerSAP(this.customersRepository);

  @override
  Future<void> call(params) async {
    return customersRepository.setSelectedCustomerSAP(userId: params.userId, customerSAP: params.customerSAP);
  }
}

class SetSelectedCustomerSAPParams {
  final String userId;
  final String customerSAP;
  SetSelectedCustomerSAPParams({
    required this.userId,
    required this.customerSAP,
  });
}
