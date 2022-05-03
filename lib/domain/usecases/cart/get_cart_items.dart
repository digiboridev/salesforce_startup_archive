import 'package:***REMOVED***/data/repositories/cart_repository.dart';
import 'package:***REMOVED***/domain/entities/cart_item.dart';
import 'package:***REMOVED***/domain/usecases/usecase.dart';

class GetCartItems implements UseCase<List<CartItem>, GetCartItemsParams> {
  final CartRepository cartRepository;

  GetCartItems(this.cartRepository);

  @override
  Future<List<CartItem>> call(GetCartItemsParams params) async {
    return cartRepository.getItemsByCustomer(customerSAP: params.customerSAP);
  }
}

class GetCartItemsParams {
  final String customerSAP;
  GetCartItemsParams({
    required this.customerSAP,
  });
}
