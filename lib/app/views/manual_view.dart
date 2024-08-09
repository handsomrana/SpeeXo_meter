import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speed_meter_app/app/controllers/manual_controller.dart';
import 'package:speed_meter_app/utils/colors.dart';
import 'package:speed_meter_app/utils/styles.dart';

class ManualView extends StatelessWidget {
  const ManualView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkMainColor,
      appBar: AppBar(
        backgroundColor: lightMainColor,
        centerTitle: true,
        title: Text(
          "Debug Checker",
          style: GoogleFonts.kalam(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return GetBuilder<ManualRideController>(
          init: ManualRideController(),
          builder: (controller) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/map2.jpeg",
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.maxFinite,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  controller.isTunnel.value ? 'Tunnel Detected' : "",
                  style: GoogleFonts.blackOpsOne(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                Text(
                  controller.isError.value ? 'Location error Detected' : "",
                  style: GoogleFonts.blackOpsOne(
                    fontSize: 20,
                    color: Colors.red,
                  ),
                ),
                Text(
                  'Fare: ${controller.fare.value.toStringAsFixed(1)} \$',
                  style: GoogleFonts.blackOpsOne(
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Ride Distance: ${controller.totalRideDistance.value.toStringAsFixed(1)} km',
                  style: GoogleFonts.sairaCondensed(
                    fontSize: 20,
                    color: Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Covered Distance: ${controller.totalDistance.value.toStringAsFixed(1)} km',
                  style: GoogleFonts.sairaCondensed(
                    fontSize: 20,
                    color: Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'List Distance: ${controller.listDistance.value.toStringAsFixed(1)} km',
                  style: GoogleFonts.sairaCondensed(
                    fontSize: 20,
                    color: Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Waiting Time: ${controller.waitingTime.value.toStringAsFixed(1)} sec',
                  style: GoogleFonts.sairaCondensed(
                    fontSize: 20,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton(
                          onPressed: !controller.isTracking.value
                              ? controller.startTracking
                              : controller.stopTracking,
                          style: elevatedButtonStyle.copyWith(),
                          child: Text(
                            controller.isTracking.value
                                ? "End Ride"
                                : "Start Ride",
                            style: elevatdButtonTextstyle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      }),
    );
  }
}
