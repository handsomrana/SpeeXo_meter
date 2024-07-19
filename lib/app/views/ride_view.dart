import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:speed_meter_app/app/controllers/ride_controller.dart';
import 'package:speed_meter_app/app/local_database/isar_services.dart';
import 'package:speed_meter_app/app/widgets/add_extra_widget.dart';
import 'package:speed_meter_app/app/widgets/add_tolls_dialog.dart';
import 'package:speed_meter_app/app/widgets/package_alert_dialog_widget.dart';

// ignore: must_be_immutable
class RideView extends StatelessWidget {
  RideView({super.key});

  final isarr = IsarServices();

  String formatTime(String time) {
    if (time.isEmpty) return '';
    final DateTime dateTime = DateTime.parse(time);
    return DateFormat('yyyy-MM-dd – kk:mm').format(dateTime);
  }

  String calculateDuration(String start, String end) {
    if (start.isEmpty || end.isEmpty) return '';
    final DateTime startTime = DateTime.parse(start);
    final DateTime endTime = DateTime.parse(end);
    final Duration duration = endTime.difference(startTime);
    double totalMinutes = duration.inSeconds / 60.0;
    return '${totalMinutes.toStringAsFixed(2)} minute';
  }

  void _showDialog(BuildContext context, Axis direction) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PackageAlertDialogWidget(
            rideController: rideController, direction: direction);
      },
    );
  }

  void _showAddExtraDialog(BuildContext context, bool isTablet) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddExtraWidget(orientation: isTablet);
      },
    );
  }

  void _showTollsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddTollsDialogWidget(
            // rideController: rideController,
            );
      },
    );
  }

  RideController rideController = Get.put(RideController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fare Tracker'),
        automaticallyImplyLeading: false,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isTablet = constraints.maxWidth >= 600;
          double padding = isTablet ? 32.0 : 16.0;
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
            "assets/images/map.jpeg",
            fit: BoxFit.cover,
            height: 400,
            width: 300,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fare: ${controller.totalFare.toStringAsFixed(1)} \$',
                  style: TextStyle(
                    fontSize: fontSize + 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (!controller.isTracking &&
                    controller.endTime.isNotEmpty) ...[
                  Text(
                    'Duration: ${calculateDuration(controller.startTime, controller.endTime)}',
                    style: TextStyle(fontSize: fontSize),
                  ),
                ],
                Text(
                  'Distance: ${controller.totalDistance.toStringAsFixed(1)} km',
                  style: TextStyle(
                    fontSize: fontSize + 4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Waiting Time: ${controller.getFormattedWaitingTime()} minutes',
                  style: TextStyle(fontSize: fontSize),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (!controller.isTunnel || controller.isMoving)
                      ElevatedButton(
                        onPressed: controller.isTracking
                            ? controller.stopTracking
                            : controller.startTracking,
                        child: Text(
                          controller.isTracking ? 'Stop' : 'Start',
                          style: TextStyle(fontSize: buttonFontSize),
                        ),
                      ),
                    if (!controller.isTracking && !controller.isTunnel)
                      ElevatedButton(
                        onPressed: () {
                          controller.stopTracking();
                          _showDialog(context, direction);
                        },
                        child: Text(
                          "Select Package",
                          style: TextStyle(fontSize: buttonFontSize),
                        ),
                      ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _showAddExtraDialog(context, isTablet);
                      },
                      child: Text(
                        "Add Extra",
                        style: TextStyle(fontSize: buttonFontSize),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _showTollsDialog(
                          context,
                        );
                      },
                      child: Text(
                        "Add Tolls",
                        style: TextStyle(fontSize: buttonFontSize),
                      ),
                    ),
                  ],
                )
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
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/map.jpeg",
          fit: BoxFit.cover,
          height: 200,
          width: double.maxFinite,
        ),
        if (!controller.isTracking && controller.endTime.isNotEmpty) ...[
          Text(
            'Duration: ${calculateDuration(controller.startTime, controller.endTime)}',
            style: TextStyle(fontSize: fontSize),
          ),
        ],
        Text(
          'Distance: ${controller.totalDistance.toStringAsFixed(1)} km',
          style: TextStyle(
            fontSize: fontSize + 4,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Fare: ${controller.totalFare.toStringAsFixed(1)} \$',
          style: TextStyle(
            fontSize: fontSize + 4,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Waiting Time: ${controller.getFormattedWaitingTime()} minutes',
          style: TextStyle(fontSize: fontSize),
        ),
        const SizedBox(height: 20),
        if (!controller.isTunnel || controller.isMoving)
          ElevatedButton(
            onPressed: controller.isTracking
                ? controller.stopTracking
                : controller.startTracking,
            child: Text(
              controller.isTracking ? 'Stop' : 'Start',
              style: TextStyle(fontSize: buttonFontSize),
            ),
          ),
        const SizedBox(height: 10),
        if (!controller.isTracking && !controller.isTunnel)
          ElevatedButton(
            onPressed: () {
              controller.stopTracking();
              _showDialog(context, direction);
            },
            child: Text(
              "Select Package",
              style: TextStyle(fontSize: buttonFontSize),
            ),
          ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                _showAddExtraDialog(context, isTablet);
              },
              child: Text(
                "Add Extra",
                style: TextStyle(fontSize: buttonFontSize),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _showTollsDialog(
                  context,
                );
              },
              child: Text(
                "Add Tolls",
                style: TextStyle(fontSize: buttonFontSize),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                isarr.storeRideCollection();
              },
              child: Text(
                "Add History",
                style: TextStyle(fontSize: buttonFontSize),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                isarr.readRideCollection();
              },
              child: Text(
                "Show History",
                style: TextStyle(fontSize: buttonFontSize),
              ),
            ),
          ],
        ),
        if (isarr.readedCollections != null)
          Text(isarr.readedCollections!.fare.toString()),
        // if (!controller.isTracking && !controller.isTunnel)
        // ElevatedButton(
        //   onPressed: () {
        //     if (controller.isTunnel) {
        //       controller.onResumeTracking();
        //     } else {
        //       controller.onPauseTracking();
        //     }
        //   },
        //   child: Text(
        //     controller.isTunnel ? "End Tunnel" : "Start Tunnel",
        //     style: TextStyle(fontSize: buttonFontSize),
        //   ),
        // ),
        // const SizedBox(height: 10),
      ],
    );
  }
}
