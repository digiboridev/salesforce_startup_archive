import 'package:***REMOVED***/core/constants.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';
import 'package:get/get.dart';

class ConnectionService extends GetxService {
  SimpleConnectionChecker _simpleConnectionChecker = SimpleConnectionChecker();
  ConnectionService();

  late RxBool _hasConnection;
  bool get hasConnection => _hasConnection.value;

  Future<ConnectionService> init() async {
    _hasConnection = RxBool(await SimpleConnectionChecker.isConnectedToInternet(
        // lookUpAddress: ***REMOVED***
        ));
    return this;
  }

  @override
  void onReady() {
    super.onReady();
    // _simpleConnectionChecker.setLookUpAddress(***REMOVED***);
    _hasConnection.bindStream(_simpleConnectionChecker.onConnectionChange);

    _hasConnection.listen((p0) {
      print('Connection: ' + _hasConnection.value.toString());
    });
  }
}
