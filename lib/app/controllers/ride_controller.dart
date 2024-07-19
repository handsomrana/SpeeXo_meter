import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:speed_meter_app/app/local_database/collections/ride_collection.dart';
import 'package:speed_meter_app/app/local_database/isar_services.dart';
import 'dart:async';
import 'package:speed_meter_app/utils/vacent_disatance.dart';

class RideController extends GetxController {
  final IsarServices isarServices = IsarServices();
  double packageCost = 4.92;
  double movingRate = 2.29;
  double waitingRate = 0.01583;
  double extraAmount = 0.0;
  double tollsAmount = 0.0;
  // Position? tunnelTestingPosition;
  double totalFare = 0.0;
  double movingFare = 0.0;
  double waitingFare = 0.0;
  bool isTracking = false;
  bool isMoving = false;
  bool isPackage1 = false;
  bool isPackage2 = false;
  bool isPackage3 = false;
  double totalDistance = 0.0;
  double speed = 0.0;
  String startTime = '';
  String endTime = '';
  Position? lastPosition;
  Position? startPosition;
  // Position? tunnelStartPosition;
  // Position? tunnelEndPosition;
  // double tunnelDistance = 0.0;
  // double tunnelFare = 0.0;
  // double totalTunnelFare = 0.0;
  // double tunnelTime = 0.0;
  // String tunnelStartTime = '';
  // String tunnelEndTime = '';
  // bool isTunnel = false;

  StreamSubscription<Position>? positionStreamSubscription;
  Timer? updateTimer;
  int waitingTime = 0; // Store waiting time in seconds
  int movingTime = 0;

  Future<void> startTracking() async {
    if (!(await _checkLocationPermission())) {
      await _requestLocationPermission();
    }

    if (await _checkLocationPermission()) {
      isTracking = true;
      isMoving = false;
      startTime = DateTime.now().toString();
      endTime = '';
      totalDistance = 0.0;
      speed = 0.0;
      extraAmount = 0.0;
      tollsAmount = 0.0;
      startPosition = await Geolocator.getCurrentPosition();
      lastPosition = null;
      waitingTime = 0;
      movingTime = 0;
      totalFare = 0.0;
      movingFare = 0.0;
      waitingFare = 0.0;
      // tunnelTime = 0.0;
      // tunnelDistance = 0.0;
      // tunnelFare = 0.0;
      // totalTunnelFare = 0.0;
      // tunnelStartTime = '';
      // tunnelEndTime = '';
      // isTunnel = false;
      update();

      positionStreamSubscription = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 1,
        ),
      ).listen((Position position) async {
        final currentSpeed = position.speed * 3.6;

        if (lastPosition != null) {
          final distance = vincentyDistance(
            lastPosition!.latitude,
            lastPosition!.longitude,
            position.latitude,
            position.longitude,
          );

          if (currentSpeed >= 1) {
            // isMoving = true;
            // movingTime += 1;
            totalDistance += distance / 1000;
          } else if (currentSpeed < 1) {
            // isMoving = false;
            // waitingTime += 1;
            // totalDistance += (distance - 0.001) / 1000;
          }
          // calculateFare();
          speed = currentSpeed;
          update();
        }
        lastPosition = await Geolocator.getLastKnownPosition();
        // lastPosition = position;
      });

