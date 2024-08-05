import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speed_meter_app/app/controllers/ride_controller.dart';
import 'package:speed_meter_app/utils/colors.dart';
import 'package:speed_meter_app/utils/styles.dart';

// ignore: must_be_immutable
class EndAlertDialogWidget extends StatelessWidget {
  EndAlertDialogWidget({super.key, required this.orientation});

  final bool orientation;
  RideController rideController = Get.put(RideController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: darkMainColor,
      title: Text(
        "End Ride",
        textAlign: TextAlign.center,
        style: appBarTextStyle,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            // "Do you want to end ride \n with total Fare of ${rideController.totalFare.toStringAsFixed(1)} \$ ",
            "Do you want to end ride ? ",
            style: GoogleFonts.sairaCondensed(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              rideController.stopTracking();
              Get.back();
              Get.back();
            },
            style: elevatedButtonStyle,
            child: Text(
              "Confrm",
              style: elevatdButtonTextstyle,
            ),
          ),
        ],
      ),
    );
  }
}
