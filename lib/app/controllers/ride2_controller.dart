import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:speed_meter_app/utils/vacent_disatance.dart';

class Ride2Controller extends GetxController {
  double packageCost = 4.92;
  double movingRate = 2.29;
  double waitingRate = 0.01583;
  double totalFare = 0.0;
  double movingFare = 0.0;
  double waitingFare = 0.0;
  bool isTracking = false;
  bool isMoving = false;
  double totalDistance = 0.0;
  double speed = 0.0;
  String startTime = '';
  String endTime = '';
  Position? lastPosition;
  Position? currentPosition;
  StreamSubscription<Position>? positionStreamSubscription;
  Timer? updateTimer;
  int waitingTime = 0; // Store waiting time in seconds
  int movingTime = 0;
  int tunnelTime = 0;

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
      currentPosition = await Geolocator.getCurrentPosition();
      lastPosition = await Geolocator.getCurrentPosition();
      // lastPosition = await Geolocator.getCurrentPosition();
      // lastPosition = null;
      waitingTime = 0;
      movingTime = 0;
      totalFare = 0.0;
      movingFare = 0.0;
      waitingFare = 0.0;
      update();

      // positionStreamSubscription = Geolocator.getPositionStream(
      //   locationSettings: const LocationSettings(
      //     accuracy: LocationAccuracy.high,
      //     distanceFilter: 1,
      //   ),
      // ).listen((Position position) {
      //   final currentSpeed = position.speed * 3.6;

      //   if (lastPosition == null) {
      //     tunnelTime += 1;
      //     update();
      //   }
      //   if (lastPosition != null) {
      //     final distance = vincentyDistance(
      //       lastPosition!.latitude,
      //       lastPosition!.longitude,
      //       position.latitude,
      //       position.longitude,
      //     );

      //     if (currentSpeed >= 5) {
      //       // isMoving = true;
      //       // movingTime += 1;
      //       totalDistance += distance / 1000;
      //     } else if (currentSpeed < 5) {
      //       // isMoving = false;
      //       // waitingTime += 1;
      //       // totalDistance += (distance - 0.001) / 1000;
      //     }
      //     // calculateFare();
      //     speed = currentSpeed;
      //     update();
      //   }

      //   lastPosition = position;
      // });

      updateTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
        if (isTracking) {
          if (speed < 2) {
            isMoving = false;
            waitingTime += 1;
          } else if (speed >= 2) {
            isMoving = true;
            movingTime += 1;
          }
          double dist = vincentyDistance(
            lastPosition!.latitude,
            lastPosition!.longitude,
            currentPosition!.latitude,
            currentPosition!.longitude,
          );
          double distm = dist / 1000;
          double tspeed = distm * 3.6;
          if (tspeed > 1) speed = tspeed;
          if (distm > 1) totalDistance += dist / 1000;

          print('distance: ${totalDistance.toStringAsFixed(3)}');
          print('speed: ${speed.toStringAsFixed(3)}');

          lastPosition = currentPosition;
          currentPosition = await Geolocator.getCurrentPosition();
          calculateFare();
          update();
        }
      });
    } else {
      if (kDebugMode) {
        print('Location permission not granted');
      }
    }
  }

  void stopTracking() {
    isTracking = false;
    endTime = DateTime.now().toString();
    positionStreamSubscription?.cancel();
    updateTimer?.cancel();
    update();
  }

  @override
  void onClose() {
    positionStreamSubscription?.cancel();
    updateTimer?.cancel();
    isTracking = false;
    super.onClose();
  }

  @override
  void onInit() async {
    super.onInit();

    setPackage1();
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

  void calculateFare() {
    movingFare = totalDistance * movingRate;
    waitingFare = waitingTime * waitingRate;
    totalFare = packageCost + movingFare + waitingFare;
  }

  void setPackage1() {
    waitingRate = 0.01583;
    movingRate = 2.29;
    packageCost = 4.92;
  }

  void setPackage2() {
    waitingRate = 0.01583;
    movingRate = 2.73;
    packageCost = 4.92;
  }

  void setPackage3() {
    waitingRate = 0.01583;
    movingRate = 2.73;
    packageCost = 7.42;
  }
}


// Timer.periodic(const Duration(seconds: 1), (timer) async {
//         if (isTracking) {
//           double dist = vincentyDistance(
//             lastPosition!.latitude,
//             lastPosition!.longitude,
//             currentPosition!.latitude,
//             currentPosition!.longitude,
//           );
//           double distm = dist / 1000;
//           double tspeed = distm * 3.6;
//           speed = tspeed;
//           if (distm > 1) totalDistance += dist / 1000;
//           print('distance: ${totalDistance.toStringAsFixed(3)}');
//           print('speed: ${speed.toStringAsFixed(3)}');

//           lastPosition = currentPosition;
//           currentPosition = await Geolocator.getCurrentPosition();
//         } else {
//           timer.cancel();
//         }
//       });