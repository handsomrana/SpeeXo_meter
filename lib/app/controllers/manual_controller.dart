import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:speed_meter_app/app/local_database/collections/tunnel_solution_collection.dart';
import 'package:speed_meter_app/utils/vacent_disatance.dart';

class ManualRideController extends GetxController {
  double packageCost = 4.92;
  double movingRate = 2.29;
  double waitingRate = 0.01583;
  final isTracking = false.obs;
  final isMoving = false.obs;
  final isTunnel = false.obs;
  final isError = false.obs;
  final positions = <TunnelSolutionCollection>[].obs;
  final fare = 0.0.obs;
  final totalDistance = 0.0.obs;
  final totalRideDistance = 0.0.obs;
  final tunnelDistance = 0.0.obs;
  final listDistance = 0.0.obs;
  final waitingTime = 0.0.obs;
  Position? lastPosition;
  Position? currentPosition;
  Position? previousPosition;

  Timer? timer;

  // late StreamSubscription<Position> positionStream;

  @override
  void onInit() async {
    super.onInit();
    if (!(await _checkLocationPermission())) {
      await _requestLocationPermission();
    }
    // startTracking();
  }

  void startTracking() async {
    if (!(await _checkLocationPermission())) {
      await _requestLocationPermission();
    }
    if (await _checkLocationPermission()) {
      isTracking.value = true;
      isError.value = false;
      isMoving.value = true;
      currentPosition = await Geolocator.getCurrentPosition();
      lastPosition = currentPosition;
      previousPosition = null;
      positions.add(TunnelSolutionCollection(
        positionLatitude: currentPosition!.latitude,
        positionLongitude: currentPosition!.longitude,
        timeStamp: DateTime.now(),
      ));
      fare.value = 0.0;
      totalDistance.value = 0.0;
      totalRideDistance.value = 0.0;
      tunnelDistance.value = 0.0;
      listDistance.value = 0.0;
      waitingTime.value = 0.0;
      update();
      // if (isTracking.value) {
      timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) async {
          currentPosition = await Geolocator.getCurrentPosition();
          if (currentPosition != null) {
            isError.value = false;
            if (checkTunnel()) {
              calculateTunnelDistance();
              update();
            } else {
              positions.add(
                TunnelSolutionCollection(
                  positionLatitude: currentPosition!.latitude,
                  positionLongitude: currentPosition!.longitude,
                  timeStamp: DateTime.now(),
                ),
              );
              final distanceInMeter = vincentyDistance(
                currentPosition!.latitude,
                currentPosition!.longitude,
                lastPosition!.latitude,
                lastPosition!.longitude,
              );
              if (distanceInMeter < 7) {
                waitingTime.value += 1;
                totalRideDistance.value += (distanceInMeter / 1000);
                update();
              } else if (distanceInMeter > 7) {
                totalDistance.value += distanceInMeter / 1000;
                totalRideDistance.value += distanceInMeter / 1000;
              }
              update();
            }
            calculateFare();
            calculateListDistance();
            lastPosition = currentPosition;
            update();
          } else {
            isError.value = true;
          }
        },
      );
      // }
    } else {
      isError.value = true;
      if (kDebugMode) {
        print('Location permission not granted ');
      }
    }
  }

  void stopTracking() {
    isTracking.value = false;
    positions.value = [];
    timer!.cancel();
    update();
    // positionStream.cancel();
  }

  void calculateListDistance() {
    double temDistance = 0.0;
    if (positions.isNotEmpty) {
      for (int i = 0; i < positions.length - 1; i++) {
        final start = positions[i];
        final end = positions[i + 1];
        if (start.positionLatitude == end.positionLatitude &&
            start.positionLongitude == end.positionLongitude) {
          continue;
        }
        if (start.positionLatitude == 0.0 &&
            start.positionLongitude == 0.0 &&
            end.positionLatitude == 0.0 &&
            end.positionLongitude == 0.0) {
          continue;
        }

        final distance = vincentyDistance(
          start.positionLatitude,
          start.positionLongitude,
          end.positionLatitude,
          end.positionLongitude,
        );
        if (distance > 1) {
          temDistance += distance / 1000;
        }
      }
      listDistance.value = temDistance;
      update();
    }
  }

  void calculateFare() {
    fare.value = packageCost +
        (waitingTime.value * waitingRate) +
        ((totalDistance.value + tunnelDistance.value) * movingRate);
  }

  bool checkTunnel() {
    if (lastPosition == currentPosition) {
      isTunnel.value = true;
      previousPosition = lastPosition;
      return true;
    } else {
      isTunnel.value = false;
      previousPosition = null;
      return false;
    }
  }

  void calculateTunnelDistance() {
    if (previousPosition != null && currentPosition != null) {
      final tempDistance = vincentyDistance(
        previousPosition!.latitude,
        previousPosition!.longitude,
        currentPosition!.latitude,
        currentPosition!.longitude,
      );
      if (tempDistance > 7) {
        tunnelDistance.value += tempDistance / 1000;
      } else if (tempDistance < 7) {
        waitingTime.value += 1;
      }
    }
  }

  @override
  void onClose() {
    // positionStream.cancel();
    super.onClose();
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
}


        // positionStream = Geolocator.getPositionStream().listen((Position post) {
        //   final speed = post.speed;
        //   if (speed > 2 && speed < 25) {
        //     isMoving.value = true;
        //     isMovingRate.value = false;
        //   } else if (speed > 25) {
        //     isMoving.value = true;
        //     isMovingRate.value = true;
        //   } else if (speed < 25 && speed > 2) {
        //     isMovingRate.value = false;
        //     isMoving.value = true;
        //   } else if (speed < 2) {
        //     isMoving.value = false;
        //     isMovingRate.value = false;
        //   }
        // });
        // if (isMoving.value) {
        //   lastPosition = currentPosition;
        //   final temp = await Geolocator.getCurrentPosition();
        //   final newPosition = LatLng(temp.latitude, temp.longitude);
        //   currentPosition.value = newPosition;
        //   positions.add(TunnelSolutionCollection(
        //     positionLatitude: temp.latitude,
        //     positionLongitude: temp.longitude,
        //     timeStamp: DateTime.now(),
        //   ));