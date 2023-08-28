import 'package:salesforce.startup/domain/entities/contact_us_data.dart';
import 'package:salesforce.startup/domain/usecases/get_contactus_and_cache.dart';
import 'package:salesforce.startup/domain/usecases/usecase.dart';
import 'package:salesforce.startup/presentation/controllers/user_data_controller.dart';
import 'package:salesforce.startup/presentation/controllers/user_data_controller_states.dart';
import 'package:get/get.dart';

class ContactusController extends GetxController with StateMixin<ContactUsData> {
  GetContactusAndCache _getContactusAndCache = Get.find();
  UserDataController _userDataController = Get.find();

  @override
  void onReady() {
    super.onReady();
    _userDataController.userDataStateStream.listen((state) {
      if (state is UserDataCommonState) {
        load();
      }
    });
  }

  Future load() async {
    try {
      change(null, status: RxStatus.loading());
      ContactUsData data = await _getContactusAndCache.call(NoParams());
      change(data, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
