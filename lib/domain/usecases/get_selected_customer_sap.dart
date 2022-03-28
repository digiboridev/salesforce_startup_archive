import 'package:***REMOVED***/data/repositories/customers_repository.dart';
import 'package:***REMOVED***/domain/usecases/usecase.dart';

class GetSelectedCustomerSAP
    implements UseCase<String?, GetSelectedCustomerSAPParams> {
  final CustomersRepository customersRepository;

  GetSelectedCustomerSAP(this.customersRepository);

  @override
  Future<String?> call(params) async {
    try {
      return await customersRepository.getSelectedCustomerSAP(
          userId: params.userId);
    } catch (e) {
      print(e);
      return null;
    }
  }
}

class GetSelectedCustomerSAPParams {
  final String userId;
  GetSelectedCustomerSAPParams({
    required this.userId,
  });
}
