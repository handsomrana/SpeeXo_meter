import 'package:get/get.dart';
import 'package:speed_meter_app/app/controllers/ride_controller.dart';
import 'package:speed_meter_app/app/models/tolls_model.dart';

class TollController extends GetxController {
  RideController rideController = Get.put(RideController());

  var tolls = <TollModel>[
    TollModel(name: "Harbour Bridge", price: 4.00),
    TollModel(name: "Airport Fee", price: 5.45),
    TollModel(name: "EASTERN DISTRIBUTOR", price: 9.29),
    TollModel(name: "WESTCONNEX-M4-MB LINK", price: 5.65),
    TollModel(name: "CROSSCITY TUNNEL", price: 6.77),
    TollModel(name: "LANECOVE TUNNEL", price: 3.93),
    TollModel(name: "M5 SOUTH WEST MOTORWAY", price: 5.54),
    TollModel(name: "WESTCONNEX-M5 EAST", price: 7.98),
  ].obs;

  double get totalToll => tolls
      .where((toll) => toll.isSelected)
      .fold(0, (sum, item) => sum + item.price);

  void toggleTollSelection(int index) {
    tolls[index].isSelected = !tolls[index].isSelected;
    tolls.refresh();
  }

  void addNewToll(String tollName, String tollPrice) {
    final tPrice = double.parse(tollPrice);
    final newToll = TollModel(
      name: tollName,
      price: tPrice,
      isSelected: false,
    );
    // ignore: invalid_use_of_protected_member
    tolls.value.add(newToll);
    tolls.refresh();
  }

  void addTollsAmount() {
    final ttoll = totalToll;
    rideController.addTollsAmount(ttoll);
  }
}
