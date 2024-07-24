import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speed_meter_app/app/controllers/ride_controller.dart';
import 'package:speed_meter_app/utils/colors.dart';
import 'package:speed_meter_app/utils/styles.dart';

class DriverDataWidgetContainer extends StatelessWidget {
  const DriverDataWidgetContainer({
    super.key,
    required this.isTablet,
  });

  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(
      init: RideController(),
      builder: (controller) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          height: isTablet
              ? MediaQuery.sizeOf(context).height * 0.4
              : MediaQuery.sizeOf(context).height * 0.4,
          width: double.infinity,
          decoration: containerBoxDecoration,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('assets/images/driverimge.jpeg'),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fare: ${controller.totalLocalFare.toStringAsFixed(2)} km',
                    style: GoogleFonts.sairaCondensed(
                      fontSize: 30,
                      color: darkMainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Distance: ${controller.totalDistance.toStringAsFixed(4)} km',
                    style: GoogleFonts.sairaCondensed(
                      fontSize: 20,
                      color: darkMainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Local Distance: ${controller.totalLocalDistance.toStringAsFixed(4)} km',
                    style: GoogleFonts.sairaCondensed(
                      fontSize: 20,
                      color: darkMainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Straight Distance: ${controller.totalStraightDistance.toStringAsFixed(4)} km',
                    style: GoogleFonts.sairaCondensed(
                      fontSize: 20,
                      color: darkMainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
