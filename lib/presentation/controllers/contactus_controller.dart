import 'package:***REMOVED***/domain/entities/contact_us_data.dart';
import 'package:***REMOVED***/domain/usecases/get_contactus_and_cache.dart';
import 'package:***REMOVED***/domain/usecases/usecase.dart';
import 'package:get/get.dart';

class ContactusController extends GetxController
    with StateMixin<ContactUsData> {
  GetContactusAndCache _getContactusAndCache = Get.find();

  @override
  void onReady() {
    super.onReady();
    load();
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
