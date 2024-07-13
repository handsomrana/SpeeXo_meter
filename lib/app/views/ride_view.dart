import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:speed_meter_app/app/controllers/ride_controller.dart';
import 'package:speed_meter_app/app/widgets/package_alert_dialog_widget.dart';
import 'package:speed_meter_app/app/widgets/speed_meter_gauge.dart';

// ignore: must_be_immutable
class RideView extends StatelessWidget {
  RideView({super.key});

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
    return '${totalMinutes.toStringAsFixed(2)} minutes';
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

  RideController rideController = Get.put(RideController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Distance Tracker'),
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
                      ? SingleChildScrollView(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SpeedMeterGauge(
                                speed: controller.speed,
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // if (controller.startTime.isNotEmpty)
                                    //   Text(
                                    //     'Start Time: ${formatTime(controller.startTime)}',
                                    //     style: TextStyle(fontSize: fontSize),
                                    //   ),
                                    if (!controller.isTracking &&
                                        controller.endTime.isNotEmpty) ...[
                                      // Text(
                                      //   'End Time: ${formatTime(controller.endTime)}',
                                      //   style: TextStyle(fontSize: fontSize),
                                      // ),
                                      Text(
                                        'Duration: ${calculateDuration(controller.startTime, controller.endTime)}',
                                        style: TextStyle(fontSize: fontSize),
                                      ),
                                    ],
                                    Text(
                                      'Distance: ${controller.totalDistance.toStringAsFixed(3)} km',
                                      style: TextStyle(
                                        fontSize: fontSize + 4,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    // Text(
                                    //   'Speed: ${controller.speed.toStringAsFixed(2)} km/h',
                                    //   style: TextStyle(
                                    //     fontSize: fontSize + 4,
                                    //     fontWeight: FontWeight.bold,
                                    //   ),
                                    // ),
                                    Text(
                                      'Fare: ${controller.totalFare.toStringAsFixed(3)} \$',
                                      style: TextStyle(
                                        fontSize: fontSize + 4,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Waiting Time: ${controller.getFormattedWaitingTime()} minutes',
                                      style: TextStyle(fontSize: fontSize),
                                    ),
                                    // Text(
                                    //   'Waiting Fare: ${controller.waitingFare.toStringAsFixed(3)} \$',
                                    //   style: TextStyle(fontSize: fontSize),
                                    // ),
                                    const SizedBox(height: 2),
                                    ElevatedButton(
                                      onPressed: controller.isTracking
                                          ? controller.stopTracking
                                          : controller.startTracking,
                                      child: Text(
                                        controller.isTracking
                                            ? 'Stop'
                                            : 'Start',
                                        style:
                                            TextStyle(fontSize: buttonFontSize),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    ElevatedButton(
                                      onPressed: () {
                                        controller.stopTracking();
                                        _showDialog(context, direction);
                                      },
                                      child: Text(
                                        "Select Package",
                                        style:
                                            TextStyle(fontSize: buttonFontSize),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SpeedMeterGauge(
                              speed: controller.speed,
                            ),
                            // if (controller.startTime.isNotEmpty)
                            //   Text(
                            //     'Start Time: ${formatTime(controller.startTime)}',
                            //     style: TextStyle(fontSize: fontSize),
                            //   ),
                            if (!controller.isTracking &&
                                controller.endTime.isNotEmpty) ...[
                              // Text(
                              //   'End Time: ${formatTime(controller.endTime)}',
                              //   style: TextStyle(fontSize: fontSize),
                              // ),
                              Text(
                                'Duration: ${calculateDuration(controller.startTime, controller.endTime)}',
                                style: TextStyle(fontSize: fontSize),
                              ),
                            ],
                            Text(
                              'Distance: ${controller.totalDistance.toStringAsFixed(3)} km',
                              style: TextStyle(
                                fontSize: fontSize + 4,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // Text(
                            //   'Speed: ${controller.speed.toStringAsFixed(2)} km/h',
                            //   style: TextStyle(
                            //     fontSize: fontSize + 4,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                            Text(
                              'Fare: ${controller.totalFare.toStringAsFixed(3)} \$',
                              style: TextStyle(
                                fontSize: fontSize + 4,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Waiting Time: ${controller.getFormattedWaitingTime()} minutes',
                              style: TextStyle(fontSize: fontSize),
                            ),
                            // Text(
                            //   'Waiting Fare: ${controller.waitingFare.toStringAsFixed(3)} \$',
                            //   style: TextStyle(fontSize: fontSize),
                            // ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: controller.isTracking
                                  ? controller.stopTracking
                                  : controller.startTracking,
                              child: Text(
                                controller.isTracking ? 'Stop' : 'Start',
                                style: TextStyle(fontSize: buttonFontSize),
                              ),
                            ),
                            const SizedBox(height: 20),
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
                );
              },
            ),
          );
        },
      ),
    );
  }
}
