import 'package:simple_connection_checker/simple_connection_checker.dart';
import 'package:get/get.dart';

class ConnectionService extends GetxService {
  SimpleConnectionChecker _simpleConnectionChecker = SimpleConnectionChecker();
  ConnectionService();

  late RxBool _hasConnection;
  bool get hasConnection => _hasConnection.value;

  Future<ConnectionService> init() async {
    _hasConnection =
        RxBool(await SimpleConnectionChecker.isConnectedToInternet());
    return this;
  }

  @override
  void onReady() {
    super.onReady();
    _hasConnection.bindStream(_simpleConnectionChecker.onConnectionChange);
  }
}
