import 'package:get/get.dart';
import 'package:speed_meter_app/app/controllers/ride_controller.dart';

class NumPadController extends GetxController {
  RxString extraAmount = ''.obs;

  RideController ridecontroller = Get.put(RideController());

  @override
  void onInit() {
    extraAmount.value = '';
    super.onInit();
  }

  void addDigit(String digit) {
    if (extraAmount.value.length < 10) {
      extraAmount.value += digit;
    }
  }

  void onConfrm() {
    if (extraAmount.value.isNotEmpty) {
      final tExtra = double.parse(extraAmount.value);
      ridecontroller.addExtraAmount(tExtra);
      clearNumber();
    } else {
      return;
    }
  }

  void clearNumber() {
    extraAmount.value = '';
  }
}
