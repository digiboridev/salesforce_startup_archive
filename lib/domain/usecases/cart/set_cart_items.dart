import 'package:salesforce.startup/data/repositories/cart_repository.dart';
import 'package:salesforce.startup/domain/entities/cart_item.dart';
import 'package:salesforce.startup/domain/usecases/usecase.dart';

class SetCartItems implements UseCase<void, SetCartItemsParams> {
  final CartRepository cartRepository;
  SetCartItems(this.cartRepository);

  @override
  Future<void> call(SetCartItemsParams params) async {
    await cartRepository.setItemsByCustomer(customerSAP: params.customerSAP, items: params.items);
  }
}

class SetCartItemsParams {
  final String customerSAP;
  final List<CartItem> items;
  SetCartItemsParams({
    required this.customerSAP,
    required this.items,
  });
}
