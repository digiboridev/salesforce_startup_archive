import 'package:simple_connection_checker/simple_connection_checker.dart';
import 'package:get/get.dart';

// class ConnectionService {
//   ConnectionService._constructor()
//       : _hasConnectionStream =
//             SimpleConnectionChecker().onConnectionChange.asBroadcastStream();

//   static final ConnectionService _instance = ConnectionService._constructor();

//   factory ConnectionService() {
//     return _instance;
//   }
//   Stream<bool> _hasConnectionStream;
//   Stream<bool> get hasConnectionStream => _hasConnectionStream;
//   Future<bool> get hasConnection =>
//       SimpleConnectionChecker.isConnectedToInternet();
// }

class ConnectionService extends GetxService {
  SimpleConnectionChecker _simpleConnectionChecker = SimpleConnectionChecker();

  RxBool _hasConnection = RxBool(true);
  bool get hasConnection => _hasConnection.value;

  @override
  void onReady() {
    super.onReady();
    _hasConnection.bindStream(_simpleConnectionChecker.onConnectionChange);
  }
}
