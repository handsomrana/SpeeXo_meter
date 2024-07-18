import 'package:get/get.dart';
import 'package:speed_meter_app/app/controllers/ride_controller.dart';
import 'package:speed_meter_app/app/models/tolls_model.dart';

class TollController extends GetxController {
  RideController rideController = Get.put(RideController());

  var tolls = <Toll>[
    Toll(name: "Harbour Bridge", price: 4.00),
    Toll(name: "Airport Fee", price: 5.45),
    Toll(name: "EASTERN DISTRIBUTOR", price: 9.29),
    Toll(name: "WESTCONNEX-M4-MB LINK", price: 5.65),
    Toll(name: "CROSSCITY TUNNEL", price: 6.77),
    Toll(name: "LANECOVE TUNNEL", price: 3.93),
    Toll(name: "M5 SOUTH WEST MOTORWAY", price: 5.54),
    Toll(name: "WESTCONNEX-M5 EAST", price: 7.98),
  ].obs;

  double get totalToll => tolls
      .where((toll) => toll.isSelected)
      .fold(0, (sum, item) => sum + item.price);

  void toggleTollSelection(int index) {
    tolls[index].isSelected = !tolls[index].isSelected;
    tolls.refresh();
  }

  void addTollsAmount() {
    final ttoll = totalToll;
    rideController.addTollsAmount(ttoll);
  }
}
