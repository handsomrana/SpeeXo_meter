import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:speed_meter_app/app/controllers/ride_controller.dart';
import 'package:speed_meter_app/app/local_database/isar_services.dart';
import 'package:speed_meter_app/app/widgets/add_extra_widget.dart';
import 'package:speed_meter_app/app/widgets/add_tolls_dialog.dart';
import 'package:speed_meter_app/app/widgets/end_alert_dialog_widget.dart';
import 'package:speed_meter_app/utils/styles.dart';
import 'package:speed_meter_app/utils/colors.dart';

// ignore: must_be_immutable
class RideView extends StatelessWidget {
  RideView({super.key});

  final IsarServices isarServices = IsarServices();

  String formatTime(String time) {
    if (time.isEmpty) return '';
    final DateTime dateTime = DateTime.parse(time);
    return DateFormat('yyyy-MM-dd – kk:mm').format(dateTime);
  }

  void _showAddExtraDialog(BuildContext context, bool isTablet) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddExtraWidget(orientation: isTablet);
      },
    );
  }

  void _showTollsDialog(BuildContext context, bool isTablet) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddTollsDialogWidget(
          sizeFor: isTablet,
        );
      },
    );
  }

  void showEndAlert(BuildContext context, bool isTablet) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return EndAlertDialogWidget(orientation: isTablet);
        });
  }

  RideController rideController = Get.put(RideController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(48, 49, 85, 1),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 67, 69, 118),
        title: Obx(
          () => Text(
            rideController.selectedPackage.value,
            style: GoogleFonts.kalam(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isTablet = constraints.maxWidth >= 600;
          double padding = isTablet ? 16.0 : 16.0;
          double fontSize = isTablet ? 24.0 : 16.0;
          double buttonFontSize = isTablet ? 20.0 : 16.0;
          Axis direction = isTablet ? Axis.horizontal : Axis.vertical;

          return Padding(
            padding: EdgeInsets.all(padding),
            child: GetBuilder<RideController>(
              init: RideController(),
              builder: (controller) {
                return Center(
                  child: isTablet
                      ? tabletOrientationView(
                          controller,
                          fontSize,
                          buttonFontSize,
                          context,
                          false,
                          direction,
                        )
                      : mobileOrientationView(controller, fontSize,
                          buttonFontSize, context, direction, true),
                );
              },
            ),
          );
        },
      ),
    );
  }

  SingleChildScrollView tabletOrientationView(
      RideController controller,
      double fontSize,
      double buttonFontSize,
      BuildContext context,
      bool isTablet,
      Axis direction) {
    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/map2.jpeg",
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height * 1,
            width: MediaQuery.of(context).size.width * 0.5,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (controller.isTunnel)
                  Text(
                    'Tunnel Detected',
                    style: GoogleFonts.blackOpsOne(
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                Text(
                  'Fare: ${controller.newStreamFare.toStringAsFixed(1)} \$',
                  style: GoogleFonts.blackOpsOne(
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Distance: ${controller.totalStreamDistance.toStringAsFixed(1)} km',
                  style: GoogleFonts.sairaCondensed(
                    fontSize: 20,
                    color: Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Waiting Time: ${controller.getFormattedWaitingTime()} minutes',
                  style: GoogleFonts.sairaCondensed(
                    fontSize: 20,
                    color: Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Testing',
                  style: GoogleFonts.kalam(
                    fontSize: 20,
                    color: darkMainColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Geolocator: \n ${controller.geolocatorTestPosition.toString()}',
                  style: GoogleFonts.sairaCondensed(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _showAddExtraDialog(context, isTablet);
                      },
                      style: elevatedButtonStyle,
                      child: Text(
                        "Add Extra",
                        style: elevatdButtonTextstyle,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _showTollsDialog(
                          context,
                          isTablet,
                        );
                      },
                      style: elevatedButtonStyle,
                      child: Text(
                        "Add Tolls",
                        style: elevatdButtonTextstyle,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            showEndAlert(context, isTablet);
                          },
                          style: elevatedButtonStyle.copyWith(),
                          child: Text(
                            "End Ride",
                            style: elevatdButtonTextstyle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column mobileOrientationView(
      RideController controller,
      double fontSize,
      double buttonFontSize,
      BuildContext context,
      Axis direction,
      bool isTablet) {
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
        if (controller.isTunnel)
          Text(
            'Tunnel Detected',
            style: GoogleFonts.blackOpsOne(
              fontSize: 40,
              color: Colors.white,
            ),
          ),
        Text(
          'Fare: ${controller.newStreamFare.toStringAsFixed(1)} \$',
          style: GoogleFonts.blackOpsOne(
            fontSize: 40,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Distance: ${controller.totalStreamDistance.toStringAsFixed(1)} km',
          style: GoogleFonts.sairaCondensed(
            fontSize: 20,
            color: Colors.white.withOpacity(0.8),
            fontWeight: FontWeight.bold,
          ),
        ),

        Text(
          'Waiting Time: ${controller.getFormattedWaitingTime()} minutes',
          style: GoogleFonts.sairaCondensed(
            fontSize: 20,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
        const SizedBox(height: 30),
        Text(
          'Testing',
          style: GoogleFonts.kalam(
            fontSize: 20,
            color: darkMainColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Geolocator: \n ${controller.geolocatorTestPosition.toString()}',
          style: GoogleFonts.sairaCondensed(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                _showAddExtraDialog(context, isTablet);
              },
              style: elevatedButtonStyle,
              child: Text(
                "Add Extra",
                style: elevatdButtonTextstyle,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _showTollsDialog(
                  context,
                  isTablet,
                );
              },
              style: elevatedButtonStyle,
              child: Text(
                "Add Tolls",
                style: elevatdButtonTextstyle,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  onPressed: () {
                    showEndAlert(context, isTablet);
                  },
                  style: elevatedButtonStyle.copyWith(),
                  child: Text(
                    "End Ride",
                    style: elevatdButtonTextstyle,
                  ),
                ),
              ),
            ),
          ],
        ),
        // ElevatedButton(
        //   onPressed: controller.isTracking
        //       ? controller.stopTracking
        //       : controller.startTracking,
        //   child: Text(
        //     controller.isTracking ? 'Stop' : 'Start',
        //     style: TextStyle(fontSize: buttonFontSize),
        //   ),
        // ),
      ],
    );
  }
}