      updateTimer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) async {
          if (isTracking) {
            if (speed < 25) {
              isMoving = false;
              waitingTime += 1;
            } else if (speed >= 25) {
              isMoving = true;
              movingTime += 1;
            }
            calculateFare();
            update();
          }
        },
      );
    } else {
      if (kDebugMode) {
        print('Location permission not granted');
      }
    }
  }

  // Future<void> onResumeTracking() async {
  //   if (!(await _checkLocationPermission())) {
  //     await _requestLocationPermission();
  //   }

  //   if (await _checkLocationPermission()) {
  //     isTracking = true;
  //     isMoving = false;
  //     isTunnel = false;
  //     speed = 0.0;
  //     // lastPosition = await Geolocator.getCurrentPosition();
  //     lastPosition = null;
  //     tunnelEndPosition = await Geolocator.getCurrentPosition();
  //     tunnelEndTime = DateTime.now().toString();
  //     calculateTunnelFare();
  //     update();

  //     positionStreamSubscription = Geolocator.getPositionStream(
  //       locationSettings: const LocationSettings(
  //         accuracy: LocationAccuracy.high,
  //         distanceFilter: 1,
  //       ),
  //     ).listen((Position position) {
  //       final currentSpeed = position.speed * 3.6;

  //       if (lastPosition == null) {
  //         tunnelTime += 1;
  //         update();
  //       }
  //       if (lastPosition != null) {
  //         final distance = vincentyDistance(
  //           lastPosition!.latitude,
  //           lastPosition!.longitude,
  //           position.latitude,
  //           position.longitude,
  //         );

  //         if (currentSpeed >= 1) {
  //           // isMoving = true;
  //           // movingTime += 1;
  //           totalDistance += distance / 1000;
  //         } else if (currentSpeed < 1) {
  //           // isMoving = false;
  //           // waitingTime += 1;
  //           // totalDistance += (distance - 0.001) / 1000;
  //         }
  //         // calculateFare();
  //         speed = currentSpeed;
  //         update();
  //       }

  //       lastPosition = position;
  //     });

  //     updateTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
  //       if (isTracking) {
  //         if (speed < 25) {
  //           isMoving = false;
  //           waitingTime += 1;
  //         } else if (speed >= 25) {
  //           isMoving = true;
  //           movingTime += 1;
  //         }
  //         calculateFare();
  //         update();
  //       }
  //     });
  //   } else {
  //     if (kDebugMode) {
  //       print('Location permission not granted');
  //     }
  //   }
  // }

  // Future<void> onPauseTracking() async {
  //   isTracking = false;
  //   isTunnel = true;
  //   // endTime = DateTime.now().toString();
  //   positionStreamSubscription?.cancel();
  //   updateTimer?.cancel();
  //   tunnelDistance = 0.0;
  //   tunnelFare = 0.0;
  //   tunnelEndPosition = null;
  //   tunnelStartPosition = await Geolocator.getCurrentPosition();
  //   tunnelStartTime = DateTime.now().toString();
  //   tunnelEndTime = '';
  //   update();
  // }

  // void calculateTunnelFare() {
  //   final tunDistance = Geolocator.distanceBetween(
  //       tunnelStartPosition!.latitude,
  //       tunnelStartPosition!.longitude,
  //       tunnelEndPosition!.latitude,
  //       tunnelEndPosition!.longitude);
  //   if (tunnelStartTime.isEmpty || tunnelEndTime.isEmpty) {
  //     return;
  //   }
  //   final DateTime tstartTime = DateTime.parse(tunnelStartTime);
  //   final DateTime tendTime = DateTime.parse(tunnelEndTime);
  //   final Duration tduration = tendTime.difference(tstartTime);
  //   tunnelTime = tduration.inSeconds.toDouble();

  //   tunnelDistance = tunDistance / 1000;
  //   double tunspeed = (tunDistance / tunnelTime) * 3.6;

  //   if (tunspeed > 25) {
  //     tunnelFare = tunnelDistance * movingRate;
  //   } else if (tunspeed <= 25) {
  //     tunnelFare = tunnelTime * waitingRate;
  //   }
  //   totalDistance += tunnelDistance;
  //   totalTunnelFare += tunnelFare;
  //   totalFare += totalTunnelFare;
  //   update();
  // }

  void stopTracking() async {
    isTracking = false;
    endTime = DateTime.now().toString();
    addRidetoLocal();
    positionStreamSubscription?.cancel();
    updateTimer?.cancel();
    await isarServices.getRides();
    update();
  }

  // Future<void> tunnelPositionTesting() async {
  //   Timer.periodic(const Duration(seconds: 1), (timer) async {
  //     tunnelTestingPosition = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high,
  //     );
  //     update();
  //   });
  // }

  @override
  void onClose() {
    positionStreamSubscription?.cancel();
    updateTimer?.cancel();
    isTracking = false;
    isMoving = false;
    super.onClose();
  }

  @override
  void onInit() async {
    super.onInit();
    await isarServices.getRides();
  }

  Future<bool> _checkLocationPermission() async {
    final permission = await Geolocator.checkPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  Future<void> _requestLocationPermission() async {
    final permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.always &&
        permission != LocationPermission.whileInUse) {
      if (kDebugMode) {
        print('Location permission denied');
      }
    }
  }

  String getFormattedWaitingTime() {
    final int minutes = waitingTime ~/ 60;
    final int seconds = waitingTime % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  String getFormattedMovingTime() {
    final int minutes = movingTime ~/ 60;
    final int seconds = movingTime % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void addRidetoLocal() async {
    final newRide = RideCollection(
        userId: '001',
        packageType: isPackage1
            ? "S1"
            : isPackage2
                ? "S2"
                : isPackage3
                    ? "S3"
                    : "DEFAULT",
        startLocation: startPosition.toString(),
        endLocation: lastPosition.toString(),
        fare: totalFare.toStringAsFixed(1),
        distance: totalDistance.toStringAsFixed(1),
        duration: calculateDuration(startTime, endTime),
        startTime: startTime,
        endTime: endTime,
        tolls: tollsAmount.toStringAsFixed(1),
        status: "COMPLETED");

    await isarServices.addRide(newRide);
  }

  void addExtraAmount(double amount) {
    extraAmount = amount;
    update();
  }

  void addTollsAmount(double amount) {
    tollsAmount = amount;
    update();
  }

  void calculateFare() {
    movingFare = totalDistance * movingRate;
    waitingFare = waitingTime * waitingRate;
    totalFare =
        tollsAmount + extraAmount + packageCost + movingFare + waitingFare;
  }

  String calculateDuration(String start, String end) {
    if (start.isEmpty || end.isEmpty) return '';
    final DateTime startTime = DateTime.parse(start);
    final DateTime endTime = DateTime.parse(end);
    final Duration duration = endTime.difference(startTime);
    double totalMinutes = duration.inSeconds / 60.0;
    return '${totalMinutes.toStringAsFixed(2)} minute';
  }

  void setPackage1() {
    waitingRate = 0.01583;
    movingRate = 2.29;
    packageCost = 4.92;
    isPackage1 = true;
  }

  void setPackage2() {
    waitingRate = 0.01583;
    movingRate = 2.73;
    packageCost = 4.92;
    isPackage2 = true;
  }

  void setPackage3() {
    waitingRate = 0.01583;
    movingRate = 2.73;
    packageCost = 7.42;
    isPackage3 = true;
  }
}
