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
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SOLUTION 1',
                    style: GoogleFonts.kalam(
                      fontSize: 20,
                      color: darkMainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Geo Fare: \n ${controller.totalFare.toStringAsFixed(2)} \$',
                    style: GoogleFonts.sairaCondensed(
                      fontSize: 20,
                      color: darkMainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Distance: \n ${controller.totalDistance.toStringAsFixed(2)} km',
                    style: GoogleFonts.sairaCondensed(
                      fontSize: 15,
                      color: darkMainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Ride Distance: \n ${controller.rideDistance.toStringAsFixed(2)} km',
                    style: GoogleFonts.sairaCondensed(
                      fontSize: 15,
                      color: darkMainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const VerticalDivider(
                color: Colors.black54,
                thickness: 1,
                width: 1,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "SOLUTION 2",
                    style: GoogleFonts.kalam(
                      fontSize: 20,
                      color: darkMainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Local Fare: \n ${controller.totalLocalFare.toStringAsFixed(2)} \$',
                    style: GoogleFonts.sairaCondensed(
                      fontSize: 20,
                      color: darkMainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Local Distance: \n ${controller.totalLocalDistance.toStringAsFixed(2)} km',
                    style: GoogleFonts.sairaCondensed(
                      fontSize: 15,
                      color: darkMainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const VerticalDivider(
                color: Colors.black54,
                thickness: 1,
                width: 1,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SOLUTION 3',
                    style: GoogleFonts.kalam(
                      fontSize: 20,
                      color: darkMainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Location Fare: \n ${controller.totalStraightFare.toStringAsFixed(2)}',
                    style: GoogleFonts.sairaCondensed(
                      fontSize: 20,
                      color: darkMainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Distance: \n ${controller.totalStraightDistance.toStringAsFixed(2)} ',
                    style: GoogleFonts.sairaCondensed(
                      fontSize: 15,
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
