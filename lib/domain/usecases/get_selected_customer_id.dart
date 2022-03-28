import 'package:***REMOVED***/data/repositories/customers_repository.dart';
import 'package:***REMOVED***/domain/usecases/usecase.dart';

class GetSelectedCustomerId
    implements UseCase<String?, GetSelectedCustomerIdParams> {
  final CustomersRepository customersRepository;

  GetSelectedCustomerId(this.customersRepository);

  @override
  Future<String?> call(params) async {
    try {
      return await customersRepository.getSelectedCustomerId(
          userId: params.userId);
    } catch (e) {
      print(e);
      return null;
    }
  }
}

class GetSelectedCustomerIdParams {
  final String userId;
  GetSelectedCustomerIdParams({
    required this.userId,
  });
}
