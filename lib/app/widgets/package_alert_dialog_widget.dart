import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speed_meter_app/app/controllers/package_alert_dialog_controller.dart';
import 'package:speed_meter_app/app/controllers/ride_controller.dart';
import 'package:speed_meter_app/app/views/ride_view.dart';
import 'package:speed_meter_app/app/widgets/custom_card.dart';
import 'package:speed_meter_app/utils/colors.dart';
import 'package:speed_meter_app/utils/styles.dart';

class PackageAlertDialogWidget extends StatelessWidget {
  PackageAlertDialogWidget({
    super.key,
    required this.rideController,
    required this.direction,
    required this.orientation,
  });

  final RideController rideController;
  final Axis direction;
  final bool orientation;

  final controller = Get.put(PackageController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: lightMainColor,
      title: Text(
        'Pick a Package',
        style: appBarTextStyle,
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        width: orientation
            ? MediaQuery.of(context).size.width * 0.7
            : MediaQuery.of(context).size.width,
        height: orientation
            ? MediaQuery.of(context).size.height * 0.8
            : MediaQuery.of(context).size.height * 0.5,
        child: Obx(
          () => controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(
                    color: lightGradientColor,
                  ),
                )
              : ListView(
                  scrollDirection: direction,
                  shrinkWrap: true,
                  children: <Widget>[
                    CustomCard(
                        heading: "S1 Package",
                        startRate: "4.92",
                        pricePerKm: "2.29",
                        waitingTime: "0.95",
                        orientation: orientation,
                        onTap: () async {
                          controller.isLoading.value = true;
                          rideController.setPackage1();
                          await rideController.startTracking();
                          Navigator.pop(context);
                          Get.to(() => RideView());
                          controller.onClose();
                        }),
                    CustomCard(
                        heading: "S2 Package",
                        startRate: "4.92",
                        pricePerKm: "2.73",
                        waitingTime: "0.95",
                        orientation: orientation,
                        onTap: () async {
                          controller.isLoading.value = true;
                          rideController.setPackage2();
                          await rideController.startTracking();
                          Navigator.pop(context);
                          Get.to(() => RideView());
                          controller.onClose();
                        }),
                    CustomCard(
                        heading: "S3 Package",
                        startRate: "7.42",
                        pricePerKm: "2.73",
                        waitingTime: "0.95",
                        orientation: orientation,
                        onTap: () async {
                          controller.isLoading.value = true;
                          rideController.setPackage3();
                          await rideController.startTracking();
                          Navigator.pop(context);
                          Get.to(() => RideView());
                          controller.onClose();
                        }),
                  ],
                ),
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: elevatedButtonStyle,
          child: Text(
            'Cancel',
            style: elevatdButtonTextstyle,
          ),
        ),
      ],
    );
  }
}
